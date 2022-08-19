import 'dart:async';
import 'dart:convert';

import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/send_message.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final int senderId;
  final int ownerId;
  final List<ChatMessage> message;
  final WebSocketChannel channel;
  const ChatScreen({
    Key? key,
    required this.senderId,
    required this.ownerId,
    required this.message,
    required this.channel,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    print(widget.ownerId);
    super.initState();
  }

  void _sendMessage(String message) async {
    var token = await SecureStorage.instance.getToken();
    // widget.channel.sink.add(
    //   jsonEncode({
    //     "to": widget.ownerId.toString(),
    //     "message": message,
    //   }),
    // );
    // setState(() {
    var messages = context.read<ChatBloc>().messages;
    print(widget.ownerId.toString());

    messages.add(
      ChatMessage(
        user: ChatUser(id: widget.senderId.toString()),
        createdAt: DateTime.now(),
        text: message,
        replyTo: ChatMessage(
          user: ChatUser(id: widget.ownerId.toString()),
          createdAt: DateTime.now(),
        ),
      ),
    );
    context.read<ChatBloc>().testController.sink.add(messages);
    // context.read<ChatBloc>().messages.add(
    //       ChatMessage(
    //         user: ChatUser(id: widget.ownerId.toString()),
    //         createdAt: DateTime.now(),
    //         text: message,
    //       ),
    //     );

    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    print('dispose');
    // _message = [];
    // _messagesStream.sink.close();
    // _messagesStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      isLeading: true,
      resizeToAvoidBottomInset: true,
      title: "Чат с водителем",
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "$iconPath/call-calling.png",
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "$iconPath/more-circle.png",
          ),
        )
      ],
      body: BlocConsumer<ChatBloc, ChatState>(listener: (context, state) {
        print('state: ${state}');
        if (state is TestState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }, builder: (context, state) {
        return DashChat(
          currentUser: ChatUser(id: widget.senderId.toString()),
          onSend: (ChatMessage m) {
            // setState(() {
            //   _message.insert(0, m);
            // });
          },
          messages: widget.message,
          messageOptions: const MessageOptions(
            messagePadding: EdgeInsets.all(16),
            showTime: true,
            currentUserContainerColor: kPrimaryWhite,
            currentUserTextColor: Colors.black,
            containerColor: kPrimaryLightGrey,
          ),
          inputOptions: InputOptions(
            textController: _controller,
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: kPrimaryWhite,
              hintText: "Написать сообщение...",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
            ),
            alwaysShowSend: true,
            showTraillingBeforeSend: true,
            sendButtonBuilder: (send) => IconButton(
              onPressed: () {
                _sendMessage(_controller.text);
                _controller.clear();
                // setState(() {});
              },
              icon: Image.asset("$iconPath/send-2.png"),
            ),
            trailing: [
              IconButton(
                onPressed: () {
                  ///Example
                  ///
                },
                icon: const Icon(
                  CupertinoIcons.plus_circle_fill,
                  color: kPrimaryLightGrey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
