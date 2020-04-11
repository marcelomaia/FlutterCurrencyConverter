import 'dart:convert';

import 'package:http/http.dart';

const url = 'https://api.hgbrasil.com/finance?key=c2fd5e69';

Future<Map> getCurrencyData() async {
  Response response = await get(url);
  return json.decode(response.body);
}
