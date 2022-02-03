import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';

abstract class GetUserState{}


class InitUser extends GetUserState{}
class FetchingUser extends GetUserState{}
class UserFetch extends GetUserState{
  final List<UserModel> userList;
  UserFetch({required this.userList});
}
class FetchingError extends GetUserState{}