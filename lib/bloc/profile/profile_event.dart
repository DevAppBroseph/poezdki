part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UserModel user;

  UpdateProfile(this.user);
}

class EditProfileValues extends ProfileEvent {
  final BuildContext context;
  final UserModel user;

  EditProfileValues(this.user, this.context);
}

class ChangePhoto extends ProfileEvent {
  final String media;

  ChangePhoto(this.media);
}

class CreateCar extends ProfileEvent {
  final BuildContext context;
  final Car car;

  CreateCar(this.context, this.car);
}

class GetBlog extends ProfileEvent {}

class GetQuestions extends ProfileEvent {}

class DeleteCar extends ProfileEvent {
  final int carId;

  DeleteCar(this.carId);
}

class ErrorProfileLoaded extends ProfileEvent {
  final String error;

  ErrorProfileLoaded(this.error);
}
