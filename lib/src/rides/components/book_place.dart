import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BookingRidePlace extends StatefulWidget {
  const BookingRidePlace({Key? key}) : super(key: key);

  @override
  State<BookingRidePlace> createState() => _BookingRidePlaceState();
}

class _BookingRidePlaceState extends State<BookingRidePlace> {
  bool seat1 = true;
  bool seat2 = false;
  bool seat3 = false;

  double _value = 1.0;
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Бронирование",
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text("Количество мест"),
              _rangeSlider(),
              const SizedBox(
                height: 40,
              ),
              const Text("Выберите места в салоне автомобиля"),
              const SizedBox(
                height: 40,
              ),
              _placePicker(),
              _submit()
            ],
          ),
        ));
  }

  Widget _submit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: FullWidthElevButton(
        title: "Забронировать",
        onPressed: () => InfoDialog().show(
            title: "Ваше место забронировано!",
            img: "assets/img/like.svg",
            description:
                "Желаем вам хорошей поездки. Вы можете отменить свою поездку в разделе Профиль",
            onPressed: () {
              SmartDialog.dismiss();
              Navigator.pop(context);
              Navigator.pop(context);
            }),
      ),
    );
  }

  Widget _placePicker() {
    return Stack(
      children: [
        Image.asset(
          'assets/img/carbg.png',
          scale: 0.8,
        ),
        Positioned(
          top: 180,
          left: 112,
          child: Container(
            color: seat1 ? kPrimaryColor : kPrimaryLightGrey,
            child: seat1
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            height: 30,
            width: 30,
          ),
        ),
        Positioned(
          top: 215,
          left: 112,
          child: Container(
            color: seat2 ? kPrimaryColor : kPrimaryLightGrey,
            child: seat2
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            height: 30,
            width: 30,
          ),
        ),
        Positioned(
          top: 215,
          left: 77,
          child: Container(
            color: seat3 ? kPrimaryColor : kPrimaryLightGrey,
            child: seat3
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            height: 30,
            width: 30,
          ),
        ),
        Positioned(
          top: 215,
          left: 42,
          child: Container(
            color: kPrimaryRed,
            child: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }

  Widget _rangeSlider() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SfSlider(
        min: 1.0,
        max: 3.0,
        value: _value,
        activeColor: kPrimaryColor,
        inactiveColor: kPrimaryWhite,
        dividerShape: const SfDividerShape(),
        stepSize: 1,
        interval: 1,
        showTicks: true,
        showLabels: true,
        enableTooltip: false,
        minorTicksPerInterval: 0,
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
            if (_value == 1) {
              seat1 = true;
              seat2 = false;
              seat3 = false;
            }
            if (_value == 2) {
              seat1 = true;
              seat2 = true;
              seat3 = false;
            }
            if (_value == 3) {
              seat1 = true;
              seat2 = true;
              seat3 = true;
            }
          });
        },
      ),
    );
  }
}
