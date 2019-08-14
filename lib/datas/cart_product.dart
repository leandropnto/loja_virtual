import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  String cid; //cart id
  String category;
  String pid; //product id
  int quantity;
  String size;

  CartProduct();

  ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data['category'];
    pid = document.data['pid'];
    quantity = document.data['quantity'];
    size = document.data['size'];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "quantity": quantity,
      "pid": pid,
      "size": size,
      //"product": productData.toResumeMap()
    };
  }
}
