import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authe_state.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authentication_bloc.dart';
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
    BlocProvider.of<AuthCubit>(context,listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (cubit, state) {
          // if(state s
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context,listen: false).initLogin().then((value) {
                      if(value){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                      }
                    });
                  },
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
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
