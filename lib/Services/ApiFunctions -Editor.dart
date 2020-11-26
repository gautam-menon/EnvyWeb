import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiFunctionsEditors {
  String confirmationUrl =
      "https://envytestserver.herokuapp.com/EditorPage/OrderConfirmation";
  String getEditorDetailsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetEditorDetails";
  String getOrderDetailsUrl =
      "https://envytestserver.herokuapp.com/EditorPage/showOrderDetails";
  String submitOrderUrl =
      "https://envytestserver.herokuapp.com/EditorPage/SubmitOrder";

  String getUnconfirmedWorkOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetUnconfirmedWorkOrders";

  String getconfirmedWorkOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetconfirmedWorkOrders";

  Future<bool> orderConfirmation(bool value, String orderID) async {
    var body = json.encode({"confirmation": value, "orderID": orderID});
    print(body);
    var response = await http.post(confirmationUrl,
        body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data['status'];
    } else {
      return false;
    }
  }

  Future getEditorDetails(String uid) async {
    var response = await http.post(getOrderDetailsUrl, body: {"uid": uid});
    var data = json.decode(response.body);
    return data;
  }

  Future getOrderDetails(String orderID) async {
    var response =
        await http.post(getOrderDetailsUrl, body: {"orderID": orderID});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data['req'];
    } else {
      return false;
    }
  }

  // Future submitOrder(String base64image, int orderID, int editorID) async {
  //   var response = await http.post(submitOrderUrl,
  //       body: {"image": base64image, "orderID": orderID, "editorID": editorID});
  //   var data = json.decode(response.body);
  //   return data['status'];
  // }

  Future getUnconfirmedWorkOrders(String uid) async {
    var response =
        await http.post(getUnconfirmedWorkOrdersUrl, body: {"uid": uid});
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

  Future getconfirmedWorkOrders(String uid) async {
    print(uid);
    var response =
        await http.post(getconfirmedWorkOrdersUrl, body: {"uid": uid});
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
}
