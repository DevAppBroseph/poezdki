import 'dart:convert';

import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class PickCity extends StatefulWidget {
  final String title;
  const PickCity({Key? key, required this.title}) : super(key: key);

  @override
  State<PickCity> createState() => _PickCityState();
}

class _PickCityState extends State<PickCity> {
  final List<Departure> citiesList = [];
  final List<Departure> citySearchList = [];
  final TextEditingController searchController = TextEditingController();

  loadJson() async {
    String data = await rootBundle.loadString('assets/city/ru_cities.json');
    var jsonlist = jsonDecode(data) as List;
    for (var e in jsonlist) {
      final city = Departure.fromJson(e);
      citiesList.add(city);
      citySearchList.add(city);
    }
    setState(() {});
  }

  @override
  void initState() {
    loadJson();

    setState(() {});
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Departure> dummyListData = [];
      for (var item in citiesList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        citySearchList.clear();
        citySearchList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        citySearchList.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.chevron_down)),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            KFormField(
              hintText: "Название населенного пункта",
              textEditingController: searchController,
              onChanged: (query) => filterSearchResults(query.trim()),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: ((context, index) => const Divider()),
                shrinkWrap: true,
                itemCount: citySearchList.length,
                itemBuilder: (context, int index) {
                  final city = citySearchList[index];

                  return ListTile(
                    onTap: () => Navigator.pop(context, city),
                    title: Text(city.name!),
                    subtitle: Text("Россия, ${city.subject!}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
