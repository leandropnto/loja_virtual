import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingTile extends StatelessWidget {
  final DocumentSnapshot document;

  ShoppingTile(this.document);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var botaoStyle = TextStyle(color: primaryColor);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            document.data['image'],
            height: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: Text(
              document.data['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              document.data['address'],
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.map,
                      color: primaryColor,
                      size: 20,
                    ),
                    Text(
                      'Ver no Mapa',
                      style: botaoStyle,
                    ),
                  ],
                ),
                onPressed: () {
                  launch("https://www.google.com/maps/search/?api=1&query=${document.data['lat']},${document.data['long']}");
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: primaryColor,
                      size: 20,
                    ),
                    Text(
                      'Ligar',
                      style: botaoStyle,
                    ),
                  ],
                ),
                onPressed: () {
                  launch("tel:${document.data['tel']}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
