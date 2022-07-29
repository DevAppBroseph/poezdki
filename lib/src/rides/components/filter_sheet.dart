// ignore_for_file: avoid_returning_null_for_void

import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  final bool _isPackageTransfer = false;
  final bool _isTwoBackSeat = false;
  final bool _isBagadgeTransfer = false;
  final bool _isChildSeat = false;
  final bool _isCondition = false;
  final bool _isSmoking = false;
  final bool _isPetTransfer = false;
  // final bool _isPickUpFromHome = false;
  const FilterSheet({Key? key}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext cxt) {
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
        _switchTile(
            img: 'box.png',
            title: "Перевозка посылок",
            value: _isPackageTransfer,
            onChanged: (value) => null),
        _switchTile(
            img: 'sofa.png',
            title: "2 места на заднем сиденье",
            value: _isTwoBackSeat,
            onChanged: (value) => null),
        _switchTile(
            img: '3d-cube-scan.png',
            title: "Перевозка багажа",
            value: _isBagadgeTransfer,
            onChanged: (value) => null),
        _switchTile(
            img: 'person-standing.png',
            title: "Детское кресло",
            value: _isChildSeat,
            onChanged: (value) => null),
        _switchTile(
            img: 'cigarette.png',
            title: "Курение в салоне",
            value: _isSmoking,
            onChanged: (value) => null),
        _switchTile(
            img: 'github.png',
            title: "Перевозка животных",
            value: _isPetTransfer,
            onChanged: (value) => null),
        _switchTile(
            img: 'sun.png',
            title: "Кондиционер",
            value: _isCondition,
            onChanged: (value) => null),
        ListTile(
          minLeadingWidth: 3,
          leading: Image.asset("$iconPath/man.png"),
          title: const Text("Пол водителя"),
          trailing: const Text("Мужской"),
        ),
        FullWidthElevButton(
          title: "Применить",
          onPressed: () => Navigator.pop(cxt),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _switchTile(
      {required String img,
      required String title,
      required bool value,
      Function(bool)? onChanged}) {
    return SwitchListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("$iconPath$img"),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
        value: value,
        onChanged: onChanged);
  }
}
