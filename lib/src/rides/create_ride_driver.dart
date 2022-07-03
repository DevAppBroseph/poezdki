import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';

import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'components/ride_main_info.dart';

class CreateRideDriver extends StatefulWidget {
  const CreateRideDriver({Key? key}) : super(key: key);

  @override
  State<CreateRideDriver> createState() => _CreateRideDriverState();
}

class _CreateRideDriverState extends State<CreateRideDriver> {
  DateTime? date;
  TimeOfDay? time;

  final FocusNode _nodeText1 = FocusNode();

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final List<TextEditingController> _midwayControllers = [];
  var midWays = <TextEditingController>[];
  bool _isPackageTransfer = false;
  bool _isTwoBackSeat = false;
  bool _isBagadgeTransfer = false;
  bool _isChildSeat = false;
  bool _isCondition = false;
  bool _isSmoking = false;
  bool _isPetTransfer = false;
  bool _isPickUpFromHome = false;

  final PageController pageController = PageController();
  int numberOfPages = 2;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    RideMainInfo(
                      startWay: startWay,
                      endWay: endWay,
                      midWays: midWays,
                      midwayControllers: _midwayControllers,
                      onAdd: () {
                        setState(() {
                          midWays.add(TextEditingController());
                          _midwayControllers.add(TextEditingController());
                        });
                      },
                      onDelete: () {
                        setState(() {});
                      },
                      date: date,
                      time: time,
                      onPickDate: () => _pickDate(),
                      onPickTime: () => _pickTime(),
                    ),
                    _nextButton()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SwitchListTile(
                          title: const Text("Перевозка посылок"),
                          value: _isPackageTransfer,
                          onChanged: (value) => setState(() {
                                _isPackageTransfer = value;
                              })),
                      SwitchListTile(
                          title: const Text("2 места на заднем сиденье"),
                          value: _isTwoBackSeat,
                          onChanged: (value) => setState(() {
                                _isTwoBackSeat = value;
                              })),
                      SwitchListTile(
                          title: const Text("Перевозка багажа"),
                          value: _isBagadgeTransfer,
                          onChanged: (value) => setState(() {
                                _isBagadgeTransfer = value;
                              })),
                      SwitchListTile(
                          title: const Text("Детское кресло"),
                          value: _isChildSeat,
                          onChanged: (value) => setState(() {
                                _isChildSeat = value;
                              })),
                      SwitchListTile(
                          title: const Text("Кондиционер"),
                          value: _isCondition,
                          onChanged: (value) => setState(() {
                                _isCondition = value;
                              })),
                      SwitchListTile(
                          title: const Text("Курение в салоне"),
                          value: _isSmoking,
                          onChanged: (value) => setState(() {
                                _isSmoking = value;
                              })),
                      SwitchListTile(
                          title: const Text("Перевозка животных"),
                          value: _isPetTransfer,
                          onChanged: (value) => setState(() {
                                _isPetTransfer = value;
                              })),
                      SwitchListTile(
                          title: const Text("Забираю от дома"),
                          value: _isPickUpFromHome,
                          onChanged: (value) => setState(() {
                                _isPickUpFromHome = value;
                              })),
                      _priceField(),
                      _createRide()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: kPrimaryWhite),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Цена",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: KeyboardActions(
                config: KeyboardActionsConfig(actions: [
                  KeyboardActionsItem(
                    focusNode: _nodeText1,
                    onTapAction: () => _nodeText1.unfocus(),
                  ),
                ]),
                child: TextFormField(
                  focusNode: _nodeText1,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    // suffixText: "1000",
                    hintStyle: TextStyle(wordSpacing: 5),
                    contentPadding: EdgeInsets.only(right: 5.0, top: 10),
                  ),
                  textAlign: TextAlign.end,
                  controller: priceController,
                  onChanged: (val) => setState(() {}),
                ),
              ),
            ),
          ),
          const Icon(
            Fontisto.rouble,
            color: Colors.grey,
            size: 12,
          )
        ],
      ),
    );
  }

  Widget _createRide() {
    final db = Provider.of<MyDatabase>(context, listen: false).rideDao;
    final dbUser = Provider.of<MyDatabase>(context, listen: false).userDao;
    return FullWidthElevButton(
      title: "Опубликовать",
      onPressed: () async {
        final owner = await dbUser.getUserData();
        final rideData = RideData(
            id: null,
            owner: owner!.id!,
            ownerName: owner.name,
            from: startWay.text.trim(),
            to: endWay.text.trim(),
            date: date,
            time: DateTime(
                date!.year, date!.month, date!.day, time!.hour, time!.minute),
            car: "BMW 3 ",
            isPackageTransfer: _isPackageTransfer,
            isTwoBackSeat: _isTwoBackSeat,
            isBagadgeTransfer: _isBagadgeTransfer,
            isChildSeat: _isChildSeat,
            isCondition: _isCondition,
            isSmoking: _isSmoking,
            isPetTransfer: _isPetTransfer,
            isPickUpFromHome: _isPickUpFromHome,
            price: double.parse(priceController.text.trim()));

        await db.createRide(rideData);

        InfoDialog().show(
          img: "assets/img/like.png",
            title: "Ваша поездка создана!",
            description: "Ожидайте попутчиков.");
        setState(() {
          startWay.clear();
          endWay.clear();
          priceController.clear();
          midWays.clear();
          _midwayControllers.clear();
          date = null;
          time = null;
          pageController.animateToPage(0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn);
        });
      },
    );
  }

  Widget _nextButton() {
    return FullWidthElevButton(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: "Далее",
      onPressed: () {
        if (startWay.text.isEmpty ||
            endWay.text.isEmpty ||
            date == null ||
            time == null) {
          InfoDialog().show(
              customIcon: const Icon(
                CupertinoIcons.info_circle,
                size: 90,
                color: kPrimaryColor,
              ),
              title: "Что то не так:",
              children: [
                const ListTile(
                  title: Text("Необходимо указать:"),
                ),
                _infoChecker(
                    title: "Откуда поедете",
                    controller: startWay,
                    object: "startWay"),
                _infoChecker(
                    title: "Куда держите путь",
                    controller: endWay,
                    object: "endWay"),
                _infoChecker(
                    title: "Дата поездки",
                    object: date,
                    controller: TextEditingController(text: "Date")),
                _infoChecker(
                    title: "Время выезда",
                    object: time,
                    controller: TextEditingController(text: "Date")),
              ]);
        } else {
          setState(() {
            currentPage++;
            pageController.animateToPage(currentPage++,
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn);
          });
        }
      },
    );
  }

  Widget _infoChecker({
    Object? object,
    TextEditingController? controller,
    required String title,
  }) {
    return object == null || controller!.text.isEmpty
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
        context: context,
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
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
        context: context,
        initialTime: time ?? TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, widget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: widget!);
        });
    if (picked != null) {
      setState(() {
        time = picked;

        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }
}
