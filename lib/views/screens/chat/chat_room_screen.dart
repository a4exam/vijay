import 'package:flutter/material.dart';
import 'package:mcq/models/chat/chat_models.dart';


class ChatRoomScreen extends StatefulWidget {
  final User? user;

  ChatRoomScreen({ this.user});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  List<Message> messages = [
    Message(
      sender: User(id: '1', name: 'User 1'),
      receiver: User(id: '2', name: 'User 2'),
      text: 'Hello!',
      time: DateTime.now(),
    ),
    Message(
      sender: User(id: '2', name: 'User 2'),
      receiver: User(id: '1', name: 'User 1'),
      text: 'Hi there!',
      time: DateTime.now(),
    ),
  ];

  TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() {
    String messageText = _textEditingController.text.trim();
    if (messageText.isNotEmpty) {
      Message newMessage = Message(
        sender: widget.user,
        receiver: User(id: '2', name: 'User 2'),
        text: messageText,
      );
      setState(() {
        messages.add(newMessage);
      });
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user?.name ??""),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                Message message = messages[index];
                bool isSender = message.sender?.id == widget.user?.id;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isSender ? Colors.blue : Colors.grey[300],
                        ),
                        child: Text(
                          message.text ??"",
                          style: TextStyle(color: isSender ? Colors.white : Colors.black),
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Text(
                            '${message.time?.hour}:${message.time?.minute}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isSender)
                            SizedBox(width: 4),
                          if (isSender)
                            Text(
                              message.isSeen ? 'Seen' : 'Delivered',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),


          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
