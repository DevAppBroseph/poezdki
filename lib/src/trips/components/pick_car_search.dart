import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickCarSearch extends StatefulWidget {
  final String title;
  final List<String>? list;
  const PickCarSearch({Key? key, required this.title, required this.list}) : super(key: key);

  @override
  State<PickCarSearch> createState() => _PickCarSearchState();
}

class _PickCarSearchState extends State<PickCarSearch> {
  final TextEditingController searchController = TextEditingController();

  FocusNode? focusNode;
  List<String>? listCars= [];

  @override
  void initState() {
    listCars!.addAll(widget.list!);
    focusNode = FocusNode();
    Future.delayed(const Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(focusNode);
    });

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    focusNode?.dispose();
    super.dispose();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (var item in widget.list!) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        listCars!.clear();
        listCars!.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listCars!.clear();
        listCars!.addAll(widget.list!);
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
              focusNode: focusNode,
              hintText: "Марка автомобиля",
              textEditingController: searchController,
              onChanged: (query) => filterSearchResults(query.trim()),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: ((context, index) => const Divider()),
                shrinkWrap: true,
                itemCount: listCars!.length,
                itemBuilder: (context, int index) {
                  final mark1 = listCars![index];

                  return ListTile(
                    onTap: () => Navigator.pop(context, listCars![index]),
                    title: Text(mark1),
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
