import 'package:flutter/material.dart';

class KScaffoldScreen extends StatelessWidget {
  final bool? resizeToAvoidBottomInset;
  final String title;
  final bool? isLeading;
  final List<Widget>? actions;
  final Widget body;
  final PreferredSizeWidget? bottom;
  const KScaffoldScreen(
      {Key? key,
      this.resizeToAvoidBottomInset,
      required this.title,
      this.isLeading,
      this.actions,
      this.bottom,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    
    );
  }
}
