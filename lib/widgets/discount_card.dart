import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite o seu cupom'),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                CartModel.of(context).applyDiscount(
                    coupon: text,
                    validCoupon: (desconto) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Desconto de $desconto% aplicado'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                      return;
                    },
                    invalidCoupon: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.error, color: Colors.white, size: 30),
                            ), 
                            Text('Cupom inválido'),
                          ],
                        ),
                        backgroundColor: Colors.redAccent
                      ));
                      return;
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
