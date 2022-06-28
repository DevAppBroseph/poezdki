import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  static const boldText = TextStyle(fontWeight: FontWeight.bold);
  final TextEditingController paymentCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        resizeToAvoidBottomInset: false,
        isLeading: true,
        title: "Баланс",
        body: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Entypo.wallet,
                      color: kPrimaryColor,
                      size: 100,
                    ),
                  ),
                  payment(),
                  payField(),
                ],
              ),
            ),
            submit()
          ],
        ));
  }

  Widget payment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: ListTile(
              dense: true,
              title: const Text(
                "Баллы",
                style: boldText,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "700",
                    style: boldText,
                  ),
                  Icon(
                    Entypo.database,
                    color: kPrimaryColor,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            dense: true,
            title: const Text(
              "Текущий баланс",
              style: boldText,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "1231",
                  style: boldText,
                ),
                Icon(
                  Fontisto.rouble,
                  color: Colors.grey,
                  size: 12,
                )
              ],
            ),
          ),
          // payField()
        ],
      ),
    );
  }

  Widget payField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
            "Пополнить на",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: ' Сумма ',
                
                  hintStyle: TextStyle(wordSpacing: 5),
                  contentPadding: EdgeInsets.only(right: 5.0),
                  
                ),
                textAlign: TextAlign.end,
                controller: paymentCtr,
                onChanged: (val) => setState(() {}),
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

  Widget submit() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Сумма для пополнения ${paymentCtr.text.isNotEmpty ? paymentCtr.text : 0} ₽",
              style: const TextStyle(fontSize: 12),
            ),
            FullWidthElevButton(
                onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
                title: "Оплатить")
          ],
        ),
      ),
    );
  }
}
