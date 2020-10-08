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
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.edit, size: 16),
            onPressed: () => enterEditState(),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () => {
              _homeController.deletePost(documentId),
              handleChanges(),
            },
            icon: Icon(Icons.delete, size: 16),
          )
        ],
      ),
    );
  }
}
