class User {
  final String? id;
  final String? name;
  final String? imageUrl;

  User({
    this.id,
    this.name,
    this.imageUrl,
  });
}

class Message {
  final User? sender;
  final User? receiver;
  final String? text;
  final DateTime? time;
  bool isSeen;

  Message({
    this.sender,
    this.receiver,
    this.text,
    this.time,
    this.isSeen = false,
  });
}
