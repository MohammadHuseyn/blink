import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global.dart' as global;
class CustomerChatRequestScreen extends StatefulWidget {
  @override
  _CustomerChatRequestScreenState createState() => _CustomerChatRequestScreenState();
}

class _CustomerChatRequestScreenState extends State<CustomerChatRequestScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Support'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendChatRequest,
          child: Text('Request Chat Support'),
        ),
      ),
    );
  }

  void _sendChatRequest() {
    global.postRequest({},'/chat-requests/');
  }
}