import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/user_model.dart';
import '../../../../main_models/chef_model.dart';
import '../../manager/chat_chef_cubit.dart';
import '../view/chat_view_for_chef.dart';
import 'chat_chefs_list_view_item_for_chef.dart';

class ChatUsersViewBodyForChef extends StatelessWidget {
  const ChatUsersViewBodyForChef({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatChefCubit, ChatChefState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var chatChefCubit = ChatChefCubit.get(context);
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: chatChefCubit.getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                UserModel user =
                                    snapshot.data!.docs[index].data();
                                return ChatUsersListViewItemForChef(
                                  user: user,
                                  onTap: () async {
                                    await chatChefCubit
                                        .getChat(
                                      uid1: chatChefCubit.authService.uid!,
                                      uid2: user.uid!,
                                    )
                                        .then(
                                      (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatViewForChef(user: user),
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
