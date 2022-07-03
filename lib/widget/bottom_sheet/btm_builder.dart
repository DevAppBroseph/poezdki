import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetCall {
  void show(BuildContext context,
          {bool? expand,
          bool? dismissible,
          bool? enableDrag,
          bool? useRootNavigator,
          Radius? topRadius,
          required Widget child}) =>
      showCupertinoModalBottomSheet(
          bounce: false,
          enableDrag: enableDrag ?? true,
          isDismissible: dismissible ?? true,
          useRootNavigator: useRootNavigator ?? false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expand: expand ?? false,
          topRadius: topRadius ?? const Radius.circular(15),
          context: context,
          builder: (context) => child);
}

class BottomSheetChildren extends StatelessWidget {
  final String? headerTitle;
  final List<Widget> children;
  final List<Widget>? buttons;

  const BottomSheetChildren(
      {Key? key, required this.children, this.headerTitle, this.buttons})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(40),
      child: SafeArea(
        bottom: false,
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey),
                    ),
                    
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [...children],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
