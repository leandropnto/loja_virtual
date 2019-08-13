import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductPage extends StatefulWidget {

  final ProductData product;

  const ProductPage({Key key, this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {

  final ProductData product;

  _ProductPageState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
