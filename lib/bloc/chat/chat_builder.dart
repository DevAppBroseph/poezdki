import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
import 'package:app_poezdka/src/trips/components/trips_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsBuilder extends StatelessWidget {
  final int ownerId;
  final String token;
  final int receiverId;
  const ChatsBuilder({
    Key? key,
    required this.ownerId,
    required this.token,
    required this.receiverId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context)
      ..add(ChatStarted(
        senderId: ownerId,
        receiverId: receiverId,
        token: token,
      ));
    return BlocBuilder(
      bloc: chatBloc,
      builder: ((context, state) {
        if (state is ChatLoading) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        ///Example
        if (state is ChatLoaded || state is TestState) {
          return ChatScreen(
            ownerId: ownerId,
            message: [],
            channel: chatBloc.channel!,
          );
        }
        return const Center(
          child: Text(""),
        );
      }),
    );
  }
}
