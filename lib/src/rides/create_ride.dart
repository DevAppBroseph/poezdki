import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

import 'create_ride_driver.dart';

class CreateRide extends StatefulWidget {
  const CreateRide({Key? key}) : super(key: key);

  @override
  State<CreateRide> createState() => _CreateRideState();
}

class _CreateRideState extends State<CreateRide>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _mainInfo = GlobalKey<FormState>();
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
    return KScaffoldScreen(
        title: "Создание поездки",
        body: Stack(
          children: [
            Container(
               padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _tabbar(),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        // first tab bar view widget
                        Expanded(child: CreateRideDriver()),
                  
                        // second tab bar view widget
                        Center(
                          child: Text(
                            'Coming soon...',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FullWidthElevButton(
                    title: "Далее",
                    onPressed: () {},
                  )),
            )
          ],
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
