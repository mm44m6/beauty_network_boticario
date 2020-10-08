import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/viewmodels/create_post_view_model.dart';
import 'package:beauty_network_boticario/widgets/post_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostWidget extends StatelessWidget {
  static final _createNewPostFormKey = new GlobalKey<FormState>();
  final HomeControllerInterface _homeController;
  final UserStore user;
  final Function handleChanges;

  CreatePostWidget(
    this._homeController, {
    this.user,
    this.handleChanges,
  });

  final CreatePostViewModel _postModel = new CreatePostViewModel();
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Form(
            key: _createNewPostFormKey,
            child: PostTextFormField(
              textEditingController: _textEditingController,
              onSavedFunction: (value) => {_postModel.text = value},
            ),
          ),
          FlatButton(
            minWidth: double.infinity,
            color: Theme.of(context).accentColor,
            onPressed: () async {
              if (_createNewPostFormKey.currentState.validate()) {
                _createNewPostFormKey.currentState.save();
                try {
                  _postModel.userDisplayName = user.displayName;
                  _postModel.userUid = user.uid;
                  await _homeController.createNewPost(_postModel);
                  _textEditingController.clear();
                  handleChanges();
                } catch (error) {
                  print(error);
                }
              }
            },
            child: Text(
              'Postar',
              style: TextStyle(color: ColorThemeSwatch.boticarioWhite),
            ),
          )
        ],
      ),
    );
  }
}
