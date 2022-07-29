part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UserModel user;

  UpdateProfile(this.user);
}

class CreateCar extends ProfileEvent {
  final BuildContext context;
  final CarModel car;

  CreateCar(this.context, this.car);
}

class DeleteCar extends ProfileEvent {
  final int carId;

  DeleteCar(this.carId);
}

class ErrorProfileLoaded extends ProfileEvent {
  final String error;

  ErrorProfileLoaded(this.error);
}
