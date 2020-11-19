import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiFunctionsAdmin {
  String getAllEditorsUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllEditors";
  String getAllBasicEditorsUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllBasicEditors";
  String getAllPremiumEditorsUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllPremiumEditors";
  String getAllProEditorsUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllProEditors";
  String assignToEditorUrl =
      "https://envytestserver.herokuapp.com/AdminPage/AssignToEditor";
  String getAllAssignedOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllAssignedOrders";
  String getAllOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllOrders";
  String getAllUnassignedOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetAllUnassignedOrders";
  String addEditorUrl =
      "https://envytestserver.herokuapp.com/EditorPage/AddEditor";

  Future addEditor(String name, String email, String tier, int phoneNo) async {
    //TODO: add random uid assigning in web service.
    var response = await http.post(addEditorUrl, body: {
      "uid": 99,
      "name": name,
      "email": email,
      "tier": tier,
      "phoneNo": phoneNo
    });
    var data = json.decode(response.body);
    return data['status'];
  }

  Future getAllEditors() async {
    var response = await http.get(getAllEditorsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data['req'];
    }
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
    print(data.toString());
    return data;
  }

  Future getAllOrders() async {
    var response = await http.get(getAllOrdersUrl);
    var data = json.decode(response.body);
    return data;
  }

  Future getAllUnassignedOrders() async {
    var response = await http.get(getAllUnassignedOrdersUrl);
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data'];
    }
  }
}
