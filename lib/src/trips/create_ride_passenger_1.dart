import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_user.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../widget/bottom_sheet/btm_builder.dart';
import '../../widget/button/full_width_elevated_button.dart';
import 'components/pick_city.dart';
import 'create_ride_passenger_2.dart';

class CreateRidePassenger extends StatefulWidget {
  const CreateRidePassenger({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateRidePassenger> createState() => _CreateRidePassengerState();
}

class _CreateRidePassengerState extends State<CreateRidePassenger> {
  final btmSheet = BottomSheetCallAwait();
  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  final List<TextEditingController> _midwayControllers = [];
  var midWays = <TextEditingController>[];
  Departure? from;
  Departure? to;
  DateTime? date;
  TimeOfDay? time;

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle pickerStyle =
        TextStyle(color: Colors.grey, fontWeight: FontWeight.w300);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WayPoints(
                      pickDestinitionStops: () {},
                      pickDestinitionFrom: () =>
                          pickDestinition(startWay, true, "???????????? ?????????????"),
                      pickDestinitionTo: () =>
                          pickDestinition(endWay, false, "???????? ?????????"),
                      startWay: startWay,
                      endWay: endWay,
                      midWays: null,
                      midwayControllers: _midwayControllers,
                      onAdd: () {},
                      onDelete: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("????????"),
                            trailing: TextButton(
                                onPressed: () => _pickDate(),
                                child: Text(
                                  date != null
                                      ? DateFormat.yMMMMd('ru').format(date!)
                                      : "?????????????? ????????",
                                  style: pickerStyle,
                                )),
                          ),
                          ListTile(
                            title: const Text("?????????? ????????????"),
                            trailing: TextButton(
                                onPressed: () => _pickTime(),
                                child: Text(
                                  time != null
                                      ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
                                      : "?????????????? ??????????",
                                  style: pickerStyle,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        _nextButton(context)
      ],
    );
  }

  Widget _nextButton(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FullWidthElevButton(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        title: "??????????",
        onPressed: () async {
          if (from != null && to != null && date != null && time != null) {
            // if
            //  (from!.coords.toString() == to!.coords.toString()) {
            //   ErrorDialogs().showError("???????????? ???? ?????????? ??????????????????");
            // } else
            {
              final bool success = await pushNewScreen(context,
                  withNavBar: false,
                  screen: CreateRidePassenger2(
                    from: from!,
                    to: to!,
                    startTime: DateTime(date!.year, date!.month, date!.day,
                        time!.hour, time!.minute),
                  ));
              if (success) {
                cleanData();
              }
            }
          } else {
            final state = BlocProvider.of<ProfileBloc>(context).state;
            if (state is ProfileLoaded) {
              if(state.user.phone == null || state.user.phone == '') {
                phoneController.text = '';
                InfoDialog().show(
                  buttonTitle: '??????????????????????',
                  title: '?????????????? ?????? ??????????',
                  children: [
                    KFormField(
                      hintText: '+79876543210',
                      textInputType: TextInputType.phone,
                      textEditingController: phoneController,
                      validateFunction: Validations.validatePhone,
                      inputAction: TextInputAction.done,
                      formatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                    ),
                  ],
                  onPressed: () {
                    final validate = Validations.validatePhone(phoneController.text);
                    if(validate == null) {
                      final dio = Dio();
                      dio.options.headers["Authorization"] = state.user.token;
                      dio.put(addPhone, data: {'phone_number': phoneController.text}).then((value) {
                        _editUser(state);
                        SmartDialog.dismiss();
                      });
                    } 
                  }
                );
              } else {
                InfoDialog().show(
                  customIcon: const Icon(
                    CupertinoIcons.info_circle,
                    size: 90,
                    color: kPrimaryColor,
                  ),
                  title: "?????? ???? ???? ??????:",
                  children: [
                    const ListTile(
                      title: Text("???????????????????? ??????????????:"),
                    ),
                    _infoChecker(title: "???????????? ??????????????", object: from),
                    _infoChecker(title: "???????? ?????????????? ????????", object: to),
                    _infoChecker(
                      title: "???????? ??????????????",
                      object: date,
                    ),
                    _infoChecker(
                      title: "?????????? ????????????",
                      object: time,
                    ),
                  ]);
              }
            } else {
              InfoDialog().show(
                customIcon: const Icon(
                  CupertinoIcons.info_circle,
                  size: 90,
                  color: kPrimaryColor,
                ),
                title: "?????? ???? ???? ??????:",
                children: [
                  const ListTile(
                    title: Text("???????????????????? ??????????????:"),
                  ),
                  _infoChecker(title: "???????????? ??????????????", object: from),
                  _infoChecker(title: "???????? ?????????????? ????????", object: to),
                  _infoChecker(
                    title: "???????? ??????????????",
                    object: date,
                  ),
                  _infoChecker(
                    title: "?????????? ????????????",
                    object: time,
                  ),
                ]);
            }
          }
        },
      ),
    );
  }

  void _editUser(ProfileLoaded state) {
    BlocProvider.of<ProfileBloc>(context).add(
      UpdateProfile(
        UserModel(
          photo: state.user.photo,
          firstname: state.user.firstname,
          email: state.user.email,
          lastname: state.user.lastname,
          phone: phoneController.text,
          gender: state.user.gender,
          birth: state.user.birth,
          cars: state.user.cars,
        ),
        // context,
      ),
    );
  }

  Widget _infoChecker({
    Object? object,
    required String title,
  }) {
    return object == null
        ? ListTile(
            minLeadingWidth: 10,
            dense: true,
            leading: const Icon(Icons.chevron_right),
            title: Text(title),
          )
        : const SizedBox();
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
        helpText: "???????????????? ???????? ??????????????",
        cancelText: "????????????",
        confirmText: "????",
        locale: const Locale("ru", "RU"),
        context: context,
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;

        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
        helpText: "?????????????? ?????????? ??????????????",
        cancelText: "????????????",
        confirmText: "????",
        hourLabelText: "????????",
        minuteLabelText: "????????????",
        context: context,
        initialTime: time ?? TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                alwaysUse24HourFormat: true),
            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
            child: widget!,
          );
        });
    if (picked != null) {
      setState(() {
        time = picked;

        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }

  void pickDestinition(
      TextEditingController contoller, bool isFrom, String title) async {
    final Departure? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        isFrom ? from = destinition : to = destinition;
      });
    }
  }

  void cleanData() async {
    from = null;
    to = null;
    date = null;
    time = null;
    startWay.clear();
    midWays.clear();
    endWay.clear();
    _midwayControllers.clear();
  }
}
