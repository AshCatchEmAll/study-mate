import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wespark_student/app/widgets/progress_button.dart';
import 'package:wespark_student/flashcard/models/flashcard_model.dart';

import '../components/reusable_card.dart';
import '../constants/all_constants.dart';
import '../constants/qns_ans.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({Key? key, required this.roomID}) : super(key: key);
  final String roomID;
  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  int _currentIndexNumber = 0;
  double _initial = 0.1;

  @override
  Widget build(BuildContext context) {
    String value = (_initial * 10).toStringAsFixed(0);
    return Scaffold(
       
        appBar: AppBar(
            centerTitle: true,
            title: Text("Flashcards", style: TextStyle(fontSize: 30)),
           
           
          
),
        body: FirestoreListView<Map<String, dynamic>>(
          query: FirebaseFirestore.instance
              .collection('rooms')
              .doc(widget.roomID)
              .collection('flashcards'),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> data = snapshot.data();
            FlashCardModel fcm = FlashCardModel.fromJson(data);
                        return 
                        SizedBox(
                          width: 300,
                          height: 300,
                          child:   FlipCard(
                            
                direction: FlipDirection.HORIZONTAL,
                front: ReusableCard(
                  
                    text: fcm.question),
                back: ReusableCard(
                    text: fcm.answer)),
                        );
                      
          },
        ),

        // Center(
        //     child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //       Text("Question $value of 10 Completed", style: otherTextStyle),
        //       SizedBox(height: 20),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: LinearProgressIndicator(
        //           backgroundColor: Colors.white,
        //           valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
        //           minHeight: 5,
        //           value: _initial,
        //         ),
        //       ),
        //       SizedBox(height: 25),
        //       SizedBox(
        //           width: 300,
        //           height: 300,
        //           child: FlipCard(
        //               direction: FlipDirection.VERTICAL,
        //               front: ReusableCard(
        //                   text: quesAnsList[_currentIndexNumber].question),
        //               back: ReusableCard(
        //                   text: quesAnsList[_currentIndexNumber].answer))),
        //       Text("Tap to see Answer", style: otherTextStyle),
        //       SizedBox(height: 20),
        //       Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: <Widget>[
        //             ElevatedButton.icon(
        //                 onPressed: () {
        //                   showPreviousCard();
        //                   updateToPrev();
        //                 },
        //                 icon: Icon(Icons.arrow_left, size: 30),
        //                 label: Text(""),
        //                 style: ElevatedButton.styleFrom(
        //                     primary: mainColor,
        //                     shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(10)),
        //                     padding: EdgeInsets.only(
        //                         right: 20, left: 25, top: 15, bottom: 15))),
        //             ElevatedButton.icon(
        //                 onPressed: () {
        //                   showNextCard();
        //                   updateToNext();
        //                 },
        //                 icon: Icon(Icons.arrow_right, size: 30),
        //                 label: Text(""),
        //                 style: ElevatedButton.styleFrom(
        //                     primary: mainColor,
        //                     shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(10)),
        //                     padding: EdgeInsets.only(
        //                         right: 20, left: 25, top: 15, bottom: 15)))
        //           ])
        //     ],
        //     ),
        //     ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff2cb67d),
          onPressed: () {
            TextEditingController q =  TextEditingController();
            TextEditingController a =  TextEditingController();
           showDialog(context: context, builder: (context){
             return AlertDialog(
               backgroundColor: cardColor,
               title: Text("Add flashcard",style: TextStyle(color: headlineColor),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      style: TextStyle(color: cardParagraph),
                      maxLines: 5,
                      controller: q,
                      decoration: InputDecoration(
                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color:Color(0xff2cb67d))) ,
                        border: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff94a1b2))),
                        hintText: "Question",
                        hintStyle: TextStyle(color:cardParagraph)
                      ),
                    ),
                    TextField(
                        style: TextStyle(color: cardParagraph),
                        maxLines: 5,
                      controller: a,
                      decoration: InputDecoration(
                          focusedBorder:OutlineInputBorder(borderSide: BorderSide(color:Color(0xff2cb67d))) ,
                         border: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff94a1b2))),
                        hintText: "Answer",
                          hintStyle: TextStyle(color:cardParagraph)
                      ),
                    ),
                    ProgressButton(
                      
                      onPressed: ()async{
                      await FirebaseFirestore.instance
                          .collection('rooms')
                          .doc(widget.roomID)
                          .collection('flashcards')
                          .add({
                        'question': q.text,
                        'answer': a.text,
                        'createdAt': FieldValue.serverTimestamp(),
                        'createdBy':FirebaseAuth.instance.currentUser!.uid,

                      });
                      Navigator.pop(context);
                    
                    }, child: Text("Add",style: TextStyle(color:buttonText),))
                  
                  ],
                ),
             );
           });
          },
          child: Icon(FontAwesomeIcons.plus, size: 30),
        ),
        );
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + 0.1;
      if (_initial > 1.0) {
        _initial = 0.1;
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - 0.1;
      if (_initial < 0.1) {
        _initial = 1.0;
      }
    });
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber + 1 < quesAnsList.length)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : quesAnsList.length - 1;
    });
  }
}
