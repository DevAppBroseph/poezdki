import 'package:app_poezdka/model/car_model.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/service/server/car_service.dart';
import 'package:app_poezdka/service/server/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SecureStorage userRepository;
  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    final userService = UserService();
    final carService = CarService();
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final token = await userRepository.getToken();
      final UserModel? user = await userService.getCurrentUser(token: token!);
      user != null ? add(UpdateProfile(user)) : add(ErrorProfileLoaded(""));
    });
    on<CreateCar>((event, emit) async {
      final token = await userRepository.getToken();
      final responce = await carService.addCar(token: token!, car: event.car);
      if (responce) {
        add(LoadProfile());
        Navigator.pop(event.context);
      }
    });
    on<DeleteCar>((event, emit) async {
      final token = await userRepository.getToken();
      final responce = await carService.deleteCar(token: token!, carId: event.carId);
      if (responce) {
        add(LoadProfile());
      }
    });
    on<UpdateProfile>((event, emit) {
      emit(ProfileLoaded(event.user));
    });
    on<ErrorProfileLoaded>((event, emit) {
      emit(ProfileError());
    });
  }
}
