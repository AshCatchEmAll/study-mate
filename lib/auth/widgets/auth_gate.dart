import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';
import 'package:wespark_student/home/pages/home_page.dart';



class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
        
          
          
          return SignInScreen(
            
              sideBuilder: (context, constraints) {
                return  const Center(
                  child:  Padding(
                    padding:  EdgeInsets.all(20),
                    child:Text("Study Mate 📖",style: TextStyle(fontSize: 30,color:headlineColor),),
                  ),
                );
              },
              headerBuilder: (context, constraints, shrinkOffset) {
                return const Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(aspectRatio: 1, child: Text("✨")),
                );
              },
              
              providerConfigs: [EmailProviderConfiguration()]);
        }

        // Render your application if authenticated
        return HomePage();
      },
    );
  }

  Future getAuth() async {
    return FirebaseAuth.instance.currentUser;
  }
}
