import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){

                final count = model.products.length;
                return Text(
                  "${count ?? 0} ${count == 1 ? "Item" : "Itens"}",
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}