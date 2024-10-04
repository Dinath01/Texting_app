import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({
    super.key,
    required this.message,
    this.isSender = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSender ? Colors.grey[800] : Colors.grey[600],
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white,fontFamily: 'Monument'),
        ),
      ),
    );
  }
}
