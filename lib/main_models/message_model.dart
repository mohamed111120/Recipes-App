import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image }

class MessageModel {
  String? senderId;
  String? content;
  MessageType? messageType;
  Timestamp? sentAt;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.messageType,
    required this.sentAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    content = json['content'];
    sentAt = json['sentAt'];
    messageType =MessageType.values.byName(json['messageType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['content'] = content;
    data['sentAt'] = sentAt;
    data['messageType'] = messageType!.name;
    return data;
  }
}
