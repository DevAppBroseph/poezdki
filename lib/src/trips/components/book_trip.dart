import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BookTrip extends StatefulWidget {
  final TripModel tripData;
  const BookTrip({Key? key, required this.tripData}) : super(key: key);

  @override
  State<BookTrip> createState() => _BookTripState();
}

class _BookTripState extends State<BookTrip> {
  CarPlace seat1 = CarPlace(seatNumber: 1, isEmpty: true, isSelected: false);
  CarPlace seat2 = CarPlace(seatNumber: 2, isEmpty: true, isSelected: false);
  CarPlace seat3 = CarPlace(seatNumber: 3, isEmpty: false, isSelected: false);
  CarPlace seat4 = CarPlace(seatNumber: 4, isEmpty: false, isSelected: false);
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
              _placePicker(context),
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
            img: "assets/img/like.png",
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

  Widget _placePicker(context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/carbg.png',
          scale: 0.8,
        ),
        carPlace(context, positionTop: 180, positionLeft: 112, carPlace: seat1),
        carPlace(context, positionTop: 215, positionLeft: 42, carPlace: seat2),
        carPlace(context, positionTop: 215, positionLeft: 77, carPlace: seat3),
        carPlace(context, positionTop: 215, positionLeft: 112, carPlace: seat4)
      ],
    );
  }

  Widget carPlace(context,
      {required double positionTop,
      required double positionLeft,
      required CarPlace carPlace}) {
    return Positioned(
      top: positionTop,
      left: positionLeft,
      child: InkWell(
        onTap: () {
          if (carPlace.isEmpty) {
            carPlace.isSelected == true;

            setState(() {});
          }
        },
        child: carPlace.isEmpty == false
            ? const BlockedSeat()
            : carPlace.isSelected
                ? const SelectedSeat()
                : const EmptySeat(),
      ),
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
          });
        },
      ),
    );
  }
}

class SelectedSeat extends StatelessWidget {
  const SelectedSeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: kPrimaryColor),
      child: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      height: 30,
      width: 30,
    );
  }
}

class EmptySeat extends StatelessWidget {
  const EmptySeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: kPrimaryLightGrey),
      child: null,
      height: 30,
      width: 30,
    );
  }
}

class BlockedSeat extends StatelessWidget {
  const BlockedSeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: kPrimaryRed),
      child: const Icon(
        Icons.lock,
        color: Colors.white,
      ),
      height: 30,
      width: 30,
    );
  }
}

class CarPlace {
  final int seatNumber;
  final bool isEmpty;
  final bool isSelected;

  CarPlace(
      {required this.seatNumber,
      required this.isEmpty,
      required this.isSelected});
}
