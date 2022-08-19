part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatLoaded(this.messages);
  @override
  List<Object> get props => [
        messages,
      ];
}

class TestState extends ChatState {
  final String message;
  TestState({required this.message});
}