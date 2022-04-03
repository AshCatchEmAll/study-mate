import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:wespark_student/app/widgets/progress_button.dart';
import 'package:wespark_student/chat/pages/chat_page.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';
import 'package:wespark_student/home/models/project_form_model.dart';
import 'package:wespark_student/home/models/user_document.dart';
import 'package:wespark_student/home/pages/view_project_details.dart';
import 'package:wespark_student/home/widgets/tags_component.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.userDocument,
    required this.id,
    this.showDetailFooterButtons = true,
  }) : super(key: key);
  final UserDocument userDocument;
  final bool showDetailFooterButtons;
  final String id;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(
        child: Card(
          color: cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              Text(
                userDocument.email,
              style: TextStyle(color: headlineColor,fontSize: 20),
              ),
              Text(userDocument.school, style: TextStyle(color: cardParagraph)),

              Transform.translate(
               offset: Offset(0,25),
                child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ProgressButton(
                        onPressed: () async {
                          try {
                            print(userDocument.uid);
                            await FirebaseChatCore.instance
                                .createUserInFirestore(types.User(
                                    firstName: 'John',
                                    id: FirebaseAuth
                                        .instance.currentUser!.uid));
                            await FirebaseChatCore.instance
                                .createUserInFirestore(
                              types.User(
                                firstName: 'John',
                                id: userDocument.uid.trim(),
                                imageUrl: 'https://i.pravatar.cc/300',
                                lastName: 'Doe',
                              ),
                            );
                            final room = await FirebaseChatCore.instance
                                .createRoom(
                                    types.User(id: userDocument.uid.trim()),
                                    metadata: {'name': 'Chat room'});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          room: room,
                                        )));
                          } catch (e) {
                            print("Error in creating room $e");
                          }
                        },
                        child: const Text(
                          "Chat",
                          style: TextStyle(color: buttonText),
                        )),
                  ),
                ],
              ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class UserCardContent extends StatelessWidget {
  const UserCardContent({
    Key? key,
    required this.title,
    required this.tags,
  }) : super(key: key);
  final String title;
  final List tags;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 4),
              child: Text(
                title,
                textAlign: TextAlign.left,
                textScaleFactor: 1.2,
                style: const TextStyle(
                  fontFamily: "nunito",
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("hey")],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...tags.map((e) {
                        return TagsComponent(
                          color: Color(0xff4e4e4e),
                          tagName: e.toString(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCardTitle extends StatelessWidget {
  const UserCardTitle({
    Key? key,
    required this.weekday,
    required this.date,
  }) : super(key: key);
  final String weekday;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
        color: Color(0xff5C589C),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 8),
                child: Text(
                  weekday,
                  softWrap: true,
                  // textScaleFactor: 2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: "nunito",
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.5, bottom: 7.5, left: 18),
                child: Text(
                  date,
                  textScaleFactor: 1.2,
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
