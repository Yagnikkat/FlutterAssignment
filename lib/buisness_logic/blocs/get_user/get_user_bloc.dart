import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authe_state.dart';
import 'package:flutter_assignments/repository/auth_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'get_user_state.dart';

class UsersCubit extends Cubit<GetUserState>{
  // GetUserCubit(AuthState initialState) : super(initialState);

  // GoogleSignInAccount? currentUser;
  String contactText = '';
  UserModel userModel = UserModel();
  AuthRepo _authRepo = AuthRepo();
  List<UserModel> userList = [];

  UsersCubit(GetUserState initialState) : super(initialState);

  getAllUser() async {
    emit(FetchingUser());
    userList = await _authRepo.getUser();
    emit(UserFetch(userList: userList));
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String> ['email',"https://www.googleapis.com/auth/userinfo.profile"],
  );
}