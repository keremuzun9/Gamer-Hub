class FriendModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? birthdate;
FriendModel({this.id, this.name, this.email, this.gender, this.birthdate});

FriendModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthdate;
    return data;
  }
}