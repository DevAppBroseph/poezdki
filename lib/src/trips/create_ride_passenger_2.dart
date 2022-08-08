import 'package:app_poezdka/bloc/trips_passenger/trips_passenger_bloc.dart';

import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../const/colors.dart';

class CreateRidePassenger2 extends StatefulWidget {
  final Departure from;
  final Departure to;
  final DateTime startTime;


  const CreateRidePassenger2({
    Key? key,
    required this.from,
    required this.to,
    required this.startTime,

  }) : super(key: key);

  @override
  State<CreateRidePassenger2> createState() => _CreateRidePassenger2State();
}

class _CreateRidePassenger2State extends State<CreateRidePassenger2> {
  final TextEditingController priceController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();

  bool _isPackageTransfer = false;
  bool _isTwoBackSeat = false;
  bool _isBagadgeTransfer = false;
  bool _isChildSeat = false;
  bool _isCondition = false;
  bool _isSmoking = false;
  bool _isPetTransfer = false;
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      resizeToAvoidBottomInset: false,
      title: "Создание поездки",
      isLeading: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  _priceField(),
                ],
              ),
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
                config: KeyboardActionsConfig(
                    defaultDoneWidget: const Text("Готово"),
                    actions: [
                      KeyboardActionsItem(
                        displayArrows: false,
                        focusNode: _nodeText1,
                        onTapAction: () => _nodeText1.unfocus(),
                        // footerBuilder: (context) => PreferredSize(
                        //     child: ListTile(
                        //       trailing: Image.asset("$iconPath/ruble.png"),
                        //       title: TextField(
                        //         decoration: const InputDecoration(
                        //           border: InputBorder.none
                        //         ),
                        //         readOnly: true,
                        //         textAlign: TextAlign.end,
                        //         controller: priceController),
                        //     ),
                        //     preferredSize:
                        //         Size(MediaQuery.of(context).size.width, 50))
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
    final tripBloc =
        BlocProvider.of<TripsPassengerBloc>(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: FullWidthElevButton(
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        title: "Опубликовать",
        onPressed: () async {
          final TripModel trip = TripModel(
              departure: widget.from,
              timeStart: widget.startTime.microsecondsSinceEpoch,
              stops: [
                Stops(
                    widget.to.coords,
                    widget.to.district,
                    widget.to.name,
                    widget.to.population,
                    widget.to.subject,
                    0,
                    0)
              ],
              package: _isPackageTransfer,
              twoPlacesInBehind: _isTwoBackSeat,
              baggage: _isBagadgeTransfer,
              babyChair: _isChildSeat,
              conditioner: _isCondition,
              smoke: _isSmoking,
              animals: _isPetTransfer,
              price: int.parse(priceController.text.trim()));

          if (priceController.text.isNotEmpty) {
            tripBloc.add(CreatePassangerTrip(context, trip));
          }
        },
      ),
    );
  }
}
