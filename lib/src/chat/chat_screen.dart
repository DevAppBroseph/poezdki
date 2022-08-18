import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/model/send_message.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final int ownerId;
  const ChatScreen({
    Key? key,
    required this.ownerId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  WebSocketChannel? _channel;
  StreamController<List<ChatMessage>> _messagesStream =
      StreamController<List<ChatMessage>>();
  List<ChatMessage> _message = [];

  @override
  void dispose() {
    _channel?.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initStream();
    super.initState();
  }

  void _sendMessage(String message) async {
    final token = await SecureStorage.instance.getToken();
    _channel?.sink.add(
      jsonEncode({
        "to": widget.ownerId.toString(),
        "message": message,
      }),
    );
    // setState(() {
    _message.insert(
        0,
        ChatMessage(
            user: ChatUser(id: '0'), createdAt: DateTime.now(), text: message));
    _messagesStream.sink.add(_message);

    // });
  }

  void _initStream() async {
    final token = await SecureStorage.instance.getToken();
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://194.87.145.140:80/ws/$token'),
    );
    _channel?.stream.listen(
      (event) {
        // setState(() {
        _message.insert(
            0,
            ChatMessage(
                user: ChatUser(
                    id: SendMessage.fromJson(jsonDecode(event))
                        .from
                        .toString()),
                createdAt: DateTime.now(),
                text: SendMessage.fromJson(jsonDecode(event)).message));
        _messagesStream.sink.add(_message);
        // });
        print(SendMessage.fromJson(jsonDecode(event)).message);
      },
      onError: (error) => print(error),
    );
    // _sendMessage();
  }

  // ChatUser user = ChatUser(
  //   id: '1',
  //   firstName: 'Charles',
  //   lastName: 'Leclerc',
  // );
  // ChatUser user2 = ChatUser(
  //   id: '2',
  //   firstName: 'Jogn',
  //   lastName: 'Doe',
  // );

  @override
  Widget build(BuildContext context) {
    // List<ChatMessage> messages = <ChatMessage>[
    //   ChatMessage(
    //     text: 'Спасибо, все устраивает. Бронирую',
    //     user: user,
    //     createdAt: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     medias: [
    //       ChatMedia(
    //         url:
    //             'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
    //         type: MediaType.image,
    //         fileName: 'image.png',
    //       ),
    //       ChatMedia(
    //         url:
    //             'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
    //         type: MediaType.image,
    //         fileName: 'image.png',
    //       )
    //     ],
    //     user: user2,
    //     createdAt: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     text: 'Добрый день, скиньте фото машины',
    //     user: user,
    //     createdAt: DateTime.now(),
    //   ),
    // ];
    return StreamBuilder(
        stream: _channel?.stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          return StreamBuilder<List<ChatMessage>>(
              stream: _messagesStream.stream,
              initialData: [],
              builder: (context, snapshot2) {
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
                  body: DashChat(
                    currentUser: ChatUser(id: '0'),
                    onSend: (ChatMessage m) {
                      // setState(() {
                      //   _message.insert(0, m);
                      // });
                    },
                    messages: snapshot2.data!,
                    messageOptions: const MessageOptions(
                        messagePadding: EdgeInsets.all(16),
                        showTime: true,
                        currentUserContainerColor: kPrimaryWhite,
                        currentUserTextColor: Colors.black,
                        containerColor: kPrimaryLightGrey),
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
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.plus_circle_fill,
                            color: kPrimaryLightGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
