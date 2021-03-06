import 'package:flutter/material.dart';

import '../constants/all_constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 7,
        color: cardColor,
       
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child:
                Text(text, style: cardTextStyle, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}