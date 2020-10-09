import 'package:flutter/material.dart';

class PostTextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function onSavedFunction;

  PostTextFormFieldWidget({this.textEditingController, this.onSavedFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      key: new Key('post-text-input'),
      maxLines: 8,
      maxLength: 280,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black54),
        counterStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        labelStyle: TextStyle(color: Colors.black26, fontSize: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        focusColor: Colors.blue,
        fillColor: Colors.blue,
        hintText: "Compartilhe o que você está pensando!",
      ),
      validator: (value) {
        if (value.isEmpty) return 'Não é possivel fazer post vazio!';
        return null;
      },
      onSaved: (value) {
        onSavedFunction(value);
      },
    );
  }
}
