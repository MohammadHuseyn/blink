import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF256F46),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/chat_background.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    chatBox(true, "پیام مشکل"),
                    chatBox(false, "پیام پشتیبان"),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration:
                          InputDecoration(hintText: "نوشتن پیام",
                              hintStyle: TextStyle(
                                color: Colors.grey
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                            icon: ImageIcon(
                              AssetImage("images/send-message.png"),
                            ),
                            iconSize: 40,
                            color: Color(0xFF256f46),
                            onPressed: (){},
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF256F46),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 12,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 10,
      ),
    );
  }

  chatBox(bool support, String text) {
    if (support) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'shabnam', fontSize: 25, color: Colors.white),
                textAlign: TextAlign.right,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Color(0xFF2E8B57),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
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
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Color(0xFFEAF3EE),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ],
        ),
      );
    }
  }
}
