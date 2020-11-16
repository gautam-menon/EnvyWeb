import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiFunctionsEditors {
  String confirmationUrl = "https://envytestserver.herokuapp.com/EditorPage/OrderConfirmation";
  
  Future orderConfirmation(bool value, int uid, orderID) async {
    var response = await http.post(confirmationUrl, body: {
      "confirmation": value,
      "editorID": uid,
      "orderID": orderID
    });
    var data = json.decode(response.body);
    return data;
  }
  getEditorDetails(){}

  getOrderDetails(){}

  submitOrder(){}

  addEditor(){}
  
  getWorkOrders(){}

}
