import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/rides/components/ride_list.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

import 'components/ride_tile.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({Key? key}) : super(key: key);

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        title: "Мои поездки",
        body: Container(
          color: kPrimaryWhite,
          child: Column(
            children: [
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: _tabbar()),
               Expanded(
                 child: TabBarView(
                  controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(child: SingleChildScrollView(
                        child: Column(
                         children: [
                           RideList(title: "Предстоящие поездки"),
                            RideList(title: "Предыдущие поездки", count: 5,),
                         ],
                                           ),
                      )),
                     const Center(
                        child: Text(
                          'Coming soon...',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
               )

            ],
          ),
        ));
  }

  Widget _tabbar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 45,
      decoration: BoxDecoration(
        color: kPrimaryWhite,
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: TabBar(
        onTap: (value) => setState(() {}),
        controller: _tabController,
        splashBorderRadius: BorderRadius.circular(25),
        // give the indicator a decoration (color and border radius)
        indicator: _tabController!.index == 0
            ? const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                color: kPrimaryColor,
              )
            : const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: kPrimaryColor,
              ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const[
          // first tab [you can add an icon using the icon property]
          Tab(
            text: 'Пассажир',
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            text: 'Водитель',
          ),
        ],
      ),
    );
  }
}
