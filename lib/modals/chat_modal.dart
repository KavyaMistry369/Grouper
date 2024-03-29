import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_Modal{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Chat_Modal({required this.timestamp,required this.message,required this.receiverId,required this.senderEmail,required this.senderId}){}

  Map<String,dynamic>toMap(){
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'message':message,
      'timestamp':timestamp,
    };
  }

}