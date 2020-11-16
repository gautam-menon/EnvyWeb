import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiFunctionsAdmin {
  String getAllEditorsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllEditors";
  String getAllBasicEditorsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllBasicEditors";
  String getAllPremiumEditorsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllPremiumEditors";
  String getAllProEditorsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllProOrders";
  String assignToEditorUrl =
      "https://envytestserver.herokuapp.com/EditorPage/AssignToEditor";
  String getAllAssignedOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllProOrders";
  String getAllOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllProOrders";
  String getAllUnassignedOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetAllProOrders";

  Future getAllEditors() async {
    var response = await http.get(getAllEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllBasicEditors() async {
    var response = await http.get(getAllBasicEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllPremiumEditors() async {
    var response = await http.get(getAllPremiumEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllProEditors() async {
    var response = await http.get(getAllProEditorsUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future assignToEditor(int uid, int orderID) async {
    //change uid to editorID in webservice
    var response = await http
        .post(assignToEditorUrl, body: {"uid": uid, "orderID": orderID});
    var data = json.decode(response.body);
    return data;
  }

  Future getAllAssignedOrders() async {
    var response = await http.get(getAllAssignedOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllOrders() async {
    var response = await http.get(getAllOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllUnassignedOrders() async {
    var response = await http.get(getAllUnassignedOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }
}
