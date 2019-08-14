import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryPage extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryPage({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      var productData =  ProductData.fromDocument(snapshot.data.documents[index]);
                      productData.category = this.snapshot.documentID;
                      return ProductTile("grid", productData);
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                     itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      var productData =  ProductData.fromDocument(snapshot.data.documents[index]);
                      productData.category = this.snapshot.documentID;
                      return ProductTile("list", productData);
                    },
                  ),
                ],
              );
            }
          },
          future: Firestore.instance
              .collection('products')
              .document(snapshot.documentID)
              .collection('items')
              .getDocuments(),
        ),
      ),
    );
  }
}
