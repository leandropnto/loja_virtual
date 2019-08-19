import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/tiles/order_tile.dart';
import 'package:loja_virtual/widgets/not_logged.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      return FutureBuilder<QuerySnapshot>(
        future: UserModel.of(context).loadOrders(),
        builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            } else {
              return ListView(
                padding: EdgeInsets.all(8),
                children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
              );
            }


        },
      );
    } else {
      return NotLogged(
        icon: Icon(
            Icons.view_list,
            color: Theme.of(context).primaryColor,
            size: 80,
          ),
        message: 'Faça o login para ver os seus pedidos.',
      );
    }
  }
}
