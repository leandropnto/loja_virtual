import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  
  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  static CartModel of(BuildContext context) {
    return ScopedModel.of<CartModel>(context);
  }

  CartModel({this.user}) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

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

  void decProduct(CartProduct cartProduct) async {
    cartProduct.quantity--;
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) async {
    cartProduct.quantity++;
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItens() async {
    var querySnapshot = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    products = querySnapshot.documents
        .map((doc) => CartProduct.fromDocument(doc))
        .toList();

    notifyListeners();
  }

  void applyDiscount(
      {String coupon,
      VoidCallback validCoupon(int desconto),
      VoidCallback invalidCoupon}) async {
    var documentSnapshot =
        await Firestore.instance.collection('coupons').document(coupon).get();
    if (documentSnapshot.data != null) {
      final int percentage = documentSnapshot.data['percent'];
      this.couponCode = coupon;
      this.discountPercentage = percentage;
      validCoupon(percentage);
    } else {
      this.couponCode = null;
      this.discountPercentage = 0;
      invalidCoupon();

    }
  }

  double getProductsPrice() {
    return  products.where( (product) => product.productData != null)
      .fold( 0.0 , (total, product) => total + product.quantity * product.productData.price ) ?? 0.0;
  }

  double getShipPrice(){
    return 9.99;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  void updatePrices() {
    notifyListeners();
  }

  void finishOrder() {
    if (products.length == 0) return;

    isLoading = true;
    notifyListeners();

  }
}
