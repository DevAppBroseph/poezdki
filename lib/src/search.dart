import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class SearchRides extends StatelessWidget {
  const SearchRides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      title: "Поиск поездок",
      body: Center(child: Container(child: Text("Поиск поездок"))),
    );
  }
}
