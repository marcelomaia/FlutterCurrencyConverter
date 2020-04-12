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
  double dolar;
  double euro;

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
                  dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            size: 150,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Reais',
                                border: OutlineInputBorder(),
                                prefix: Text('R\$ ')),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Dólares',
                                border: OutlineInputBorder(),
                                prefix: Text('\$ ')),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Euro',
                                border: OutlineInputBorder(),
                                prefix: Text('€ ')),
                          )
                        ],
                      ));
                }
            }
          },
        ));
  }
}
