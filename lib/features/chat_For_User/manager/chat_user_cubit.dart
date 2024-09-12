import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/media_service.dart';
import 'package:food_recipes/core/services/storage_service.dart';
import 'package:food_recipes/main_models/message_model.dart';
import 'package:meta/meta.dart';
import '../../../core/services/auth_service.dart';
import '../../../main_models/chat_model.dart';
import '../../../main_models/chef_model.dart';

part 'chat_user_state.dart';

class ChatUserCubit extends Cubit<ChatUserState> {
  ChatUserCubit(
      {required this.databaseService,
      required this.authService,
      required this.mediaService,
      required this.storageService})
      : super(ChatInitial());

  static ChatUserCubit get(context) => BlocProvider.of(context);

  final DatabaseService databaseService;
  final AuthService authService;
  final MediaService mediaService;
  final StorageService storageService;

  String? chatImage;

  ChatUser getCurrentUser() {
    return ChatUser(id: authService.uid!);
  }

  Stream<QuerySnapshot<ChefModel>> getAllChefs() {
    return databaseService.getAllChefs();
  }

  Future<void> getChat({required String uid1, required String uid2}) async {
    emit(IsChatExistLoading());
    bool isExist =
        await databaseService.checkChatExist(uid1: uid1, uid2: uid2).then(
      (value) {
        emit(IsChatExistFinished());
        if (value) {
          emit(ChatExist());
        }
        return value;
      },
    );
    if (!isExist) {
      try {
        emit(CreateNewChatLoading());
        await databaseService.createNewChat(uid1: uid1, uid2: uid2);
        emit(CreateNewChatSuccess());
      } on Exception catch (e) {
        emit(CreateNewChatError());
      }
    }
  }

  Future<void> sendMessage({
    required ChatMessage chatMessage,
    required String otherUserUid,
  }) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias?.first.type == MediaType.image) {
        MessageModel message = MessageModel(
          senderId: authService.uid!,
          content: chatMessage.medias!.first.url,
          messageType: MessageType.image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        databaseService.sendChatMessage(
          uid1: getCurrentUser().id,
          uid2: otherUserUid,
          message: message,
        );
      }
    } else {
      MessageModel message = MessageModel(
        senderId: authService.uid!,
        content: chatMessage.text,
        messageType: MessageType.text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );
      databaseService.sendChatMessage(
        uid1: getCurrentUser().id,
        uid2: otherUserUid,
        message: message,
      );
    }
  }

  Stream<DocumentSnapshot<ChatModel>> getChatData(
      {required String uid1, required String uid2}) {
    return databaseService.getChatData(uid1: uid1, uid2: uid2);
  }

  List<ChatMessage> generateChatMessages({
    required List<MessageModel> messages,
    required ChatUser otherUser,
  }) {
    List<ChatMessage> chatMessages = messages.map(
          (m) {
        if (m.messageType == MessageType.image) {
          return ChatMessage(
            user: m.senderId == getCurrentUser().id
                ? getCurrentUser()
                : otherUser,
            medias: [
              ChatMedia(
                url: m.content!,
                fileName: '',
                type: MediaType.image,
              ),
            ],
            createdAt: m.sentAt!.toDate(),
          );
        } else {
          return ChatMessage(
            user: m.senderId == getCurrentUser().id
                ? getCurrentUser()
                : otherUser,
            text: m.content!,
            createdAt: m.sentAt!.toDate(),
          );
        }
      },
    ).toList();
    chatMessages.sort(
          (a, b) {
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return chatMessages;
  }
  Future<File?> getImageFormGallery() async {
    return await mediaService.getImageFromGallary();
  }

  Future<String?> uploadImageToChat({
    required File file,
    required String uid1,
    required String uid2,
  }) async {
    String chatId = databaseService.generateChatId(uid1: uid1, uid2: uid2);
    chatImage = await storageService.uploadImageToChat(
      file: file,
      chatId: chatId,
    );
    return chatImage;
  }
}
