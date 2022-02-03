import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authe_state.dart';
import 'package:flutter_assignments/repository/auth_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(AuthState initialState) : super(initialState);

  // GoogleSignInAccount? currentUser;
  String contactText = '';
  UserModel userModel = UserModel();
  AuthRepo _authRepo = AuthRepo();
  List<UserModel> userList = [];


  init(){
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      emit(LoggedIn());
      userModel = UserModel(name: account!.displayName ?? '',email: account.email ,profilePicURL: account.photoUrl ?? '');
       _authRepo.addUser(userModel);
    });
    _googleSignIn.signInSilently();
  }

  Future<bool> initLogin() async {
    emit(LoginIn());
    try {
      await _googleSignIn.signIn();
      emit(LoggedIn());
      return true;
    } catch (error) {
      emit(LoginError());
      print(error);
      return false;
    }
  }

  getAllUser() async {

    userList = await _authRepo.getUser();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String> ['email',"https://www.googleapis.com/auth/userinfo.profile"],
  );
}