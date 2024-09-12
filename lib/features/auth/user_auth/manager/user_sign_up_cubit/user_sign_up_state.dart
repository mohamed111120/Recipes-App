part of 'user_sign_up_cubit.dart';

@immutable
sealed class UserSignUpState {}

final class UserSignUpInitial extends UserSignUpState {}

final class UserSignUpLoading extends UserSignUpState {}

final class UserSignUpSuccess extends UserSignUpState {}

final class UserSignUpError extends UserSignUpState {
  final String error;

  UserSignUpError({required this.error});
}
final class GetImageFromGallery extends UserSignUpState {}

final class UploadUserImageLoading extends UserSignUpState {}

final class UploadUserImageSuccess extends UserSignUpState {}

final class UploadUserImageError extends UserSignUpState {}
