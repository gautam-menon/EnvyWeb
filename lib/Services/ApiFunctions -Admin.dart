import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiFunctionsAdmin {
  String getAllEditorsUrl = "";
  String getBasicOrdersUrl = "";
  String getPremiumOrdersUrl = "";
  String getProOrdersUrl = "";
  Future getAllEditors() async {
    var response = await http.get(getAllEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllBasicEditors() async {
    var response = await http.get(getBasicOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllPremiumEditors() async {
    var response = await http.get(getPremiumOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllProEditors() async {
    var response = await http.get(getProOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  assignToEditor() {}

  getAllAssignedOrders() {}

  getAllOrders(){}

  getAllUnassignedOrders(){}
}
