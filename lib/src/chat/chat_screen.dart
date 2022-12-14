import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final int senderId;
  final int ownerId;
  final List<ChatMessage> message;
  final String? phone;
  const ChatScreen({
    Key? key,
    required this.senderId,
    required this.ownerId,
    required this.message,
    required this.phone,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).editShowPersonChat(false);
  }

  @override
  void deactivate() {
    BlocProvider.of<ChatBloc>(context).editShowPersonChat(true);
    super.deactivate();
  }

  void _sendMessage(String message) async {
    var messages = context.read<ChatBloc>().messages;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      backgroundColor: Colors.white,
      isLeading: true,
      resizeToAvoidBottomInset: true,
      title: "Чат с водителем",
      actions: [
        widget.phone != null 
        ? IconButton(
          onPressed: () async {
            final url = "tel:${widget.phone}";   
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          icon: Image.asset(
            "$iconPath/call-calling.png",
          ),
        )
        : SizedBox()
        // IconButton(
        //   onPressed: () {},
        //   icon: Image.asset(
        //     "$iconPath/more-circle.png",
        //   ),
        // )
      ],
      body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
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
              },
              icon: SvgPicture.asset("$svgPath/send.svg"),
            ),
            // trailing: [
            //   IconButton(
            //     onPressed: () {
            //       ///Example
            //       ///
            //     },
            //     icon: const Icon(
            //       CupertinoIcons.plus_circle_fill,
            //       color: kPrimaryLightGrey,
            //     ),
            //   )
            // ],
          ),
        );
      }),
    );
  }
}
