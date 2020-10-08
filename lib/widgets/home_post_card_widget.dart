import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/widgets/edit_post_widget.dart';
import 'package:beauty_network_boticario/widgets/options_post_row_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePostCardWidget extends StatefulWidget {
  final DocumentSnapshot document;
  final UserStore user;
  final HomeControllerInterface _homeController;
  final Function handleChanges;

  HomePostCardWidget(this._homeController,
      {this.document, this.user, this.handleChanges});

  @override
  _HomePostCardWidgetState createState() => _HomePostCardWidgetState();
}

class _HomePostCardWidgetState extends State<HomePostCardWidget> {
  bool _isEditingStateActive;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _isEditingStateActive = false;
    _textEditingController =
        new TextEditingController(text: widget.document.data()['text']);
    super.initState();
  }

  void _enterEditState() {
    setState(() {
      _isEditingStateActive = true;
    });
  }

  void _leaveEditState() {
    setState(() {
      _isEditingStateActive = false;
      _textEditingController =
          TextEditingController(text: widget.document.data()['text']);
    });
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: _isEditingStateActive
            ? EditPostWidget(
                widget._homeController,
                textEditingController: _textEditingController,
                leaveEditState: _leaveEditState,
                handleChanges: widget.handleChanges,
                documentId: widget.document.id,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(widget.document.data()['user_displayName'],
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                      _verifyPostOwnership()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(widget.document.data()['text'],
                        style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      timeago.format(
                        widget.document.data()['date'].toDate(),
                        locale: 'pt_BR',
                      ),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _verifyPostOwnership() {
    if (widget.document.data()['user_uid'] == widget.user.uid)
      return PostOptionsRowWidget(
        widget._homeController,
        documentId: widget.document.id,
        handleChanges: widget.handleChanges,
        enterEditState: _enterEditState,
      );
    return Container();
  }
}
