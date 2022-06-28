import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';



class DefailtScaffold extends StatelessWidget {
  const DefailtScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "title",
        body: SingleChildScrollView(
          child: Column(
            children: const [
            
            ],
          ),
        ));
  }
}
