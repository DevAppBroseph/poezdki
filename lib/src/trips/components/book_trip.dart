import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
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
  CarPlace seat3 = CarPlace(seatNumber: 3, isEmpty: true, isSelected: false);
  CarPlace seat4 = CarPlace(seatNumber: 4, isEmpty: true, isSelected: false);
  List<CarPlace> selectedSeats = [];
  num maxSeats = 4;
  List<int> bookedSeats = [];
  num freeSeats = 4;

  @override
  void initState() {
    widget.tripData.passengers?.forEach((element) {
      final seatsElement = element.seat;
      bookedSeats.addAll(seatsElement ?? []);
    });

    freeSeats = maxSeats - bookedSeats.length;

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (bookedSeats.contains(1)) seat1.isEmpty = false;
    if (bookedSeats.contains(2)) seat1.isEmpty = false;
    if (bookedSeats.contains(3)) seat1.isEmpty = false;
    if (bookedSeats.contains(4)) seat1.isEmpty = false;

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
              // const Text("Количество мест"),
              // _rangeSlider(),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Выберите места в салоне автомобиля",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
    final tripBloc = BlocProvider.of<TripsBloc>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: FullWidthElevButton(
          title: "Забронировать",
          onPressed: () async {
            final List<int> seats = [];
            if (selectedSeats.isEmpty) {
              ErrorDialogs().showError("Необходимо выбрать место");
            } else {
              for (var element in selectedSeats) {
                seats.add(element.seatNumber);
              }
              tripBloc
                  .add(BookThisTrip(context, seats, widget.tripData.tripId!));
            }
          }),
    );
  }

  Widget _placePicker(context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/car_book.png',
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
            setState(() {
              carPlace.isSelected = !carPlace.isSelected;
              selectedSeats.contains(carPlace)
                  ? selectedSeats.remove(carPlace)
                  : selectedSeats.add(carPlace);
              freeSeats = maxSeats - selectedSeats.length - bookedSeats.length;
            });
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
    return freeSeats >= 1
        ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SfSlider(
              min: 0.0,
              max: freeSeats,
              value: freeSeats,
              activeColor: kPrimaryColor,
              inactiveColor: kPrimaryWhite,
              dividerShape: const SfDividerShape(),
              trackShape: const SfTrackShape(),
              stepSize: 1,
              interval: 1,
              showTicks: true,
              showLabels: true,
              enableTooltip: false,
              minorTicksPerInterval: 0,
              onChanged: (dynamic value) {
                // setState(() {
                //   _sliderSwitchValue = value;
                // });
              },
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(23.0),
            child: Text("Свободных мест нет."),
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
  bool isEmpty;
  bool isSelected;

  CarPlace(
      {required this.seatNumber,
      required this.isEmpty,
      required this.isSelected});
}
