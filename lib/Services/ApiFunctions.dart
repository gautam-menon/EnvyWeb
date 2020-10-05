import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiFunctions {
  String getEditorsUrl = "";
  Future getEditors() async {
    var response = await http.get(getEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getBasicOrders() async {
    var response = await http.get("url");
    var data = json.decode(response.body);
    return data;
  }

  Future getPremiumOrders() async {
    var response = await http.get("url");
    var data = json.decode(response.body);
    return data;
  }

  Future getProOrders() async {
    var response = await http.get("url");
    var data = json.decode(response.body);
    return data;
  }
}
