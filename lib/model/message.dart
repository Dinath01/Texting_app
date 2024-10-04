import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String senderUsername;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.senderUsername,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}