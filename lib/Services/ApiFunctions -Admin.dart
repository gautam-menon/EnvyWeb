import 'dart:convert';
import 'package:envyweb/Models/UserModel.dart';
import 'package:http/http.dart' as http;

import 'Auth.dart';

class ApiFunctionsAdmin {
  String baseUrl = "https://envytestserver.herokuapp.com";
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
  String getBasicOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetBasicOrders";
  String getPremiumOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetPremiumOrders";
  String getProOrdersUrl =
      "https://envytestserver.herokuapp.com/AdminPage/GetProOrders";
  String addEditorUrl =
      "https://envytestserver.herokuapp.com/AdminPage/AddEditor";
  String loginCheckEditorUrl =
      "https://envytestserver.herokuapp.com/AdminPage/loginCheckEditor";
  String loginCheckAdminUrl =
      "https://envytestserver.herokuapp.com/AdminPage/loginCheckAdmin";

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
 Future addAdmin(String name, String email, String password,
      String phoneNo) async {
    String uid = await AuthService().createAccount(email, password);
    if (uid == null) {
      return {"status": false, "req": "Firebase error"};
    }
    var body = {
      "uid": uid,
      "name": name,
      "email": email,
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
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['req'];
      }
    }
  }

  Future getAllBasicEditors() async {
    var response = await http.get(getAllBasicEditorsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['req'];
      }
    }
  }

  Future getAllPremiumEditors() async {
    var response = await http.get(getAllPremiumEditorsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['req'];
      }
    }
  }

  Future getAllProEditors() async {
    var response = await http.get(getAllProEditorsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['req'];
      }
    }
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
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future getAllOrders() async {
    var response = await http.get(getAllOrdersUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future getAllUnassignedOrders() async {
    var response = await http.get(getAllUnassignedOrdersUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future getBasicOrders() async {
    var response = await http.get(getBasicOrdersUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future getPremiumOrders() async {
    var response = await http.get(getPremiumOrdersUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future getProOrders() async {
    var response = await http.get(getProOrdersUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == false) {
        return false;
      } else {
        return data['data'];
      }
    }
  }

  Future<UserModel> loginCheckEditor(String uid) async {
    var response =
        await http.post(loginCheckEditorUrl, body: {"editorId": uid});
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      if (temp['status'] == true) {
        UserModel data = UserModel.fromJson(temp['req']);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<UserModel> loginCheckAdmin(String uid) async {
    var response = await http.post(loginCheckAdminUrl, body: {"editorId": uid});
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      if (temp['status'] == true) {
        UserModel data = UserModel.fromJson(temp['req']);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
