import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/cars.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/trips/components/pick_car_search.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/formatter.dart';
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

  final btmSheet = BottomSheetCallAwait();

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
                          GestureDetector(
                            onTap: () async {
                              String? select = await btmSheet.wait(context,
                                useRootNavigator: true,
                                child: PickCarSearch(
                                  list: mark,
                                title: 'Марка',
                              ));

                              if(select != null) {
                                selectMark = select;
                                selectModel = null;
                                loadModel(selectMark!);
                              }
                            },
                            child: Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                child: Text(selectMark != null ? selectMark! : 'Марка', style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis,fontSize: 15),),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: selectMark == null ? null :  () async {
                              String? select = await btmSheet.wait(context,
                                useRootNavigator: true,
                                child: PickCarSearch(
                                  list: model,
                                title: 'Модель',
                              ));

                              if(select != null) {
                                selectModel = select;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                child: Text(selectModel != null ? selectModel! : 'Модель', style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis,fontSize: 15),),
                              ),
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
                            formatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
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
                        countOfPassengers: int.parse(carSeats.text),
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
