import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../const/colors.dart';

class CreateRideDriverInfo extends StatefulWidget {
  final Departure from;
  final Departure to;
  final DateTime startTime;
  final List<Departure> stopsList;
  final Car car;

  const CreateRideDriverInfo(
      {Key? key,
      required this.from,
      required this.to,
      required this.startTime,
      required this.stopsList,
      required this.car})
      : super(key: key);

  @override
  State<CreateRideDriverInfo> createState() => _CreateRideDriverInfoState();
}

class _CreateRideDriverInfoState extends State<CreateRideDriverInfo> {
  final TextEditingController priceController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();

  bool _isPackageTransfer = false;
  bool _isTwoBackSeat = false;
  bool _isBagadgeTransfer = false;
  bool _isChildSeat = false;
  bool _isCondition = false;
  bool _isSmoking = false;
  bool _isPetTransfer = false;
  bool _isPickUpFromHome = false;
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      resizeToAvoidBottomInset: true,
      title: "Создание поездки",
      isLeading: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          _createRide()
        ],
      ),
    );
  }

  Widget _priceField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  scrollPadding: const EdgeInsets.only(bottom: 100),
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
    List<Stops> stops = [];
    for (var element in widget.stopsList) {
      stops.add(
        Stops(
          element.coords,
          element.district,
          element.name,
          element.population,
          element.subject,
          0,
          0,
        ),
      );
    }
    stops.add(
      Stops(
        widget.to.coords,
        widget.to.district,
        widget.to.name,
        widget.to.population,
        widget.to.subject,
        0,
        0,
      ),
    );
    final tripBloc = BlocProvider.of<TripsBloc>(context);
    final tripDriverBloc = BlocProvider.of<UserTripsDriverBloc>(context);
    return WidgetsBinding.instance.window.viewInsets.bottom > 0.0
        ? const SizedBox()
        : Align(
            alignment: Alignment.bottomCenter,
            child: FullWidthElevButton(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              title: "Опубликовать",
              onPressed: () async {
                final TripModel trip = TripModel(
                    car: widget.car,
                    departure: widget.from,
                    timeStart: widget.startTime.microsecondsSinceEpoch,
                    stops: stops,
                    package: _isPackageTransfer,
                    twoPlacesInBehind: _isTwoBackSeat,
                    baggage: _isBagadgeTransfer,
                    babyChair: _isChildSeat,
                    conditioner: _isCondition,
                    smoke: _isSmoking,
                    animals: _isPetTransfer,
                    price: int.parse(priceController.text.trim()));

                if (priceController.text.isNotEmpty) {
                  tripBloc.add(CreateUserTrip(context, trip));
                  tripDriverBloc.add(LoadUserTripsList());
                }
              },
            ),
          );
  }
}