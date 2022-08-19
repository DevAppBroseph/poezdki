import 'package:flutter/material.dart';

class KScaffoldScreen extends StatelessWidget {
  final Color backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final String title;
  final bool? isLeading;
  final List<Widget>? actions;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const KScaffoldScreen(
      {Key? key,
      this.resizeToAvoidBottomInset,
      this.backgroundColor = const Color.fromRGBO(247, 247, 248, 1),
      required this.title,
      this.isLeading,
      this.actions,
      this.bottom,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: isLeading ?? false,
        actions: actions,
        bottom: bottom,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
    );
  }
}
