import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_models/chef_model.dart';
import '../../manager/chat_user_cubit.dart';
import '../view/chat_view_for_user.dart';
import 'chat_users_list_view_item_for_user.dart';

class ChatUsersViewBodyForUser extends StatelessWidget {
  const ChatUsersViewBodyForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatUserCubit, ChatUserState>(
      listener: (context, state) {
        var chatUserCubit = ChatUserCubit.get(context);
      },
      builder: (context, state) {
        var chatUserCubit = ChatUserCubit.get(context);
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: chatUserCubit.getAllChefs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ChefModel chef =
                                    snapshot.data!.docs[index].data();
                                return ChatUsersListViewItemForUser(
                                  chef: chef,
                                  onTap: () async {
                                    await chatUserCubit
                                        .getChat(
                                      uid1: chatUserCubit.authService.uid!,
                                      uid2: chef.uid!,
                                    )
                                        .then(
                                      (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatViewForUser(chef: chef),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              });
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
            if (state is IsChatExistLoading || state is CreateNewChatLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
