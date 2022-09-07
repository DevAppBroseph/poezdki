import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarWidget extends StatefulWidget {
  const AddCarWidget({Key? key}) : super(key: key);

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends State<AddCarWidget> {
  final GlobalKey<FormState> _carKeyForm = GlobalKey<FormState>();

  TextEditingController carMade = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController carColor = TextEditingController();
  TextEditingController carNumber = TextEditingController();
  TextEditingController carSeats = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    return KScaffoldScreen(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      isLeading: true,
      title: "Добавить авто",
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _carKeyForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          KFormField(
                            validateFunction: Validations.validateTitle,
                            hintText: 'Марка автомобиля',
                            textEditingController: carMade,
                            inputAction: TextInputAction.next,
                          ),
                          KFormField(
                            validateFunction: Validations.validateTitle,
                            hintText: 'Модель автомобиля',
                            textEditingController: carModel,
                            inputAction: TextInputAction.next,
                          ),
                          KFormField(
                            hintText: 'Цвет',
                            textEditingController: carColor,
                            inputAction: TextInputAction.done,
                          ),
                          KFormField(
                            validateFunction: Validations.validateTitle,
                            hintText: 'с777сс799',
                            formatters: [
                              LengthLimitingTextInputFormatter(9),
                            ],
                            textEditingController: carNumber,
                            inputAction: TextInputAction.next,
                          ),
                          KFormField(
                            hintText: 'Количество мест',
                            textInputType: TextInputType.number,
                            textEditingController: carSeats,
                            validateFunction: Validations.validateTitle,
                            inputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FullWidthElevButton(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              title: "Добавить",
              onPressed: () {
                if (
                    // carMade.text.isEmpty &&
                    //   carModel.text.isNotEmpty &&
                    //   carSeats.text.isEmpty &&
                    _carKeyForm.currentState!.validate()) {
                  profileBloc.add(
                    CreateCar(
                      context,
                      Car(
                        mark: carMade.text.trim(),
                        model: carModel.text.trim(),
                        color: carColor.text.trim(),
                        vehicleNumber: carNumber.text.trim(),
                        countOfPassengers: 4,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
