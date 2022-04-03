import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wespark_student/app/widgets/my_drawer.dart';
import 'package:wespark_student/home/pages/view_matched_users.dart';
import 'package:wespark_student/home/widgets/project_board.dart';

import '../../chat/pages/chat_Page.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: MyDrawer(),
      body:    ViewMatchedUser(),
   
    );
  }
}
