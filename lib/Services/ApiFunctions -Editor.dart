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

  String getWorkOrdersUrl =
      "https://envytestserver.herokuapp.com/EditorPage/GetWorkOrders";

  Future<bool> orderConfirmation(bool value, String orderID) async {
    var response = await http.post(confirmationUrl,
        body: {"confirmation": value, "orderID": orderID});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['status'];
    } else {
      return false;
    }
  }

  Future getEditorDetails(int uid) async {
    var response = await http.post(getOrderDetailsUrl, body: {"uid": uid});
    var data = json.decode(response.body);
    return data;
  }

  Future getOrderDetails(String orderID) async {
    var response =
        await http.post(getOrderDetailsUrl, body: {"orderID": orderID});
    var data = json.decode(response.body);
    return data['req'];
  }

  Future submitOrder(String base64image, int orderID, int editorID) async {
    var response = await http.post(submitOrderUrl,
        body: {"image": base64image, "orderID": orderID, "editorID": editorID});
    var data = json.decode(response.body);
    return data['status'];
  }

  Future getWorkOrders(String uid) async {
    var response = await http.post(getWorkOrdersUrl, body: {"uid": uid});
    var data = json.decode(response.body);
    print(data);
    return data['req'];
  }
}
