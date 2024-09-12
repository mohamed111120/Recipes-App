import 'message_model.dart';

class ChatModel {
  String? id;
  List<String>? participants;
  List<MessageModel>? messages;

  ChatModel({
    required this.id,
    required this.participants,
    required this.messages,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participants = List<String>.from(json['participants']);
    messages = List<MessageModel>.from(
      json['messages'].map((x) => MessageModel.fromJson(x)),
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['participants'] = participants;
    data['messages'] = messages?.map((x) => x.toJson()).toList();
    return data;
  }
}
