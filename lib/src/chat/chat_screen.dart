import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );
  ChatUser user2 = ChatUser(
    id: '2',
    firstName: 'Jogn',
    lastName: 'Doe',
  );

  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = <ChatMessage>[
      ChatMessage(
        text: 'Спасибо, все устраивает. Бронирую',
        user: user,
        createdAt: DateTime.now(),
      ),
      ChatMessage(
        medias: [
          ChatMedia(
            url:
                'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
            type: MediaType.image,
            fileName: 'image.png',
          ),
          ChatMedia(
            url:
                'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
            type: MediaType.image,
            fileName: 'image.png',
          )
        ],
        user: user2,
        createdAt: DateTime.now(),
      ),
      ChatMessage(
        text: 'Добрый день, скиньте фото машины',
        user: user,
        createdAt: DateTime.now(),
      ),
    ];
    return KScaffoldScreen(
      isLeading: true,
      resizeToAvoidBottomInset: true,
      title: "Чат с водителем",
      actions: [
        IconButton(
            onPressed: () {}, icon: Image.asset("$iconPath/call-calling.png")),
        IconButton(
            onPressed: () {}, icon: Image.asset("$iconPath/more-circle.png"))
      ],
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
        messageOptions: const MessageOptions(
            messagePadding: EdgeInsets.all(16),
            showTime: true,
            currentUserContainerColor: kPrimaryWhite,
            currentUserTextColor: Colors.black,
            containerColor: kPrimaryLightGrey),
        inputOptions: InputOptions(
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
              onPressed: () {}, icon: Image.asset("$iconPath/send-2.png")),
          trailing: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.plus_circle_fill,
                  color: kPrimaryLightGrey,
                ))
          ],
        ),
      ),
    );
  }
}
