import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_app/pages/chat_page.dart';
import 'package:text_app/services/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.grey[400], fontFamily: 'Monument'), // Modern title color
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon:
                Icon(Icons.logout_sharp, color: Colors.grey[400]), // Icon color
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

Widget _buildUserListItem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  if (_auth.currentUser!.email != data['email']) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Add padding around each item
      child: ListTile(
        contentPadding: EdgeInsets.all(10), // Padding inside the ListTile
        tileColor: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent, // Circle color
          child: Text(
            data['email'][0].toUpperCase(), // First letter of the email
            style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Monument'), // Text style for the letter
          ),
        ),
        title: Text(
          data['email'],
          style: TextStyle(color: Colors.white, fontFamily: 'Monument',fontSize: 14),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]), // Right arrow icon
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      ),
    );
  } else {
    return Container();
  }
}
}
