import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationField extends StatelessWidget {
  final TextEditingController startWay;
  final String hintText;
  final String icon;

  const LocationField({Key? key, required this.startWay, required this.hintText, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryWhite
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: 150,
                      child: Text(startWay.text.isNotEmpty ? startWay.text : hintText, 
                            style: TextStyle(color: startWay.text.isNotEmpty ? Colors.black : Colors.grey, fontWeight: FontWeight.w400, fontSize: 16, overflow: TextOverflow.ellipsis)),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(icon, width: 25, height: 25),
                  )
                ],
              )
            );
  }
}
