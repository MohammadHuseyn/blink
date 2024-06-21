import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Chat.dart';

class SupportChatRequestScreen extends StatefulWidget {
  @override
  _SupportChatRequestScreenState createState() => _SupportChatRequestScreenState();
}

class _SupportChatRequestScreenState extends State<SupportChatRequestScreen> {
  List<dynamic> _requests = [];

  @override
  void initState() {
    super.initState();
    _fetchChatRequests();
  }

  Future<void> _fetchChatRequests() async {
    final response = await http.get(
      Uri.parse('http://yourapi.com/api/chat-requests/'),
      headers: {
        'Authorization': 'Token your_auth_token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        _requests = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load chat requests');
    }
  }

  Future<void> _acceptRequest(int requestId) async {
    final response = await http.put(
      Uri.parse('http://yourapi.com/api/chat-requests/$requestId/'),
      headers: {
        'Authorization': 'Token your_auth_token',
      },
    );
    if (response.statusCode == 200) {
      final sessionId = json.decode(response.body)['session_id'];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen(sessionId: sessionId)),
      );
    } else {
      throw Exception('Failed to accept chat request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Requests'),
      ),
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_requests[index]['customer']),
            trailing: ElevatedButton(
              child: Text('Accept'),
              onPressed: () => _acceptRequest(_requests[index]['id']),
            ),
          );
        },
      ),
    );
  }
}