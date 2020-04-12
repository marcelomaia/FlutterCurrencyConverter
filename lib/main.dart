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
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  void onRealChanged(String value) {
    double real = double.parse(value);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void onDollarChanged(String value) {
    double dollar = double.parse(value);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
  }

  void onEuroChanged(String value) {
    double euro = double.parse(value);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
  }

  double dollar;
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
                  dollar = snapshot.data['results']['currencies']['USD']['buy'];
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
                          buildTextField(
                              'Reais', 'R\$', realController, onRealChanged),
                          Divider(),
                          buildTextField('Dollars', '\$', dollarController,
                              onDollarChanged),
                          Divider(),
                          buildTextField(
                              'Euro', '€', euroController, onEuroChanged)
                        ],
                      ));
                }
            }
          },
        ));
  }

  TextField buildTextField(String label, String symbol,
      TextEditingController controller, Function f) {
    return TextField(
      onChanged: f,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefix: Text('$symbol ')),
    );
  }
}
