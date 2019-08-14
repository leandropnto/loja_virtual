import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];

  static CartModel of(BuildContext context){
    return ScopedModel.of<CartModel>(context);
  }

  CartModel({this.user});

  void addCartItem(CartProduct cartProduct) async {
    products.add(cartProduct);
    var documentReference = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap());

    cartProduct.cid = documentReference.documentID;
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) async {
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }
}
