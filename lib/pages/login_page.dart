import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessar Loja'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Cadastrar',
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'E-mail'),
              validator: (text) {
                if (text.isEmpty || !text.contains("@")){
                  return "E-mail inválido";
                }

                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6){
                  return "Senha inválida";
                }

                return null;
              }
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  'Esqueci minha senha',
                  textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18.0),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
