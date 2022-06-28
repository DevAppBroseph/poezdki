import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';

class SignOutSheet extends StatelessWidget {
  const SignOutSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BottomSheetChildren(children: [
      Container(
        width: 100,
        height: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.grey),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Выход",
          style: TextStyle(
              color: kPrimaryRed, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 20, bottom: 40),
        child: Text(
          "Вы уверены что хотите выйти из учетной записи пользователя?",
          textAlign: TextAlign.center,
          style: TextStyle(color: kPrimaryDarkGrey),
        ),
      ),
      SizedBox(
        height: 100,
        child: Row(
          children: [
            Flexible(
              child: FullWidthElevButton(
                onPressed: () => Navigator.pop(context),
                title: "Остаться",
                color: kPrimaryColor,
              ),
            ),
            Flexible(
              child: FullWidthElevButton(
                onPressed: () {
                  Navigator.pop(context);
                  authBloc.add(LoggedOut());
                },
                title: "Да, выйти",
                color: kPrimaryRed,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
