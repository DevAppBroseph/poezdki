import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/cars.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search2/dropdown_search2.dart';

class AddCarWidget extends StatefulWidget {
  const AddCarWidget({Key? key}) : super(key: key);

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends State<AddCarWidget> {
  final GlobalKey<FormState> _carKeyForm = GlobalKey<FormState>();

  TextEditingController carYear = TextEditingController();
  TextEditingController carColor = TextEditingController();
  TextEditingController carNumber = TextEditingController();
  TextEditingController carSeats = TextEditingController();

  String? selectMark;
  String? selectModel;

  List<String>? mark = [];
  List<String>? model = [];

  CarsModel? cars;

  void loadDB() async {
    String jsCode = await rootBundle.loadString('assets/car/cars1.json');
    cars = carsFromJson(jsCode);
    loadMarks();
  }

  void loadMarks() {
    for (var element in cars!.list.keys) {
      mark!.add(element);
    }
    setState(() {});
  }

  void loadModel(String key) {
    model = cars!.list[key];
    setState(() { });
  }

  @override
  void initState() {
    super.initState();
    loadDB();
  }

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
                          Container(
                            height: 65,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownSearch<String>(
                              dropdownSearchDecoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                filled: true,
                              ),
                              selectedItem: selectMark != null ? selectMark! : 'Модель',
                              enabled: mark!.isEmpty ? false : true,
                              mode: Mode.BOTTOM_SHEET,
                              showSearchBox: true,
                              hint: selectMark != null ? selectMark! : 'Марка',
                              items: mark!.map((String value) {
                                return value;
                              }).toList(),
                              onChanged: (value) {
                                selectMark = value!;
                                selectModel = null;
                                loadModel(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 65,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownSearch<String>(
                              dropdownSearchDecoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                filled: true,
                              ),
                              selectedItem: selectModel != null ? selectModel! : 'Модель',
                              enabled: model!.isEmpty ? false : true,
                              mode: Mode.BOTTOM_SHEET,
                              showSearchBox: true,
                              hint: selectModel != null ? selectModel! : 'Модель',
                              items: model!.map((String value) {
                                return value;
                              }).toList(),
                              onChanged: (value) {
                                selectModel = value!;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          KFormField(
                            validateFunction: Validations.validateYear,
                            hintText: 'Год',
                            formatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            textInputType: TextInputType.number,
                            textEditingController: carYear,
                            inputAction: TextInputAction.done,
                          ),
                          KFormField(
                            hintText: 'Цвет',
                            textEditingController: carColor,
                            validateFunction: Validations.validateTitle,
                            inputAction: TextInputAction.done,
                          ),
                          KFormField(
                            validateFunction: Validations.validateNumber,
                            hintText: 'С777СС799',
                            formatters: [
                              LengthLimitingTextInputFormatter(9),
                              UpperCaseTextFormatter(),
                            ],
                            textEditingController: carNumber,
                            inputAction: TextInputAction.next,
                          ),
                          KFormField(
                            hintText: 'Количество пассажирских мест',
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
                if (_carKeyForm.currentState!.validate() && selectMark != '' && selectModel != '') {
                  profileBloc.add(
                    CreateCar(
                      context,
                      Car(
                        mark: selectMark,
                        model: selectModel,
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
