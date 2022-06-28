import 'package:app_poezdka/src/rides/components/ride_tile.dart';
import 'package:flutter/material.dart';

class RideList extends StatelessWidget {
  final String title;
  final int? count;
  const RideList({Key? key, required this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: count ?? 1,
            itemBuilder: (context, int index) => const RideTile())
      ],
    );
  }
}
