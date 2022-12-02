import 'package:app_poezdka/model/questions.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/service/server/car_service.dart';
import 'package:app_poezdka/service/server/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/blog.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserModel? userModel;
  final SecureStorage userRepository;
  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    final userService = UserService();
    final carService = CarService();
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final token = await userRepository.getToken();
      final UserModel? user = token == null ? null : await userService.getCurrentUser(token: token);
      userModel = user;
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
      final responce =
          await carService.deleteCar(token: token!, carId: event.carId);
      if (responce) {
        add(LoadProfile());
      }
    });
    on<UpdateProfile>((event, emit) {
      emit(ProfileLoaded(event.user));
    });
    on<EditProfileValues>((event, emit) async {
      final token = await userRepository.getToken();
      var result = await userService.editUser(token: token!, user: event.user);

      if (result != null) {
        add(LoadProfile());
        Navigator.pop(event.context);
      }
    });
    on<ChangePhoto>((event, emit) async {
      final token = await userRepository.getToken();
      final UserModel? user =
          await userService.changeUserPhoto(token: token!, image: event.media);
      if (user != null) {
        emit(ProfileLoaded(user));
      }
    });
    on<ErrorProfileLoaded>((event, emit) {
      emit(ProfileError());
    });
    on<GetBlog>((event, emit) async {
      emit(BlogLoading());
      final List<Blog>? blogs = await userService.getBlog();
      if (blogs != null) {
        emit(BlogLoaded(blogs));
      } else {
        // emit(ProfileError());
      }
    });
    on<GetQuestions>((event, emit) async {
      emit(QuestionsLoading());
      final List<Question>? questions = await userService.getQuestions();
      if (questions != null) {
        emit(QuestionsLoaded(questions));
      } else {
        // emit(ProfileError());
      }
    });
  }
}
