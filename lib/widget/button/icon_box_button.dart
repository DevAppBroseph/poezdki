import 'dart:io';
import 'dart:typed_data';
import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class IconBoxButton extends StatelessWidget {
  final String referalStr;
  final Widget child;
  const IconBoxButton({
    Key? key,
    required this.child,
    required this.referalStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: send,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kPrimaryWhite),
        height: 55,
        width: 55,
        child: child,
      ),
    );
  }
}

void send() async {
  ByteData bytes = await rootBundle.load('assets/img/label.png');
  Uint8List image =
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytesSync(image);

  String linkApp = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.broseph.poezdka'
      : 'https://apps.apple.com/by/app/%D0%BF%D0%BE%D0%B5%D0%B7%D0%B4%D0%BA%D0%B0-%D0%B1%D1%80%D0%BE%D0%BD%D0%B8%D1%80%D1%83%D0%B9-%D0%BF%D0%BE%D0%B5%D0%B7%D0%B4%D0%BA%D1%83/id1640484502';
  Share.shareFiles([path], text: 'Моя реферальная ссылка: \n$linkApp');
}
