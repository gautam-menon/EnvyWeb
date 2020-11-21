import 'dart:convert';
import 'package:envyweb/Models/EditorModel.dart';
import 'package:http/http.dart' as http;

import 'Auth.dart';

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
      "https://envytestserver.herokuapp.com/AdminPage/AddEditor";
  String loginCheckUrl =
      "https://envytestserver.herokuapp.com/AdminPage/loginCheck";

  Future addEditor(String name, String email, String password, String tier,
      String phoneNo) async {
    String uid = await AuthService().createAccount(email, password);
    if (uid == null) {
      return {"status": false, "req": "Firebase error"};
    }
    var body = {
      "uid": uid,
      "name": name,
      "email": email,
      "tier": tier,
      "phoneNo": phoneNo
    };
    print(body);
    var response = await http.post(addEditorUrl, body: body);
    print(response);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return {"status": false};
    }
  }

  Future getAllEditors() async {
    var response = await http.get(getAllEditorsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
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

  Future<bool> assignToEditor(String uid, orderID, tier) async {
    var body = {"uid": uid, "orderID": orderID, "tier": tier};
    var response = await http.post(assignToEditorUrl, body: body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['status'];
    } else {
      return false;
    }
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
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data'];
    }
  }

  Future<UserModel> loginCheck(String uid) async {
    var response = await http.post(loginCheckUrl, body: {"uid": uid});
    UserModel data = UserModel.fromJson(json.decode(response.body));
    return data;
  }
}
