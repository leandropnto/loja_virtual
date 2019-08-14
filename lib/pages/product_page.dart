import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/pages/cart_page.dart';
import 'package:loja_virtual/pages/login_page.dart';
import 'package:loja_virtual/widgets/cart_button.dart';

class ProductPage extends StatefulWidget {
  final ProductData product;

  const ProductPage({Key key, this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final ProductData product;

  _ProductPageState(this.product);
  String productSize;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: CartButton(),
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.95,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5),
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            productSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: size == productSize
                                      ? primaryColor
                                      : Colors.grey[500],
                                  width: 3.0)),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    color: primaryColor,
                    onPressed: productSize != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = productSize;
                              cartProduct.quantity = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = product.category;

                              //Adicionar ao carrinho
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? 'Adicionar ao carrinho'
                          : 'Entre para comprar',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Descrição',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
