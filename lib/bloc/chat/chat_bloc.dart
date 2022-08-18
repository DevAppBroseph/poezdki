import 'package:app_poezdka/service/server/chat_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../../export/services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final chatService = ChatService();
  ChatBloc() : super(ChatInitial()) {
    on<ChatStarted>(_onChatStarted);
    on<UpdateChat>(_updateChat);
    on<StartSocket>(_startSocket);
  }
  WebSocketChannel? channel;

  void _startSocket(StartSocket event, Emitter<ChatState> emit) async {
    // if (channel == null) {
    final token = await SecureStorage.instance.getToken();
    // print(token);
    channel = WebSocketChannel.connect(
      Uri.parse('ws://194.87.145.140:80/ws/$token'),
    );
    print('is inited');

    channel?.stream.listen(
      (event) {
        // setState(() {
        // _message.insert(
        //   0,
        //   ChatMessage(
        //     user: ChatUser(
        //         id: SendMessage.fromJson(jsonDecode(event)).from.toString()),
        //     createdAt: DateTime.now(),
        //     text: SendMessage.fromJson(jsonDecode(event)).message,
        //   ),
        // );
        // _messagesStream.sink.add(_message);
        // });
        print(event);
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      cancelOnError: false,
      onError: (error) => print('error'),
    );
    // }
  }

  void _onChatStarted(ChatStarted event, Emitter<ChatState> emit) async {
    final chats = await chatService.getChat(
      senderId: event.senderId,
      receiverId: event.receiverId,
      token: event.token,
    );

    if (chats != null) {
      List<ChatMessage> _messages = [];
      chats.forEach((element) {
        _messages.add(
          ChatMessage(
            user: ChatUser(
              id: element.from.toString(),
            ),
            createdAt: DateTime.now(),
            text: element.message,
          ),
        );
      });
      add(UpdateChat(messages: _messages));
    }
  }

  void _updateChat(UpdateChat event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages));
  }

  // void _initApp(AppInit event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   final hasToken = await userRepository.hasToken();
  //   print(await userRepository.getToken());

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
  //     add(AuthError("Ошибка регистрации."));
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
