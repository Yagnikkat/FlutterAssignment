import 'package:flutter/material.dart';
import 'package:flutter_assignments/buisness_logic/Models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel;
  final bool isMyProfile;
  const ProfileScreen(this.userModel,this.isMyProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Profile',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,leading: BackButton(color: Colors.black,),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  child: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userModel.profilePicURL!),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   isMyProfile ? Text(
                      "Hello,",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ): SizedBox.shrink(),
                    Text(
                      userModel.name!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              userModel.email!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _childWidget(title: '40', value: 'Posts'),
                  _childWidget(title: '100', value: 'Following'),
                  _childWidget(title: '150', value: 'Followers'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultTabController(
                length: 2,
                child: TabBar(
                    labelColor: Colors.black,
                    tabs: [
                  Tab(
                    text: 'Posts',
                  ),
                  Tab(
                    text: 'Video',
                  )
                ]))
          ],
        ),
      ),
    );
  }

  _childWidget({String? title, String? value}) {
    return Container(
      height: 60,
      child: Column(
        children: [
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            value!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          )
        ],
      ),
    );
  }
}
