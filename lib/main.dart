import 'package:currencyconverter/services/hg_finances.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.amber,
      brightness: Brightness.dark,
      accentColor: Colors.pink,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('\$ Converter \$'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getCurrencyData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text('Carregando...'));
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Erro...'));
                } else {
                  return Container(color: Colors.green);
                }
            }
          },
        ));
  }
}
