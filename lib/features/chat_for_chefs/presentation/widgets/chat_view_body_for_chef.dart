import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chat_For_User/manager/chat_user_cubit.dart';
import 'package:food_recipes/main_models/chat_model.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/user_model.dart';

import '../../manager/chat_chef_cubit.dart';


class ChatViewBodyForChef extends StatelessWidget {
  const ChatViewBodyForChef({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatChefCubit, ChatChefState>(
      listener: (context, state) {
        var chatChefCubit = ChatChefCubit.get(context);
        // TODO: implement listener
      },
      builder: (context, state) {
        var chatChefCubit = ChatChefCubit.get(context);
        return StreamBuilder(
            stream: chatChefCubit.getChatData(
                uid1: user.uid!, uid2: chatChefCubit.authService.uid!),
            builder: (context, snapshot) {
              ChatModel? chat = snapshot.data?.data();
              List<ChatMessage> messages = [];
              if (chat != null && chat.messages != null) {
                messages = chatChefCubit.generateChatMessages(
                  messages: chat.messages!,
                  otherUser: ChatUser(
                    id: user.uid!,
                    firstName:user.name,
                    profileImage: user.photoUrl,
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
                        File? file = await chatChefCubit.getImageFormGallery();
                        if (file != null) {
                          await chatChefCubit.uploadImageToChat(
                            file: file,
                            uid1: chatChefCubit.getCurrentChef().id,
                            uid2: user.uid!,
                          );
                        }
                        if (chatChefCubit.chatImage != null) {
                          ChatMessage message = ChatMessage(
                            user: chatChefCubit.getCurrentChef(),
                            createdAt: DateTime.now(),
                            medias: [
                              ChatMedia(
                                url: chatChefCubit.chatImage!,
                                fileName: '',
                                type: MediaType.image,
                              ),
                            ],
                          );
                          chatChefCubit.sendMessage(

                            chatMessage: message,
                            otherUserUid: user.uid!,
                          );
                        }
                      },),
                  ],
                ),
                currentUser: chatChefCubit.getCurrentChef(),
                onSend: (message) {
                  ChatChefCubit.get(context).sendMessage(
                    chatMessage: message,
                    otherUserUid: user.uid!,
                  );
                },
                messages:messages,
              );
            });
      },
    );
  }
}
