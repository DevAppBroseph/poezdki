import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:flutter/material.dart';

import 'sign_out.dart';

class ProfileBtn extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final String icon;
  // final IconData icon;
  const ProfileBtn(
      {Key? key, required this.title, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const path = "assets/img";
    return ListTile(
      onTap: onPressed as void Function()?,
      minLeadingWidth: 5,
      leading: Image.asset(
        "$path/$icon.png",
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btm = BottomSheetCall();
    const path = "assets/img";
    return ListTile(
      onTap: () {
        btm.show(context,
            topRadius: const Radius.circular(50),
            useRootNavigator: true,
            child: const SignOutSheet());
      },
      minLeadingWidth: 10,
      leading: Image.asset("$path/logoutlogout.png"),
      title: const Text(
        "Выход",
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.red),
      ),
    );
  }
}