// ignore_for_file: unused_field

import 'package:app_poezdka/bloc/trips_driver/trips_builder.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_p_builder.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';

import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/trips/components/pick_city.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../model/city_model.dart';
import '../text_field/custom_text_field.dart';

class SearchRides extends StatefulWidget {
  final bool? isAuthorized;
  const SearchRides({Key? key, this.isAuthorized}) : super(key: key);

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides>
    with SingleTickerProviderStateMixin {
  final btmSheet = BottomSheetCallAwait();
  City? from;
  City? to;
  TabController? _tabController;

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();

  final bool _tempIsPackageTransfer = false;
  final bool _tempIsTwoBackSeat = false;
  final bool _tempIsBagadgeTransfer = false;
  final bool _tempIsChildSeat = false;
  final bool _tempIsCondition = false;
  final bool _tempIsSmoking = false;
  final bool _tempIsPetTransfer = false;

  bool _isPackageTransfer = false;
  final bool _isTwoBackSeat = false;
  final bool _isBagadgeTransfer = false;
  final bool _isChildSeat = false;
  final bool _isCondition = false;
  final bool _isSmoking = false;
  final bool _isPetTransfer = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      title: "Поиск поездок",
      actions: [
        IconButton(
            onPressed: () => BottomSheetCall().show(context,
                topRadius: const Radius.circular(50),
                useRootNavigator: true,
                child: bottomSheetFilter()),
            icon: const Icon(MaterialCommunityIcons.filter_outline))
      ],
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kPrimaryWhite,
        child: NestedScrollView(
          headerSliverBuilder: (context, bool inner) {
            return [
              SliverAppBar(
                bottom: _bottomFilter(),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TripsBuilder(),
                  )
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TripsPassengerBuilder(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isAuthorized != null &&
              widget.isAuthorized == false
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FullWidthElevButton(
                title: "Авторизироваться",
                onPressed: () => pushNewScreen(context,
                    withNavBar: false, screen: const SignInScreen()),
              ),
            )
          : null,
    );
  }

  PreferredSize _bottomFilter() {
    return PreferredSize(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
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
                  text: 'Я пассажир',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Я водитель',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  WayPointField(
                      type: WaypointType.start,
                      textField: KFormField(
                        readOnly: true,
                        onTap: () => pickDestinition(
                            context, startWay, from, "Откуда едем?"),
                        hintText: "Откуда",
                        textEditingController: startWay,
                        suffix: startWay.text.isNotEmpty
                            ? IconButton(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 5),
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  setState(() {
                                    from == null;
                                    startWay.clear();
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.clear_circled,
                                  size: 18,
                                  color: kPrimaryDarkGrey,
                                ))
                            : const SizedBox(),
                        suffixIcon: Image.asset('assets/img/gps.png'),
                        onChanged: (value) {
                          setState(() {});
                        },
                      )),
                  const WayPointField(
                      type: WaypointType.empty,
                      textField: SizedBox(
                        height: 10,
                      )),
                  WayPointField(
                      type: WaypointType.end,
                      textField: KFormField(
                        onTap: () =>
                            pickDestinition(context, endWay, to, "Куда едем?"),
                        readOnly: true,
                        hintText: "Куда",
                        textEditingController: endWay,
                        suffix: endWay.text.isNotEmpty
                            ? IconButton(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 5),
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  setState(() {
                                    to == null;
                                    endWay.clear();
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.clear_circled,
                                  size: 18,
                                  color: kPrimaryDarkGrey,
                                ))
                            : const SizedBox(),
                        suffixIcon: Image.asset('assets/img/gps.png'),
                        onChanged: (value) {
                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListTile(
                onTap: () => setState(() {
                  _isPackageTransfer = !_isPackageTransfer;
                }),
                leading: Icon(
                  _isPackageTransfer
                      ? MaterialIcons.radio_button_checked
                      : MaterialIcons.radio_button_unchecked,
                  color: _isPackageTransfer ? kPrimaryColor : null,
                ),
                title: const Text("Передать посылку"),
              ),
            )
          ],
        ),
        preferredSize: const Size(200, 308));
  }

  Widget bottomSheetFilter() {
    return BottomSheetChildren(
      children: [
        const ListTile(
          title: Text(
            "Фильтр поиска",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _switchTile(
            img: 'box.png',
            title: "Перевозка посылок",
            filter: _tempIsPackageTransfer,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: 'sofa.png',
            title: "2 места на заднем сиденье",
            filter: _tempIsTwoBackSeat,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: '3d-cube-scan.png',
            title: "Перевозка багажа",
            filter: _tempIsBagadgeTransfer,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: 'person-standing.png',
            title: "Детское кресло",
            filter: _tempIsChildSeat,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: 'cigarette.png',
            title: "Курение в салоне",
            filter: _tempIsSmoking,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: 'github.png',
            title: "Перевозка животных",
            filter: _tempIsPetTransfer,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        _switchTile(
            img: 'sun.png',
            title: "Кондиционер",
            filter: _tempIsCondition,
            onChanged: (value) {
              setState(() {
                value == !value;
              });
            }),
        ListTile(
          minLeadingWidth: 3,
          leading: Image.asset("$iconPath/man.png"),
          title: const Text("Пол водителя"),
          trailing: const Text("Мужской"),
        ),
        FullWidthElevButton(
          title: "Применить",
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _switchTile(
      {required String img,
      required String title,
      required bool filter,
      Function(bool)? onChanged}) {
    return SwitchListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("$iconPath$img"),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
      value: filter,
      onChanged: (bool value) {
        setState(() {
          _onSwitchChanged(filter, value);
        });
      },
    );
  }

  void _onSwitchChanged(bool fliter, bool value) {
//    setState(() {
    fliter = value;
//    });
  }

  void pickDestinition(context, TextEditingController contoller, City? city,
      String title) async {
    final City? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        city = destinition;
      });
    }
  }
}
