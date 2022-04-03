import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              var studentDoc = snapshot.data!.data() as Map<String, dynamic>;
              return ProfileComponent(
                email: studentDoc["email"],
                school: studentDoc["school"],
                subjects: studentDoc["subjects"],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class ProfileComponent extends StatelessWidget {
  ProfileComponent({
    Key? key,
    required this.email,
    required this.school,
    required this.subjects,
  }) : super(key: key);
  final String email;

  final String? school;
  final List subjects;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 350.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "School : ${school}",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontStyle: FontStyle.normal,
                      fontSize: 28.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                school == null
                    ? TextField(
                        controller: descCtrl,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(33, 33, 33, 0.08),
                            hintText: 'Enter your school',
                            filled: true,
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      )
                    : Text(
                        school.toString(),
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(primary: Colors.redAccent),
        //     onPressed: () {

        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         "Contact me",
        //         style: TextStyle(fontSize: 20),
        //       ),
        //     )),
      ],
    );
  }
}
