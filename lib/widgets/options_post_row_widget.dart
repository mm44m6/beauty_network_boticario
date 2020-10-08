import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class PostOptionsRowWidget extends StatelessWidget {
  final HomeControllerInterface _homeController;
  final String documentId;
  final Function handleChanges;
  final Function enterEditState;

  PostOptionsRowWidget(
    this._homeController, {
    this.documentId,
    this.handleChanges,
    this.enterEditState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.edit, size: 20),
              onPressed: () => enterEditState(),
            ),
          ),
          IconButton(
            onPressed: () => {
              _homeController.deletePost(documentId),
              handleChanges(),
            },
            icon: Icon(Icons.delete, size: 20),
          )
        ],
      ),
    );
  }
}
