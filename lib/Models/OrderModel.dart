class OrderModel {
  String orderid;
  String uid;
  int timestamp;
  bool payment;
  String imgUrl;
  int tierid;
  bool isComplete;
  List<Features> features;

  OrderModel(
      {this.orderid,
      this.uid,
      this.timestamp,
      this.tierid,
      this.payment,
      this.imgUrl,
      this.isComplete,
      this.features});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    uid = json['uid'];
    timestamp = json['timestamp'];
    tierid = json['tierid'];
    payment = json['paymentdetails'];
    imgUrl = json['rawbase64'];
    isComplete = json['isComplete'];
  }
}

class Features {
  int id;
  int price;
  String title;
  String description;

  Features({this.id, this.price, this.title, this.description});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    description = json['description'];
  }
}

class Order {
  String orderid;
  String uid;
  String rawBase64;
  String workOrder;
  String editedBase64;
  String timestamp;
  String isComplete;
  String features;
  String tierId;
  String paymentDetails;

  Order(
      {this.orderid,
      this.uid,
      this.rawBase64,
      this.workOrder,
      this.editedBase64,
      this.timestamp,
      this.isComplete,
      this.features,
      this.tierId,
      this.paymentDetails});

  Order.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    uid = json['uid'];
    rawBase64 = json['rawBase64'];
    workOrder = json['workOrder'];
    editedBase64 = json['editedBase64'];
    timestamp = json['timestamp'];
    isComplete = json['isComplete'];
    features = json['features'];
    tierId = json['tierId'];
    paymentDetails = json['paymentDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['uid'] = this.uid;
    data['rawBase64'] = this.rawBase64;
    data['workOrder'] = this.workOrder;
    data['editedBase64'] = this.editedBase64;
    data['timestamp'] = this.timestamp;
    data['isComplete'] = this.isComplete;
    data['features'] = this.features;
    data['tierId'] = this.tierId;
    data['paymentDetails'] = this.paymentDetails;
    return data;
  }
}
