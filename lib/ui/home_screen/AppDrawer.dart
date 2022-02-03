import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/blocs/authentication_bloc.dart';
import 'package:flutter_assignments/ui/profile_screen/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthCubit>(context,listen: false);
    return Material(color: Colors.transparent,child: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width*.7,
      child: Column(children: [
        Hero(
            tag: 'profile',
            child: Container(
              width:  MediaQuery.of(context).size.width*0.7,
                height: MediaQuery.of(context).size.height *.35,
                child: Stack(children: [
                  Center(child: Image.network(bloc.userModel.profilePicURL!,fit: BoxFit.cover,)),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(bloc.userModel.name!,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),))
                ],),),),


        ListTile(leading: Icon(Icons.person,color: Colors.black,),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(bloc.userModel),)),
        title: Text('My Profile'),trailing: Icon(Icons.keyboard_arrow_right_sharp,color: Colors.black,),),
        Divider(),

        ListTile(leading: Icon(Icons.settings,color: Colors.black,),
        title: Text('Setting'),trailing: Icon(Icons.keyboard_arrow_right_sharp,color: Colors.black,),),
        Divider(),

        ListTile(leading: Icon(Icons.login,color: Colors.black,),
        title: Text('Logout'),trailing: Icon(Icons.keyboard_arrow_right_sharp,color: Colors.black,),),
        Divider(),

      ],),
      ),);
  }
}
