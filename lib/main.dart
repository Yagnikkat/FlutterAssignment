import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/blocs/get_user/get_user_bloc.dart';
import 'package:flutter_assignments/ui/LandingPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buisness_logic/blocs/auth_bloc/authe_state.dart';
import 'buisness_logic/blocs/auth_bloc/authentication_bloc.dart';
import 'buisness_logic/blocs/get_user/get_user_state.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(create: (context) => AuthCubit(AuthInit()),),
      BlocProvider<UsersCubit>(create: (context) => UsersCubit(InitUser()),)
    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black,))
        // primarySwatch: Colors.blue,
      ),
      home:LandingPage(),
    ));
  }
}
