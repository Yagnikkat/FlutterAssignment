import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authe_state.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authentication_bloc.dart';
import 'package:flutter_assignments/ui/home_screen/AppDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _key =GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // bloc = BlocProvider.of<AuthCubit>(context,listen: false);
    return BlocBuilder<AuthCubit,AuthState>(
      builder: (context, state) => Scaffold(
        drawer: AppDrawer(),
        key: _key,
        backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Discovery',style: TextStyle(color: Colors.black),),
        leading: InkWell(
          onTap: () => _key.currentState?.openDrawer(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Hero(
              tag: 'profile',
              child: CircleAvatar(
                backgroundImage: NetworkImage(BlocProvider.of<AuthCubit>(context,listen: false).userModel.profilePicURL!)),
            ),
          ),
        ),),
        body: Container(),
    ),);
  }
}
