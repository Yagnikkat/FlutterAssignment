import 'dart:convert';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authe_state.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authentication_bloc.dart';
import 'package:flutter_assignments/repository/firebase_repo.dart';
import 'package:flutter_assignments/ui/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import "package:http/http.dart" as http;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {

    // FirebaseRepo.initializeFirebase();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
    BlocProvider.of<AuthCubit>(context,listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (cubit, state) {
          // if(state s
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/splashScreen.jpg'),fit: BoxFit.fitHeight)),
            child: Stack(
              children: [

                Image.asset('assets/splashScreen.jpg',fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height,),
                Spacer(flex: 1,),

                Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context,listen: false).initLogin().then((value) {
                        if(value){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                        }
                      });
                    },
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade100,
                        ),
                        child: state is LoginIn ? const Center(child: CupertinoActivityIndicator()) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/googleLogo.png',
                              scale: 5.0,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Login with google',
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.center,
                    child: Text('Welcome to Social',style: TextStyle(fontSize: 25,color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),

              ],
            ),
          );
        }),
      )
    );
  }
}
