import 'dart:io';

import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/model/filter_model.dart';
import 'package:app_poezdka/model/gender_model.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TypeDate { start, end }

class SearchTripBottomSheet extends StatefulWidget {
  final FilterModel initFilter;
  const SearchTripBottomSheet({Key? key, required this.initFilter})
      : super(key: key);

  @override
  State<SearchTripBottomSheet> createState() => _SearchTripBottomSheetState();
}

class _SearchTripBottomSheetState extends State<SearchTripBottomSheet> {
  bool _isPackageTransfer = false;
  bool _isTwoBackSeat = false;
  bool _isBagadgeTransfer = false;
  bool _isChildSeat = false;
  bool _isConditioner = false;
  bool _isSmoking = false;
  bool _isPetTransfer = false;
  GenderModel? _gender;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  @override
  void initState() {
    _isPackageTransfer = widget.initFilter.isPackageTransfer;
    _isTwoBackSeat = widget.initFilter.isTwoBackSeat;
    _isBagadgeTransfer = widget.initFilter.isBagadgeTransfer;
    _isChildSeat = widget.initFilter.isChildSeat;
    _isConditioner = widget.initFilter.isConditioner;
    _isSmoking = widget.initFilter.isSmoking;
    _isPetTransfer = widget.initFilter.isPetTransfer;
    _gender = widget.initFilter.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetChildren(
      children: [
        const ListTile(
          title: Text(
            "Фильтр поиска",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SwitchListTile(
            title: switchTileTitle(img: 'box.png', title: "Перевозка посылок"),
            value: _isPackageTransfer,
            onChanged: (value) => setState(() {
                  _isPackageTransfer = value;
                })),
        SwitchListTile(
            title: switchTileTitle(
                img: 'sofa.png', title: "2 места на заднем сиденье"),
            value: _isTwoBackSeat,
            onChanged: (value) => setState(() {
                  _isTwoBackSeat = value;
                })),
        SwitchListTile(
            title: switchTileTitle(
                img: '3d-cube-scan.png', title: "Перевозка багажа"),
            value: _isBagadgeTransfer,
            onChanged: (value) => setState(() {
                  _isBagadgeTransfer = value;
                })),
        SwitchListTile(
            title: switchTileTitle(
                img: 'person-standing.png', title: "Детское кресло"),
            value: _isChildSeat,
            onChanged: (value) => setState(() {
                  _isChildSeat = value;
                })),
        SwitchListTile(
            title: switchTileTitle(
                img: 'cigarette.png', title: "Курение в салоне"),
            value: _isSmoking,
            onChanged: (value) => setState(() {
                  _isSmoking = value;
                })),
        SwitchListTile(
            title:
                switchTileTitle(img: 'github.png', title: "Перевозка животных"),
            value: _isPetTransfer,
            onChanged: (value) => setState(() {
                  _isPetTransfer = value;
                })),
        SwitchListTile(
            title: switchTileTitle(img: 'sun.png', title: "Кондиционер"),
            value: _isConditioner,
            onChanged: (value) => setState(() {
                  _isConditioner = value;
                })),
        genderTile(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(child: const Text('С:   ')),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => funcDate(TypeDate.start),
                    child: KFormField(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      enabled: false,
                      hintText:
                          DateFormat('dd.MM.yyyy hh:mm').format(DateTime.now()),
                      textEditingController: startDate,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(child: const Text('По:   ')),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => funcDate(TypeDate.end),
                    child: KFormField(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      enabled: false,
                      hintText:
                          DateFormat('dd.MM.yyyy hh:mm').format(DateTime.now()),
                      textEditingController: endDate,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FullWidthElevButton(
          title: "Применить",
          onPressed: () => Navigator.pop(
            context,
            FilterModel(
              isPackageTransfer: _isPackageTransfer,
              isTwoBackSeat: _isTwoBackSeat,
              isBagadgeTransfer: _isBagadgeTransfer,
              isChildSeat: _isChildSeat,
              isConditioner: _isConditioner,
              isSmoking: _isSmoking,
              isPetTransfer: _isPetTransfer,
              gender: _gender,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  void funcDate(TypeDate typeDate) async {
    if (Platform.isAndroid) {
      final value = await showDialog(
          context: context,
          builder: ((context) {
            return DatePickerDialog(
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2030),
            );
          }));
      if (value != null) {
        if (typeDate == TypeDate.start) {
          startDate.text = DateFormat('dd.MM.yyyy hh:mm').format(value);
        } else {
          endDate.text = DateFormat('dd.MM.yyyy hh:mm').format(value);
        }
      }
    }
    final value = await showDialog(
      barrierDismissible: true,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              color: Colors.grey[200],
              child: CupertinoDatePicker(
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  if (typeDate == TypeDate.start) {
                    startDate.text = DateFormat('dd.MM.yyyy hh:mm').format(value);
                  } else {
                    endDate.text = DateFormat('dd.MM.yyyy hh:mm').format(value);
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget switchTileTitle({
    required String img,
    required String title,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("$iconPath/$img"),
        const SizedBox(
          width: 14,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget genderTile() {
    return ListTile(
      onTap: () => genderFilter(),
      minLeadingWidth: 3,
      leading: Image.asset("$iconPath/man.png"),
      title: const Text("Пол водителя"),
      trailing: Text(_gender == null ? "Любой" : _gender!.gender),
    );
  }

  void genderFilter() {
    if (_gender == null) {
      setState(() {
        _gender = genderList[0];
      });
    } else if (_gender == genderList[0]) {
      setState(() {
        _gender = genderList[1];
      });
    } else if (_gender == genderList[1]) {
      setState(() {
        _gender = null;
      });
    }
  }
}
