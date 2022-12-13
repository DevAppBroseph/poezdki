import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FeedBack extends StatefulWidget {
  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final TextEditingController _controller = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    final WebSocketChannel channel;
    BlocProvider.of<ChatBloc>(context).add(GetChatSupport());
    func();
  }

  WebSocketChannel? channel;

  void func() async {
    final token = await SecureStorage.instance.getToken();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://194.87.145.140:80/ws/$token'),
    );

    channel?.stream.listen((event) async {
      BlocProvider.of<ChatBloc>(context).add(GetChatSupport());
    });
  }

  void _sendMessage(String message) async {
    if (_controller.text.isNotEmpty) {
      final SecureStorage userRepository = SecureStorage.instance;
      String? token = await userRepository.getToken();
      final body = json.encode({"text": _controller.text});
      var response = await http.post(
        Uri.parse('http://194.87.145.140/chat/add_question'),
        headers: {"Authorization": token!},
        body: body,
      );
      _controller.clear();
      // print(object)
      BlocProvider.of<ChatBloc>(context).add(GetChatSupport());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // channel.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      backgroundColor: Colors.white,
      isLeading: true,
      resizeToAvoidBottomInset: true,
      title: "Чат с поддержкой",
      body: BlocConsumer<ChatBloc, ChatState>(listener: (context, state) {
        if (state is SupportMessageState) {
          List<ChatMessage> messagesTemp = [];
          messages.clear();
          for (var element in state.answer) {
            messagesTemp.add(
              ChatMessage(
                text: element.text!,
                user: ChatUser(id: '1'),
                createdAt: element.datetime!.toLocal(),
              ),
            );
            if (element.answer != null) {
              messagesTemp.add(
                ChatMessage(
                  text: element.answer!,
                  user: ChatUser(id: '2'),
                  createdAt: element.answerDatetime!.toLocal(),
                ),
              );
            }
          }
          for (int i = messagesTemp.length - 1; i >= 0; i--) {
            messages.add(messagesTemp[i]);
          }
          // setState(() {});
        }
      }, builder: (context, state) {
        return DashChat(
          currentUser: ChatUser(id: '1'),
          onSend: (ChatMessage m) {
            // setState(() {
            //   _message.insert(0, m);
            // });
          },
          messages: messages,
          messageListOptions: MessageListOptions(
              dateSeparatorFormat: DateFormat('EEE, hh:mm', 'RU')),
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
              },
              icon: SvgPicture.asset("$svgPath/send.svg"),
            ),
          ),
        );
      }),
    );
  }
}
