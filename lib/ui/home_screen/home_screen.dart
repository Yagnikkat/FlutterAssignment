import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authe_state.dart';
import 'package:flutter_assignments/buisness_logic/blocs/auth_bloc/authentication_bloc.dart';
import 'package:flutter_assignments/buisness_logic/blocs/get_user/get_user_bloc.dart';
import 'package:flutter_assignments/buisness_logic/blocs/get_user/get_user_state.dart';

import 'package:flutter_assignments/ui/home_screen/AppDrawer.dart';
import 'package:flutter_assignments/ui/profile_screen/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late UserModel model;
  bool showSearchBar = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    initListener();
    BlocProvider.of<UsersCubit>(context,listen: false).getAllUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     model = BlocProvider.of<AuthCubit>(context,listen: false).userModel;
    return Scaffold(
      drawer: AppDrawer(),
      key: _key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: showSearchBar? TextFormField(
          controller: controller,
          decoration: InputDecoration(suffixIcon: IconButton(
            onPressed: () {
              showSearchBar = false;
              controller.text ="";
              setState(() {

              });
            },
            icon: Icon(Icons.close),) ,hintText: 'Search User'),) :Text(
          'Hello, ${model.name}',
          style: TextStyle(color: Colors.black,fontSize: 14),
        ),
        actions: [

          !showSearchBar ?IconButton(onPressed: () {
            showSearchBar = true;
            setState(() {

            });
          }, icon:Icon(Icons.search,color: Colors.black,)) :SizedBox.shrink()

        ],
        leading: InkWell(
          onTap: () => _key.currentState?.openDrawer(),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.blue,width: 2)),
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                Center(child: CircleAvatar(backgroundImage: NetworkImage(BlocProvider.of<AuthCubit>(context, listen: false).userModel.profilePicURL!))),
                Positioned(
                  bottom: 6,
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                        child: Icon(Icons.add,size: 12,)))
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            BlocBuilder<UsersCubit, GetUserState>(
              builder: (context, state) {
                if (state is FetchingUser) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserFetch) {
                  return state.userList.isEmpty
                      ? Center(
                          child: Text('No User found'),
                        )
                      : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () {
                            BlocProvider.of<UsersCubit>(context,listen: false).getAllUser();
                            return Future.sync(() => true);
                          },
                          child: ListView.builder(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              itemCount: state.userList.length,

                              itemBuilder: (context, index) {
                                return state.userList[index].name!.startsWith(controller.text) ?Container(
                                  height: 80,
                                  child: ListTile(
                                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>ProfileScreen(state.userList[index],false),)),
                                    leading: Hero(
                                      tag: 'profile',
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(state.userList[index].profilePicURL!),
                                      ),
                                    ),
                                    title: Text(state.userList[index].name!),
                                    subtitle: Text(state.userList[index].email!),
                                  ),
                                ):Container();
                              },
                            ),
                        ),
                      );
                }else {
                  return Container(child: Text('No user found'),);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  initListener(){
    controller.addListener(() {
      if(controller.text.length > 1){
        setState(() {
        });
      }
    });
  }
}
