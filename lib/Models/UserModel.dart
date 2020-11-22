class UserModel {
  String uid;
  String name;
  String email;
  String tier;
  int phoneNo;

  UserModel(this.uid, this.name, this.email, this.tier, this.phoneNo);

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    tier = json['tier'];
    phoneNo = int.parse(json['phoneNo']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['tier'] = this.tier;
    data['phoneNo'] = this.phoneNo;

    return data;
  }
}
