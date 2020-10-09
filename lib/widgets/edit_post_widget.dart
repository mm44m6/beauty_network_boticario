import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/widgets/post_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EditPostWidget extends StatelessWidget {
  static final _editPostFormKey = new GlobalKey<FormState>();
  final TextEditingController textEditingController;
  final Function leaveEditState;
  final HomeControllerInterface _homeController;
  final Function handleChanges;
  final String documentId;

  EditPostWidget(this._homeController,
      {this.textEditingController,
      this.leaveEditState,
      this.handleChanges,
      this.documentId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _editPostFormKey,
          child: PostTextFormFieldWidget(
            textEditingController: textEditingController,
            onSavedFunction: (value) {
              print(value);
            },
          ),
        ),
        Row(
          children: [
            FlatButton(
              onPressed: () => {
                if (_editPostFormKey.currentState.validate())
                  {
                    _editPostFormKey.currentState.save(),
                    _homeController.updatePost(
                        documentId, textEditingController.text),
                    leaveEditState(),
                    handleChanges()
                  }
              },
              child: Text('Editar'),
            ),
            FlatButton(
              onPressed: () => leaveEditState(),
              child: Text('Cancelar'),
            )
          ],
        ),
      ],
    );
  }
}
