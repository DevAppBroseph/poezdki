import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliderPage extends StatelessWidget {
  final String message;
  final String image;

  const SliderPage(this.message, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height < 800 ? 80 : 200,
            ),
            SvgPicture.asset(
              image,
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.height < 800 ? 200 : 300,
              height: MediaQuery.of(context).size.height < 800 ? 200 : 300,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              message,
              style: style,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
