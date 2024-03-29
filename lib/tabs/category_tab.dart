import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('products').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var divideTiles = ListTile.divideTiles(
              tiles: snapshot.data.documents
                  .map((doc) => CategoryTile(doc))
                  .toList(),
              color: Colors.grey[500])
              .toList();

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView(
              children: divideTiles,
            ),
          );
        }
      },
    );
  }
}
