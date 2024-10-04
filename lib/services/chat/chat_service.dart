import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_app/model/message.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //send msgs
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    String currentUserUsername = await _fetchUsername(currentUserId);

    //create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        senderUsername: currentUserUsername,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    //construct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add new message to database
    await _fireStore
        .collection("chat_Rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

    // Fetch username from Firestore
  Future<String> _fetchUsername(String userId) async {
    DocumentSnapshot userDoc = await _fireStore.collection('users').doc(userId).get();
    return userDoc['username'] ?? 'Unknown User'; // Return username or a default value
  }

  //get msgs
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection("chat_Rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  //delete message
  Future<void> deleteMessage(String chatRoomId, String messageId) async {
    try {
      await _fireStore
          .collection("chat_Rooms")
          .doc(chatRoomId)
          .collection("messages")
          .doc(messageId)
          .delete();
    } catch (e) {
      print("Error deleting message: $e");
    }
  }
}
