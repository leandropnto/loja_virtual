import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    final priceStyle = TextStyle(
        color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold);

    final TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.w500, fontSize: 17);

    final TextStyle sizeStyle = TextStyle(fontWeight: FontWeight.w300);

    Widget _buildContent() {
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      cartProduct.productData.title,
                      style: titleStyle,
                    ),
                    Text("Tamanho: ${cartProduct.size}", style: sizeStyle),
                    Text(
                      "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                      style: priceStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: primaryColor,
                          ),
                          onPressed: cartProduct.quantity > 1 ? () {} : null,
                        ),
                        Text(cartProduct.quantity.toString()),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: Text('Remover'),
                          textColor: Colors.grey[500],
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                )),
          ),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
              future: Firestore.instance
                  .collection('products')
                  .document(cartProduct.category)
                  .collection('items')
                  .document(cartProduct.pid)
                  .get())
          : _buildContent(),
    );
  }
}
