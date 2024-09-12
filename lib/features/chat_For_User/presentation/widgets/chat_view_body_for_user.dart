import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chat_For_User/manager/chat_user_cubit.dart';
import 'package:food_recipes/main_models/chat_model.dart';
import 'package:food_recipes/main_models/chef_model.dart';


class ChatViewBodyForUser extends StatelessWidget {
  const ChatViewBodyForUser({super.key, required this.chef});

  final ChefModel chef;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatUserCubit, ChatUserState>(
      listener: (context, state) {
        var chatUserCubit = ChatUserCubit.get(context);
        // TODO: implement listener
      },
      builder: (context, state) {
        var chatUserCubit = ChatUserCubit.get(context);
        return StreamBuilder(
            stream: chatUserCubit.getChatData(
                uid1: chef.uid!, uid2: chatUserCubit.authService.uid!),
            builder: (context, snapshot) {
              ChatModel? chat = snapshot.data?.data();
              List<ChatMessage> messages = [];
              if (chat != null && chat.messages != null) {
                messages = chatUserCubit.generateChatMessages(
                  messages: chat.messages!,
                  otherUser: ChatUser(
                    id: chef.uid!,
                    firstName:chef.name,
                    profileImage: chef.photoUrl,
                  ),
                );
              }
              return DashChat(
                messageOptions: const MessageOptions(
                  showOtherUsersAvatar: true,
                  showTime: true,
                ),
                inputOptions: InputOptions(
                  alwaysShowSend: true,
                  trailing: [
                    IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          File? file = await chatUserCubit.getImageFormGallery();
                          if (file != null) {
                            await chatUserCubit.uploadImageToChat(
                              file: file,
                              uid1: chatUserCubit.getCurrentUser().id,
                              uid2: chef.uid!,
                            );
                          }
                          if (chatUserCubit.chatImage != null) {
                            ChatMessage message = ChatMessage(
                              user: chatUserCubit.getCurrentUser(),
                              createdAt: DateTime.now(),
                              medias: [
                                ChatMedia(
                                  url: chatUserCubit.chatImage!,
                                  fileName: '',
                                  type: MediaType.image,
                                ),
                              ],
                            );
                            chatUserCubit.sendMessage(
                              chatMessage: message,
                              otherUserUid: chef.uid!,
                            );
                          }
                        },),
                  ],
                ),
                currentUser: chatUserCubit.getCurrentUser(),
                onSend: (message) {
                  ChatUserCubit.get(context).sendMessage(
                   chatMessage: message,
                    otherUserUid: chef.uid!,
                  );
                },
                messages:messages,
              );
            });
      },
    );
  }
}
