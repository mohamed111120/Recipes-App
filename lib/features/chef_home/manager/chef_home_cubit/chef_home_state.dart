part of 'chef_home_cubit.dart';

@immutable
sealed class ChefHomeState {}

final class ChefHomeInitial extends ChefHomeState {}
final class GetChefDataState extends ChefHomeState {}

