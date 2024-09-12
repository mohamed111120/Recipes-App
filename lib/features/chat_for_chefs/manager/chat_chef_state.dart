part of 'chat_chef_cubit.dart';

@immutable
sealed class ChatChefState {}

final class ChatChefInitial extends ChatChefState {}

final class IsChatExistLoading extends ChatChefState {}
final class IsChatExistFinished extends ChatChefState {}
final class CreateNewChatLoading extends ChatChefState {}
final class CreateNewChatSuccess extends ChatChefState {}
final class CreateNewChatError extends ChatChefState {}
final class ChatExist extends ChatChefState {}
