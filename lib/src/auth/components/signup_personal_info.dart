import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPersonalInfo extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController surname;
  final TextEditingController genderCrl;
  final TextEditingController dob;
  final String? gender;
  final DateTime selectedDate;
  final Function onPickGender;
  final Function onPickDob;
  const SignUpPersonalInfo(
      {Key? key,
      required this.formKey,
      required this.name,
      required this.surname,
      this.gender,
      required this.selectedDate,
      required this.genderCrl,
      required this.onPickGender,
      required this.onPickDob,
      required this.dob})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            KFormField(
              hintText: 'Ваше Имя*',
              textEditingController: name,
              validateFunction: Validations.validateName,
            ),
            KFormField(
              hintText: 'Ваша Фамилия',
              textEditingController: surname,
            ),
            KFormField(
              onTap: onPickGender,
              readOnly: true,
              hintText: 'Пол*',
              textEditingController: genderCrl,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    gender != null ? gender! : "Выберите пол",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            KFormField(
              onTap: onPickDob,
              readOnly: true,
              hintText: 'ДД.ММ.ГГ*',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Дата рождения",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              textEditingController: dob,
              validateFunction: (value) {
                if (value!.isNotEmpty) return null;
                return "error";
              },
            ),
          ],
        ),
      ),
    );
  }
}
