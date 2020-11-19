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

  Features.fromJson(Map<String, dynamic> json){
    id =json['id'];
    price =json['price'];
    title =json['title'];
    description = json['description'];
  
  }
}
