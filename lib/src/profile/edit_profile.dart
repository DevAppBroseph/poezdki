import 'dart:convert';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/auth/components/signup_personal_info.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final btmSheet = BottomSheetCallAwait();

  CountryCode? countryCode;
  int maxLength = 10;
  String selectCode = '+7';

  void loadDB() async {
    String str = await rootBundle.loadString('assets/phone/code_phone.json');
    countryCode = CountryCode.fromJson(json.decode(str));
  }

  @override
  void initState() {
    loadDB();
    name.text = widget.user.firstname ?? '';
    surname.text = widget.user.lastname ?? '';
    gender.text = widget.user.gender == null
        ? ''
        : widget.user.gender == 'male'
            ? 'Мужской'
            : 'Женский';
    if (widget.user.phone != null) {
      String phoneTemp = '';
      for (int i = 2; i < widget.user.phone!.length; i++) {
        phoneTemp += widget.user.phone![i];
      }
      phone.text = phoneTemp;
    } else {
      phone.text = '';
    }

    selectedGender = widget.user.gender;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.user.birth ?? 0);
    email.text = widget.user.email ?? '';

    final date = DateTime.fromMillisecondsSinceEpoch(widget.user.birth ?? 0);

    String time = '';
    for (int i = 0; i < 10; i++) {
      time += date.toString()[i];
    }

    final splitTime = time.split('-');

    dob.text = splitTime[2] + '.' + splitTime[1] + '.' + splitTime[0];

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
                      // onPickDob: () => _pickDate(context),
                      dob: dob,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: Row(
                        children: [
                          PhoneTextField(
                              hintText: 'Телефон',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    Country? select = await btmSheet.wait(
                                      context,
                                      useRootNavigator: true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount:
                                              countryCode!.country.length,
                                          itemBuilder: ((context, index) {
                                            return MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    countryCode!
                                                        .country[index]);
                                              },
                                              child: SizedBox(
                                                height: 30,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        countryCode!
                                                            .country[index]
                                                            .name!,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      countryCode!
                                                          .country[index]
                                                          .dialCode!,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    );
                                    if (select != null) {
                                      setState(() {
                                        maxLength =
                                            int.parse(select.lengthPhone!) -
                                                select.dialCode!.length;
                                        selectCode = select.dialCode!;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        selectCode,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              controller: phone,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(maxLength)
                              ],
                              validateFunction: Validations.validatePhone)
                        ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editUser() {
    final parseDate = dob.text.split('.');
    final date = DateTime.parse(
        '${parseDate[2]}-${parseDate[1]}-${parseDate[0]} 00:00:00.000');
    BlocProvider.of<ProfileBloc>(context).add(
      EditProfileValues(
        UserModel(
          photo: widget.user.photo,
          firstname: name.text,
          email: email.text,
          lastname: surname.text,
          phone: selectCode + phone.text,
          gender: selectedGender,
          birth: date.millisecondsSinceEpoch,
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
