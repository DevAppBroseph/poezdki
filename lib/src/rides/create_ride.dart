import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/rides/create_ride_passenger_1.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'create_ride_driver_1.dart';

class CreateRide extends StatefulWidget {
  const CreateRide({Key? key}) : super(key: key);

  @override
  State<CreateRide> createState() => _CreateRideState();
}

class _CreateRideState extends State<CreateRide>
    with SingleTickerProviderStateMixin {
  // final GlobalKey<FormState> _mainInfo = GlobalKey<FormState>();
  final GlobalKey<FormState> additionalInfo = GlobalKey<FormState>();
  final PageController controller = PageController();

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru', null);
    return KScaffoldScreen(
      resizeToAvoidBottomInset: false,
      title: "Создание поездки",
      bottom: _tabbar(),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          // first tab bar view widget

          CreateRidePassenger(),
          // second tab bar view widget
          CreateRideDriver(),
        ],
      ),
    );
  }

  PreferredSizeWidget _tabbar() {
    return PreferredSize(
      preferredSize: const Size(100, 80),
      child: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
        tabs: const [
          // first tab [you can add an icon using the icon property]
          Tab(
            text: 'Я Пассажир',
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            text: 'Я Водитель',
          ),
        ],
      ),
    );
  }
}
