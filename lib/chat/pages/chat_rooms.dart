import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:wespark_student/chat/pages/chat_Page.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Chat rooms")),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          final rooms = snapshot.data!;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
            

              return Container(
                color: cardColor,
                child: ListTile(
                
                  title: Text(room.name??"Chat with ${room.users.singleWhere((u) => u.id != FirebaseChatCore.instance.firebaseUser?.uid).firstName}",style: TextStyle(color: headlineColor),),
                 subtitle: Text("Last updated : ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMillisecondsSinceEpoch(room.updatedAt!) )}",style: TextStyle(color: cardParagraph),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(room: room),
                      ),
                    );
                  },
                ),
              );
            },
          );
        
        },
      ),
    );
  }
}