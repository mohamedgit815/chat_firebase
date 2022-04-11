import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String text , id,subText , subChat;
  final Timestamp date;

  const ChatModel({
    required this.date ,required this.text ,
    required this.id ,required this.subText , required this.subChat
  });

  factory ChatModel.fromApp(Map<String,dynamic>map){
    return ChatModel(
        text: map['text'],
        date: map['date'] ,
        id: map['id'] ,
        subText: map['subText'],
        subChat: map['subUser'],
    );
  }

  Map<String,dynamic> toApp()=>{
    'text' : text ,
    'date' : date ,
    'id': id ,
    'subText': subText
  };
}