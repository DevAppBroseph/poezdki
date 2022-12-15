import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
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
    final chatBloc = BlocProvider.of<ChatBloc>(context)
      ..add(ChatStarted(
        senderId: senderId,
        receiverId: receiverId,
        token: token,
      ));
    return BlocBuilder(
      bloc: chatBloc,
      buildWhen: (previous, current) {
        if(current is MessageRead) return false;
        return true;
      },
      builder: ((context, state) {
        print('object chat state ${state}');
        // if (state is ChatLoading) {
        //   return const Padding(
        //     padding: EdgeInsets.all(20.0),
        //     child: Center(
        //       child: CircularProgressIndicator.adaptive(),
        //     ),
        //   );
        // }
        // if (state is ChatLoaded) {
          return ChatScreen(
            senderId: senderId,
            ownerId: ownerId,
            message: state is ChatLoaded ? state.messages : [],
            phone: phone,
            channel: chatBloc.channel!,
          );
        }
        // return const Center(
        //   child: Text(""),
        // );
      // }
      ),
    );
  }
}
