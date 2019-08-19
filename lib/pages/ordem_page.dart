import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  final String orderId;

  OrderPage(this.orderId);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido Realizado'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: primaryColor,
              size: 80,
            ),
            Text(
              'Pedido realizado com sucesso',
              style: headerStyle,
            ),
            Text('Código do pedido: $orderId', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
