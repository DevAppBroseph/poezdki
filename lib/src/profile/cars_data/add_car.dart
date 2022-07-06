import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddCarWidget extends StatefulWidget {
  const AddCarWidget({Key? key}) : super(key: key);

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends State<AddCarWidget> {
  TextEditingController carModel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BottomSheetChildren(
      children: [
        KFormField(
            hintText: 'Введите марку и модель автомобиля',
            textEditingController: carModel),
        Row(
          children: [
            Expanded(
              child: FullWidthElevButton(
                title: "Сохранить",
                onPressed: () {},
              ),
            ),
            Expanded(
                child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Отмена"))),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
