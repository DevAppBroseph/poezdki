import 'dart:async';
import 'dart:convert';
import 'package:app_poezdka/const/server/server_data.dart';
import 'package:app_poezdka/model/answer_support.dart';
import 'package:http/http.dart' as http;
import 'package:app_poezdka/model/new_message.dart';
import 'package:app_poezdka/model/send_message.dart';
import 'package:app_poezdka/service/server/chat_service.dart';
import 'package:app_poezdka/widget/dialog/message_dialog.dart';
import 'package:vibration/vibration.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../../export/services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  bool showPersonChat = true;
  bool showSupportChat = true;
  final chatService = ChatService();
  final secureStorage = SecureStorage.instance;

  ChatBloc() : super(ChatInitial()) {
    //Example
    testController.stream.listen((event) {
      // if (event.last.replyTo?.user.id != null) {
        channel?.sink.add(jsonEncode({
          "to": event.last.replyTo?.user.id,
          "from": event.last.user.id,
          "message": event.last.text,
        }));
      // }
      add(UpdateChat(messages: event));
    });
    ///

    on<ChatStarted>(_onChatStarted);
    on<UpdateChat>(_updateChat);
    on<StartSocket>(_startSocket);
    on<GetChatSupport>(_getChatSupport);
    on<CheckNewMessageSupport>(_checkMessageSupport);
    on<RefreshTripEvent>(_refresh);
  }
  WebSocketChannel? channel;

  ///Example
  final testController = StreamController<List<ChatMessage>>();

  List<ChatMessage> messages = [];

  ///

  void editShowPersonChat(bool value) {
    showPersonChat = value;
  }

  void editShowSupportChat(bool value) {
    showSupportChat = value;
  }

  void _startSocket(StartSocket event, Emitter<ChatState> emit) async {
    final token = await SecureStorage.instance.getToken();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://$socektDomain:80/ws/$token'),
    );

    
    print('object socket start');
    channel?.stream.listen(
      (event) async {
        print('object socket start ${event}');
        try {
          Future.delayed(const Duration(seconds: 1), (() {
            _checkRead();
          }));
          var newMessage = NewMessageAnswer.fromJson(jsonDecode(event));
          if (newMessage.message == 'answer from support') {
            if (showSupportChat) {
              MessageDialogs().showMessage(
                '???????????? ??????????????????',
                '?????????? ??????????????????',
              );
            } else {
              add(GetChatSupport());
            }
          } else if (newMessage.fromName == 'BAZA') {
            MessageDialogs().showMessage(
              NewMessageAnswer.fromJson(jsonDecode(event)).fromName,
              NewMessageAnswer.fromJson(jsonDecode(event)).message,
            );
            Future.delayed(Duration(seconds: 2), () {
              add(RefreshTripEvent());
            });
          } else {
            if (showPersonChat) {
              MessageDialogs().showMessage(
                NewMessageAnswer.fromJson(jsonDecode(event)).fromName,
                NewMessageAnswer.fromJson(jsonDecode(event)).message,
              );
            }
            messages.add(
              ChatMessage(
                user: ChatUser(
                    id: SendMessage.fromJson(jsonDecode(event))
                        .from
                        .toString()),
                createdAt: DateTime.now(),
                text: SendMessage.fromJson(jsonDecode(event)).message,
              ),
            );
            // testController.sink.add(messages);
            add(UpdateChat(messages: messages));
          }
        } catch (e) {
          messages.add(
            ChatMessage(
              user: ChatUser(
                id: SendMessage.fromJson(jsonDecode(event)).from.toString(),
              ),
              createdAt: DateTime.now(),
              text: SendMessage.fromJson(jsonDecode(event)).message,
            ),
          );
          // testController.sink.add(messages);
          add(UpdateChat(messages: messages));
        }
        var vibrator = await Vibration.hasVibrator();
        if (vibrator ?? false) {
          Vibration.vibrate();
        }
      },
      onDone: () {
        // _startSocket(event, emit);
      },
      cancelOnError: false,
    );
    // }
  }

  void _checkMessageSupport(
      CheckNewMessageSupport event, Emitter<ChatState> emit) async {
    _checkRead();
  }

  void _checkRead() async {
    bool state = await chatService.checkReadMessage();
    if (state) {
      emit(MessageRead());
    } else {
      emit(MessageUnRead());
    }
  }

  void _onChatStarted(ChatStarted event, Emitter<ChatState> emit) async {
    final chats = await chatService.getChat(
      senderId: event.senderId,
      receiverId: event.receiverId,
      token: event.token,
    );

    if (chats != null) {
      messages = [];
      for (var element in chats) {
        messages.add(
          ChatMessage(
            user: ChatUser(
              id: element.from.toString(),
            ),
            createdAt: element.time,
            text: element.message,
          ),
        );
      }
      add(UpdateChat(messages: messages));
    }
  }

  void _updateChat(UpdateChat event, Emitter<ChatState> emit) {
    // add(RefreshTripEvent());
    emit(ChatLoaded(event.messages.reversed.toList()));
  }

  void _refresh(RefreshTripEvent event, Emitter<ChatState> emit) {
    // emit(ChatLoaded(event.messages.reversed.toList()));
    emit(RefreshTrip());
  }

  void _getChatSupport(GetChatSupport event, Emitter<ChatState> emit) async {
    updateSupportChat();
  }

  void updateSupportChat() async {
    final SecureStorage userRepository = SecureStorage.instance;
    String? token = await userRepository.getToken();
    var response = await http.get(
      Uri.parse('$serverURL/chat/get_questions'),
      headers: {"Authorization": token!},
    );

    if (response.statusCode == 200) {
      List<AnswerSupport> answer = [];
      for (var element in jsonDecode(response.body)) {
        answer.add(AnswerSupport.fromJson(element));
      }
      emit(SupportMessageState(answer: answer));
    }
  }

  // void _initApp(AppInit event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   final hasToken = await userRepository.hasToken();

  //   hasToken == true ? emit(AuthSuccess()) : emit(AuthUnauthenticated());
  // }

  // void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());

  //   final ResponceAuth? data = await authService.signUp(
  //       login: event.login,
  //       password: event.password,
  //       firstName: event.firstName,
  //       lastName: event.lastName,
  //       gender: event.gender,
  //       birth: event.birth);

  //   if (data != null) {
  //     await userRepository.persistEmailAndToken(
  //         event.login, data.token, data.id);
  //     add(AppInit());
  //     Navigator.pop(event.context);
  //     Navigator.pop(event.context);
  //     Navigator.pop(event.context);
  //   } else {
  //     add(AuthError("???????????? ??????????????????????."));
  //   }
  // }

  // void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
  //   final authService = AuthService();
  //   emit(AuthLoading());
  //   final ResponceAuth? responceSignIn =
  //       await authService.signIn(login: event.email, password: event.password);

  //   if (responceSignIn != null) {
  //     await userRepository.persistEmailAndToken(
  //         event.email, responceSignIn.token, responceSignIn.id);
  //     add(AppStarted());
  //     Navigator.pop(event.context);
  //   }
  // }

  // void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   await userRepository.deleteUserData();
  //   add(AppInit());
  // }

  // void _onOnBoardComplete(
  //     OnBoardComplete event, Emitter<AuthState> emit) async {
  //   appRepository.setFirstLaunch(false);
  //   add(AppInit());
  // }

  // void _onAuthError(AuthError event, Emitter<AuthState> emit) async {}

  // void _devLogIn(OnDevLogIn event, Emitter<AuthState> emit) async {
  //   await userRepository.persistEmailAndToken("email", "token", 1);
  //   add(AppInit());
  // }
}
