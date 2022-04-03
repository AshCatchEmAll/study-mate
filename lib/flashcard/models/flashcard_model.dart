import 'package:cloud_firestore/cloud_firestore.dart';

class FlashCardModel{

  FlashCardModel({ required this.question,required  this.answer,required this.createdBy,required this.createdAt});
  final String question;
  final String answer;
  final String createdBy;
  final DateTime createdAt;

  factory FlashCardModel.fromJson(Map<String, dynamic> json) {
    return FlashCardModel(
      question: json['question'] as String,
      answer: json['answer'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'createdBy': createdBy,
      'createdAt':  Timestamp.fromDate( createdAt),
    };
  }
}