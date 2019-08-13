import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/category_page.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon']),
      ),
      title: Text(snapshot.data['title']),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        print(snapshot.data['title']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryPage(
                  snapshot: snapshot,
                )));
      },
    );
  }
}
