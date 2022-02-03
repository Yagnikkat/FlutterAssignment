

import 'dart:convert';

UserModelList userModelListFromJson(String str) => UserModelList.fromJson(json.decode(str));

String userModelListToJson(UserModelList data) => json.encode(data.toJson());

class UserModelList {
  UserModelList({
    this.userModel,
  });

  List<UserModel>? userModel;

  factory UserModelList.fromJson(Map<String, dynamic> json) => UserModelList(
    userModel: List<UserModel>.from(json["UserModel"].map((x) => UserModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserModel": List<dynamic>.from(userModel!.map((x) => x.toJson())),
  };
}

class UserModel {
  UserModel({
    this.name,
    this.profilePicURL,
    this.email,
  });

  String? name;
  String? profilePicURL;
  String? email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    profilePicURL: json["profile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile": profilePicURL,
    "email": email,
  };
}
