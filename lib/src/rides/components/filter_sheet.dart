// ignore_for_file: avoid_returning_null_for_void

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
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        const ListTile(
          title: Text(
            "Фильтр поиска",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SwitchListTile(
          title: const Text("Перевозка посылок"),
          value: _isPackageTransfer,
          onChanged: (value) => null,
        ),
        SwitchListTile(
          title: const Text("2 места на заднем сиденье"),
          value: _isTwoBackSeat,
          onChanged: (_) {},
        ),
        SwitchListTile(
            title: const Text("Перевозка багажа"),
            value: _isBagadgeTransfer,
            onChanged: (value) => null),
        SwitchListTile(
            title: const Text("Детское кресло"),
            value: _isChildSeat,
            onChanged: (value) => null),
        SwitchListTile(
            title: const Text("Кондиционер"),
            value: _isCondition,
            onChanged: (value) => null),
        SwitchListTile(
            title: const Text("Курение в салоне"),
            value: _isSmoking,
            onChanged: (value) => null),
        SwitchListTile(
            title: const Text("Перевозка животных"),
            value: _isPetTransfer,
            onChanged: (value) => null),
        const ListTile(
          title: Text("Забираю от дома"),
          trailing:  Text("Мужской"),
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
}
