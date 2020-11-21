class UserModel {
  String uid;
  String name;
  String email;
  String tier;
  int phoneNo;
  int role; //0 for admin, 1 for editor.

  UserModel(
      this.uid, this.name, this.email, this.tier, this.phoneNo, this.role);

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    tier = json['tier'];
    phoneNo = int.parse(json['phoneNo']);
    role = int.parse(json['role']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['tier'] = this.tier;
    data['phoneNo'] = this.phoneNo;
    data['role'] = this.role;
    return data;
  }
}
