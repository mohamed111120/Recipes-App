part of 'chef_sign_up_cubit.dart';

@immutable
sealed class ChefSignUpState {}

final class ChefSignUpInitial extends ChefSignUpState {}

final class ChefSignUpLoading extends ChefSignUpState {}

final class ChefSignUpSuccess extends ChefSignUpState {}

final class ChefSignUpError extends ChefSignUpState {
  final String error;

  ChefSignUpError({required this.error});
}
final class GetImageFromGallery extends ChefSignUpState {}
final class UploadChefImageLoading extends ChefSignUpState {}

final class UploadChefImageSuccess extends ChefSignUpState {}

final class UploadChefImageError extends ChefSignUpState {}