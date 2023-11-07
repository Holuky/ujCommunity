
class Message {
  String content;
  String date;
  String name;
  int year = 0, month = 0, day = 0, hour = 0, sec = 0;

  Message({
    required this.content,
    required this.date,
    required this.name,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
        content: json['content'],
        date: json['date'],
        name: json['name']
    );
  }
}

class ChatMember {
  String name;
  int role; // 0 : 판매자, 1 : 구매자
  String id;

  // id: (이름의 해시값) + 이름

  ChatMember({
    required this.name,
    required this.role,
    required this.id
  });

  factory ChatMember.fromJson(Map<dynamic, dynamic> json) {
    return ChatMember(
        name: json['name'],
        role: json['role'],
        id: json['id']
    );
  }
  toJson() {
    return {
      'name': name,
      'role': role,
      'id': id,
    };
  }
}

class ChatRoom {
  ChatMember Member1, Member2;
  String ChatRoomId;// Member1 : 자기자신, Member2 : 상대방
  // List<Message> MessageList;

  ChatRoom({
    required this.Member1,
    required this.Member2,
    required this.ChatRoomId,
    // required this.MessageList
  });

  factory ChatRoom.fromJson(Map<dynamic, dynamic> json) {
    return ChatRoom(
      Member1: json['Member1'],
      Member2: json['Member2'],
      ChatRoomId:  json['ChatRoom'],
      // MessageList: json['messageList'].map((message)=>Message.fromJson(message)).toList()
    );
  }
}
