import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(AuthState initialState) : super(initialState);

  // GoogleSignInAccount? currentUser;
  String contactText = '';
  UserModel userModel = UserModel();


  init(){
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      emit(LoggedIn());
      userModel = UserModel(name: account!.displayName ?? '',email: account.email ?? '',profilePicURL: account.photoUrl ?? '');

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



  // String? _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic>? connections = data['connections'];
  //   final Map<String, dynamic>? contact = connections?.firstWhere(
  //         (dynamic contact) => contact['names'] != null,
  //     orElse: () => null,
  //   );
  //   if (contact != null) {
  //     final Map<String, dynamic>? name = contact['names'].firstWhere(
  //           (dynamic name) => name['displayName'] != null,
  //       orElse: () => null,
  //     );
  //     if (name != null) {
  //       return name['displayName'];
  //     }
  //   }
  //   return null;
  // }

  Future<void> _handleSignIn() async {

  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String> ['email',"https://www.googleapis.com/auth/userinfo.profile"],
  );
}