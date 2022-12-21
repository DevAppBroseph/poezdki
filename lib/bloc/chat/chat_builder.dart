import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsBuilder extends StatelessWidget {
  final int ownerId;
  final int senderId;
  final String token;
  final int receiverId;
  final String? phone;
  const ChatsBuilder({
    Key? key,
    required this.ownerId,
    required this.senderId,
    required this.token,
    required this.receiverId,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatMessage> message = [];
    final chatBloc = BlocProvider.of<ChatBloc>(context)
      ..add(ChatStarted(
        senderId: senderId,
        receiverId: receiverId,
        token: token,
      ));
    return BlocBuilder(
      bloc: chatBloc,
      buildWhen: (previous, current) {
        if (current is ChatLoaded) {
          message = current.messages;
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return ChatScreen(
          senderId: senderId,
          ownerId: ownerId,
          message: message,
          phone: phone,
        );
      },
    );
  }
}
