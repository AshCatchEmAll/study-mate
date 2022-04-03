import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wespark_student/auth/pages/landing_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         // 
  //         );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
                 inputDecorationTheme: InputDecorationTheme(
                   focusedBorder:OutlineInputBorder(borderSide: BorderSide(color:Color(0xff2cb67d))) ,
                   labelStyle: TextStyle(color:Colors.white),
                   
                   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2cb67d)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            
           
          ),
        ),
      textTheme: TextTheme(headline5: TextStyle(color:Colors.white), subtitle1: TextStyle(color: Colors.white),),
          scaffoldBackgroundColor: Color(0xff242629),
          backgroundColor: Color(0xff242629),
          buttonTheme:ButtonThemeData(buttonColor: Color(0xff7f5af0), textTheme: ButtonTextTheme.primary,),
          appBarTheme: AppBarTheme(color: Color(0xff2cb67d)),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LandingPage());
  }
}

