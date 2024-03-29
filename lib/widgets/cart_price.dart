import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = TextStyle(fontWeight: FontWeight.w500);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child:
            ScopedModelDescendant<CartModel>(builder: (context, child, model) {
          final price = model.getProductsPrice();
          final discount = model.getDiscount();
          final ship = model.getShipPrice();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Resumo do Pedido',
                textAlign: TextAlign.start,
                style: headerStyle,
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Subtotal'),
                  Text('R\$ ${price.toStringAsFixed(2)}'),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Desconto'),
                  Text('- R\$ ${discount.toStringAsFixed(2)}', style: TextStyle(color: Colors.redAccent),),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Entrega'),
                  Text('R\$ ${ship.toStringAsFixed(2)}'),
                ],
              ),
              Divider(),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$ ${(price-discount+ship).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  this.buy();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('Finalizar Pedido'.toUpperCase()),
                    ),
                    Icon(Icons.done_all),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
