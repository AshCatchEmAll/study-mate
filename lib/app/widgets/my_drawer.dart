import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wespark_student/activity/pages/student_activity.dart';
import 'package:wespark_student/chat/pages/chat_rooms.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';
import 'package:wespark_student/flashcard/constants/qns_ans.dart';
import 'package:wespark_student/flashcard/pages/flashcard_page.dart';
import 'package:wespark_student/home/pages/home_page.dart';
import 'package:wespark_student/profile/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: cardColor,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff2cb67d),
            ),
            child: Center(child: Text('Study mate',style: TextStyle(fontSize: 25,color:Colors.white),)),
          ),
          ListTile(
              trailing: Icon(Icons.home,color:headlineColor),
            title: const Text('User Board',style: TextStyle(color: headlineColor),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
          ),

          ListTile(
              trailing: Icon(Icons.chat,color:headlineColor),
            title: const Text('Chats',style: TextStyle(color: headlineColor),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RoomsPage();
              }));
            },
          ),
          // ListTile(
          //   title: const Text('Flashcards'),
          //   onTap: () {
          //      Navigator.push(context, MaterialPageRoute(builder: (context){
          //       return FlashCardPage();
          //     }));
          //   },
          // ),
          // ListTile(
          //   title: const Text('Profile'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return ProfilePage();
          //     }));
          //   },
          // ),
          ListTile(
            trailing: Icon(Icons.logout,color:headlineColor),
            title: const Text('Sign Out',style: TextStyle(color: headlineColor),),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
