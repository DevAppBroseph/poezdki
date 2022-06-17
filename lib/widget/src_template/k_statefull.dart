import 'package:flutter/material.dart';

class KScaffoldScreen extends StatelessWidget {
  final String title;
  final bool? isLeading;
  final List<Widget>? actions;
  final Widget body;
  const KScaffoldScreen(
      {Key? key,
      required this.title,
      this.isLeading,
      this.actions,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: body,
    );
  }
}
