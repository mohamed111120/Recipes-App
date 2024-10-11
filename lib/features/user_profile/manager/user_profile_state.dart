part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}
final class GetCurrentUserProfileData extends UserProfileState {}
final class UserSignOutSuccess extends UserProfileState {}
final class UserSignOutError extends UserProfileState {}
