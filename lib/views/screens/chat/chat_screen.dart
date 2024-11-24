import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/navigation_helper.dart';

import '../../../models/chat/chat_models.dart';
import 'chat_room_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<User> users = [
    User(id: '1', name: 'User 1', imageUrl: 'assets/user1.png'),
    User(id: '2', name: 'User 2', imageUrl: 'assets/user2.png'),
    User(id: '3', name: 'User 3', imageUrl: 'assets/user3.png'),
  ];

  List<Message> messages = [
    Message(
      sender: User(id: '1', name: 'User 1', imageUrl: 'assets/user1.png'),
      receiver: User(id: '2', name: 'User 2', imageUrl: 'assets/user2.png'),
      text: 'Hello!',
      time: DateTime.now(),
      isSeen: true,
    ),
    Message(
      sender: User(id: '1', name: 'User 2', imageUrl: 'assets/user2.png'),
      receiver: User(id: '2', name: 'User 2', imageUrl: 'assets/user1.png'),
      text: 'Hi there!',
      time: DateTime.now(),
      isSeen: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          User user = users[index];
          Message lastMessage = messages.lastWhere(
            (message) =>
                (message.sender?.id == user.id &&
                    message.receiver?.id == '1') ||
                (message.sender?.id == '1' && message.receiver?.id == user.id),
          );

          bool isSeen = lastMessage != null && lastMessage.isSeen;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(user.imageUrl!),
            ),
            title: Text(user.name ?? ""),
            subtitle: Text(lastMessage?.text ?? ''),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lastMessage != null
                      ? '${lastMessage.time?.hour}:${lastMessage.time?.minute}'
                      : '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                isSeen ? const Icon(Icons.done_all) : const Icon(Icons.done),
              ],
            ),
            onTap: () {
              Get.to(
                ChatRoomScreen(user: user),
                transition: Transition.rightToLeft,
              );
            },
          );
        },
      ),
    );
  }
}
