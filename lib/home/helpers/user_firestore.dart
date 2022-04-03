import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

Future<bool> checkIfDocumentsAdded() async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('checkIfDocumentSubmitted');
  final results = await callable();
  bool docSubmitted = results.data;  
  return docSubmitted;// ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
}

Future sendSignUpRequest(String projectID) async {
  var check = await FirebaseFirestore.instance
      .collection("SignUpRequest")
      .where("student", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("project", isEqualTo: projectID)
      .limit(1)
      .get();
  if (check.docs.length == 0) {
    await FirebaseFirestore.instance.collection("SignUpRequest").add({
      "student": FirebaseAuth.instance.currentUser!.uid,
      "project": projectID,
      "createdAt": DateTime.now()
    });
    return false;
  } else {
    return true;
  }
}


Future getUserDocument()async{
  try{
    var user = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    print(user.data());
  return user.data() as Map<String,dynamic>;
  }catch(e){
    print("getting in user document $e");
  }
  
}