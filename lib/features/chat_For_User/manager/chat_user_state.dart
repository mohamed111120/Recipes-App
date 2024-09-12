part of 'chat_user_cubit.dart';

@immutable
sealed class ChatUserState {}

final class ChatInitial extends ChatUserState {}

final class IsChatExistLoading extends ChatUserState {}
final class IsChatExistFinished extends ChatUserState {}
final class CreateNewChatLoading extends ChatUserState {}
final class CreateNewChatSuccess extends ChatUserState {}
final class CreateNewChatError extends ChatUserState {}
final class ChatExist extends ChatUserState {}