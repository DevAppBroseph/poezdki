
import 'package:flutter/material.dart';

class RideList extends StatelessWidget {
  final String title;
  final int? count;
  final bool? isPast;
  const RideList({Key? key, required this.title, this.count, this.isPast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        // ListView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     itemCount: count ?? 1,
        //     itemBuilder: (context, int index) =>  RideTile( rideData: RideData(),
        //           isPast: isPast ?? true,
        //         ))
      ],
    );
  }
}
