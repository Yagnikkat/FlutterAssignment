import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';

class AuthRepo {
  AuthRepo();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel model) async {
    // Call the user's CollectionReference to add a new user
    List<UserModel> listOfUser = await getUser();
    if(listOfUser.isEmpty){
      return users.add({
        'name': model.name, // John Doe
        'email': model.email, // Stokes and Sons
        'profile': model.profilePicURL // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }else {
      if(!isUserExist(model.email!,listOfUser)) {
        return users.add({
          'name': model.name, // John Doe
          'email': model.email, // Stokes and Sons
          'profile': model.profilePicURL // 42
        })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }}
  }

  bool isUserExist(String email, List<UserModel> listOfUser){
    for (var element in listOfUser) {
      if(element.email == email)
        {
          return true;
        }
    }
    return false;
  }

  Future<List<UserModel>> getUser() async {
    final value = await users.get();
    final allData = value.docs.map((doc) => doc.data()).toList();
    List<UserModel> model = [];

    if (allData != null && allData.isNotEmpty) {
      for (var element in allData) {
        UserModel userModel = UserModel.fromJson(element as Map<String, dynamic>);
        model.add(UserModel(
          profilePicURL: userModel.profilePicURL,
          email: userModel.email,
          name: userModel.name
        ));
      }
    }

    return model;
  }
}
