import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../global.dart' as global;

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required this.isAdmin});
  bool isAdmin;
  @override
  State<ChatPage> createState() => _ChatPageState(isAdmin: isAdmin);
}

List<Widget> messages = [];
var controller = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  Timer? timer;
  bool wait = true;
  bool isAdmin;
  _ChatPageState({required this.isAdmin});
  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    if (!isAdmin) {
      await global.postRequest({}, "/chat/start_room");
      await global.wait(1000);
    }
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _viewMessages());
    _viewMessages();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // messages.add(chatBox(false, "شروع مکالمات"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF256F46),
      ),
      body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/chat_background.png"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  children: messages,
                ),
              ),
            ),
          ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                            hintText: "نوشتن پیام",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const ImageIcon(
                                AssetImage("images/send-message.png"),
                              ),
                              iconSize: 40,
                              color: const Color(0xFF256f46),
                              onPressed: () {
                                _sendMessage(controller.text);
                                controller.clear();
                              },
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF256F46),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 12,
                        blurRadius: 10,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget chatBox(bool support, String text) {
    if (support) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: const Color(0xFF2E8B57),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'shabnam', fontSize: 25, color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, right: 10),
            child: Image.asset(
              "images/account.png",
              width: MediaQuery.of(context).size.width * 0.18,
            ),
          )
        ],
      );
    } else {
      return Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 10),
              child: Image.asset(
                "images/account.png",
                width: MediaQuery.of(context).size.width * 0.18,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'shabnam',
                    fontSize: 25,
                    color: Colors.green[800]),
                textAlign: TextAlign.right,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: const Color(0xFFEAF3EE),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ],
        ),
      );
    }
  }

  void _sendMessage(String text) {
    global.postRequest({"message": text}, "/chat/send_message");
    _viewMessages();
  }

  Future<void> _viewMessages() async {
    var res = await global.getRequest("/chat/view_message");
    List<Map<String, dynamic>> data = res;
    List<Widget> newlist = [];
    for (var element in data) {
      newlist.add(chatBox(element["sender"] == global.username, element["message"]));
    }
    setState(() {
      messages = newlist;
      wait = false;
    });
  }
}
