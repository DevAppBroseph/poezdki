import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_user.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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
  TextEditingController phoneController = TextEditingController();

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
    if (bookedSeats.contains(2)) seat2.isEmpty = false;
    if (bookedSeats.contains(3)) seat3.isEmpty = false;
    if (bookedSeats.contains(4)) seat4.isEmpty = false;

    return KScaffoldScreen(
        isLeading: true,
        backgroundColor: Colors.white,
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
            final state = BlocProvider.of<ProfileBloc>(context).state;
            final List<int> seats = [];
            if (state is ProfileLoaded) {
              if(state.user.phone == null || state.user.phone == '') {
                phoneController.text = '';
                InfoDialog().show(
                  buttonTitle: 'Подтвердить',
                  title: 'Введите ваш номер',
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
                if (selectedSeats.isEmpty) {
                  ErrorDialogs().showError("Необходимо выбрать место");
                } else {
                  for (var element in selectedSeats) {
                    seats.add(element.seatNumber);
                  }
                  tripBloc
                      .add(BookThisTrip(context, seats, widget.tripData.tripId!));
                }
              }
            }
          }),
    );
  }

  void _editUser(ProfileLoaded state) {
    print('1212');
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

  

  Widget _placePicker(context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/car_book.png',
          scale: 2.75,
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
