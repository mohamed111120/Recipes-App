part of 'chef_profile_cubit.dart';

@immutable
sealed class ChefProfileState {}

final class ChefProfileInitial extends ChefProfileState {}
final class ChefSignOutSuccess extends ChefProfileState {}
final class ChefSignOutError extends ChefProfileState {}
final class GetCurrentChefProfileData extends ChefProfileState {}
