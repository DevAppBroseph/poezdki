part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
}

class BlogLoading extends ProfileState {}

class BlogLoaded extends ProfileState {
  final List<Blog> blogs;

  BlogLoaded(this.blogs);
}

class QuestionsLoading extends ProfileState {}

class QuestionsLoaded extends ProfileState {
  final List<Question> questions;

  QuestionsLoaded(this.questions);
}

class ProfileAunAuth extends ProfileState {}

class ProfileError extends ProfileState {}
