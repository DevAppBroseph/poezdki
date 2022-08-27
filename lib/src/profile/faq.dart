import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/lorem_ipsum.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/faq_model.dart';
import 'package:app_poezdka/model/questions.dart';
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
    BlocProvider.of<ProfileBloc>(context).add(GetQuestions());
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
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, event) {
      print(event);
      // if (event is QuestionsLoading) {
      //   return Container(
      //     width: double.infinity,
      //     height: MediaQuery.of(context).size.height,
      //     child: Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // } else if (event is QuestionsLoaded) {
      var bloc = BlocProvider.of<ProfileBloc>(context);
      return KScaffoldScreen(
        isLeading: true,
        title: "Вопросы и ответы",
        body: event is QuestionsLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    elevation: 0,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        event.questions[index].isExpanded = !isExpanded;
                      });
                    },
                    children:
                        event.questions.map<ExpansionPanel>((Question item) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            dense: true,
                            title: Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isExpanded ? kPrimaryColor : null,
                              ),
                            ),
                          );
                        },
                        body: ListTile(
                          subtitle: Text(item.answer),
                        ),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      );
      // }
      // return Container(
      //   color: Colors.white,
      //   width: double.infinity,
      //   height: MediaQuery.of(context).size.height,
      //   child: Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // );
    });
  }
}
