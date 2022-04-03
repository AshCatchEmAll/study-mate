import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';
import 'package:wespark_student/home/helpers/user_firestore.dart';
import 'package:wespark_student/home/models/user_document.dart';
import 'package:wespark_student/home/widgets/project_card.dart';
import 'package:wespark_student/home/widgets/user_card.dart';

class ViewMatchedUser extends StatefulWidget {
  const ViewMatchedUser({Key? key}) : super(key: key);

  @override
  State<ViewMatchedUser> createState() => _ViewMatchedUserState();
}

class _ViewMatchedUserState extends State<ViewMatchedUser> {
  UserDocument? userDocument;
  bool userVerified = false;
  String cardText = "Please wait for us to verify you";
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () async {
      userDocument = UserDocument.fromJson(await getUserDocument());
 if (userDocument == null || userDocument!.verified == false) {
          userVerified = false;
         
        
        } else {
          userVerified = true;
        }
      setState(() {
       
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userDocument == null
        ? const Center(
          child:  SizedBox(
              height: 50,
              width: 50,
              child: Center(  
                child: CircularProgressIndicator(),
              )),
        )
        : userVerified == true
            ? FirestoreListView<Map<String, dynamic>>(
                query: FirebaseFirestore.instance.collection('Users').where(
                      "school",
                      isEqualTo: userDocument?.school,
                    ),
                // .where("subjects", arrayContains: userDocument?.subjects),
                itemBuilder: (context, snapshot) {
                  Map<String, dynamic> user = snapshot.data();
                  print("User: $user");

                  final userDoc = UserDocument.fromJson(user);
                  if (userDoc.email == userDocument?.email) {
                    return const SizedBox.shrink();
                  } else {
                    return SizedBox(
                     
                      height: 100,
                      child: Center(
                        child: UserCard(
                          id: userDoc.uid,
                          userDocument: userDoc,
                        ),
                      ),
                    );
                  }
                },
              )
            : Center(
                child: Card(
                  color: cardColor,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text("Please wait for us to verify you",style: TextStyle(color: Colors.white),),
                    )
                  ]),
                ),
              );
  }
}
