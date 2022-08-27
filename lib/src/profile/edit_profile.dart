import 'dart:math';

import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/auth/components/signup_personal_info.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _regFormPersonal = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController surname = TextEditingController();

  final TextEditingController gender = TextEditingController();

  final TextEditingController dob = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? selectedGender;

  @override
  void initState() {
    name.text = widget.user.firstname ?? '';
    surname.text = widget.user.lastname ?? '';
    gender.text = widget.user.gender == null
        ? ''
        : widget.user.gender == 'male'
            ? 'Мужской'
            : 'Женский';

    phone.text = widget.user.phone ?? '';
    selectedGender = widget.user.gender;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.user.birth ?? 0);
    email.text = widget.user.email ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      backgroundColor: Colors.white,
      isLeading: true,
      title: 'Редактирование',
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SignUpPersonalInfo(
                      formKey: _regFormPersonal,
                      name: name,
                      surname: surname,
                      selectedDate: selectedDate,
                      genderCrl: gender,
                      onPickGender: () => _pickGender(context),
                      onPickDob: () => _pickDate(context),
                      dob: dob,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: KFormField(
                        hintText: 'Телефон',
                        textEditingController: phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: KFormField(
                        hintText: 'E-Mail ',
                        textEditingController: email,
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FullWidthElevButton(
              title: "Сохранить изменения",
              onPressed: () {
                _editUser();
                print('1212');
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editUser() {
    print('1212');
    BlocProvider.of<ProfileBloc>(context).add(
      EditProfileValues(
        UserModel(
          photo: widget.user.photo,
          firstname: name.text,
          email: email.text,
          lastname: surname.text,
          phone: phone.text,
          gender: selectedGender,
          birth: selectedDate.millisecondsSinceEpoch,
          cars: widget.user.cars,
        ),
        context,
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        final dateFormat = DateFormat.yMMMMd('ru').format(picked);
        setState(() {
          selectedDate = picked;
          dob.text = dateFormat;
          // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
        });
      }
    } catch (e) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        final dateFormat = DateFormat.yMMMMd('ru').format(picked);
        setState(() {
          selectedDate = picked;
          dob.text = dateFormat;
          // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
        });
      }
    }
  }

  void _pickGender(BuildContext context) {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) => Material(
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () => setState(() {
                        gender.text = "Мужской";
                        selectedGender = "male";
                        Navigator.pop(context);
                      }),
                      title: const Text("Мужской"),
                    ),
                    ListTile(
                      onTap: () => setState(() {
                        gender.text = "Женский";
                        selectedGender = "female";
                        Navigator.pop(context);
                      }),
                      title: const Text("Женский"),
                    ),
                  ],
                ),
              ),
            ));
  }
}
