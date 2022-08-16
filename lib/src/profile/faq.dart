import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/lorem_ipsum.dart';
import 'package:app_poezdka/model/faq_model.dart';
import 'package:flutter/material.dart';

import 'package:app_poezdka/widget/src_template/k_statefull.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<FAQItem>? _items;
  @override
  void initState() {
    _items = generateItems(10);
    super.initState();
  }

  List<FAQItem> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return FAQItem(
          headerValue: 'Вопрос №${index + 1}',
          expandedValue: loremIpsum,
          isExpanded: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<FAQItem> _faqList = generateItems(8);
    return KScaffoldScreen(
        isLeading: true,
        title: "Вопросы и ответы",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _items![index].isExpanded = !isExpanded;
                });
              },
              children: _items!.map<ExpansionPanel>((FAQItem item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        item.headerValue,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: item.isExpanded ? kPrimaryColor : null),
                      ),
                    );
                  },
                  body: ListTile(
                    subtitle: Text(item.expandedValue),
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
          ),
        ));
  }
}