part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class StartSocket extends ChatEvent {}

class ChatStarted extends ChatEvent {
  final int senderId;
  final int receiverId;
  final String token;

  ChatStarted({
    required this.senderId,
    required this.receiverId,
    required this.token,
  });
}

class UpdateChat extends ChatEvent {
  final List<ChatMessage> messages;

  UpdateChat({required this.messages});
}
class ShowTestEvent extends ChatEvent {
  final String message;
  ShowTestEvent({required this.message});
}

class GetChatSupport extends ChatEvent {}

class CheckNewMessageSupport extends ChatEvent {}
