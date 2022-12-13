import 'dart:convert';
import 'dart:io';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_builder.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_p_builder.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_passenger_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/filter_model.dart';
import 'package:app_poezdka/model/model_search.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/local/shared_preferences.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/trips/components/pick_city.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/src/trips/components/search_trip_filter.dart';
import 'package:app_poezdka/src/trips/notification_page.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/widget/text_field/form_location_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SearchRides extends StatefulWidget {
  final bool? isAuthorized;
  const SearchRides({Key? key, this.isAuthorized}) : super(key: key);

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides>
    with SingleTickerProviderStateMixin {
  final btmSheet = BottomSheetCallAwait();
  int searchPageIndex = 1;
  Departure? from;
  Departure? to;
  TabController? _tabController;

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  DateTime? timeMilisecondStart;
  DateTime? timeMilisecondEnd;

  FilterModel filter = FilterModel(
    isPackageTransfer: false,
    isTwoBackSeat: false,
    isBagadgeTransfer: false,
    isChildSeat: false,
    isConditioner: false,
    isSmoking: false,
    isPetTransfer: false,
    gender: null,
    start: null,
    end: null,
  );

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
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage())),
              icon: const Icon(MaterialCommunityIcons.notification_clear_all)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () => applyFilters(),
              icon: const Icon(MaterialCommunityIcons.filter_outline)),
        ),
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
            children: [
              RefreshIndicator(
                displacement: 0,
                onRefresh: () => fetchTrips(context, page: searchPageIndex),
                child: const CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverToBoxAdapter(
                      child: TripsBuilder(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 40),
                    )
                  ],
                ),
              ),
              RefreshIndicator(
                displacement: 0,
                onRefresh: () => fetchTrips(context, page: searchPageIndex),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverToBoxAdapter(
                      child: RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        onRefresh: () =>
                            fetchTrips(context, page: searchPageIndex),
                        child: const TripsPassengerBuilder(),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 40),
                    )
                  ],
                ),
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
      preferredSize: const Size(200, 420),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onTap: (value) => setState(() {
              fetchTrips(context, page: value);
            }),
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
              Tab(text: 'Я пассажир'),
              Tab(text: 'Я водитель'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                WayPointField(
                  type: WaypointType.start,
                  textField: GestureDetector(
                      onTap: () => pickDestinition(
                            context,
                            startWay,
                            from,
                            "Откуда едем?",
                            (destination) {
                              setState(() {
                                from = destination;
                              });
                            },
                          ),
                      child: LocationField(
                          startWay: startWay,
                          hintText: 'Откуда',
                          icon: 'assets/img/gps.svg',
                          iconClear: startWay.text.isNotEmpty
                              ? IconButton(
                                  padding:
                                      const EdgeInsets.only(right: 0, top: 5),
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    setState(() {
                                      from = null;
                                      startWay.clear();
                                    });
                                    fetchTrips(context, page: searchPageIndex);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.clear_circled,
                                    size: 18,
                                    color: kPrimaryDarkGrey,
                                  ),
                                )
                              : const SizedBox())),
                ),
                WayPointField(
                  type: WaypointType.empty,
                  textField: SizedBox(
                    // height: 10,
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () {
                              final temp = from;
                              from = to;
                              to = temp;

                              startWay.text = from != null ? from!.name! : '';
                              endWay.text = to != null ? to!.name! : '';

                              setState(() {});
                              fetchTrips(context);
                            },
                            child: const Icon(
                              Icons.swap_vert_rounded,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                WayPointField(
                  type: WaypointType.start,
                  textField: GestureDetector(
                      onTap: () => pickDestinition(
                              context, endWay, to, "Куда едем?", (destination) {
                            setState(() {
                              to = destination;
                            });
                          }),
                      child: LocationField(
                          startWay: endWay,
                          hintText: 'Куда',
                          icon: 'assets/img/gps.svg',
                          iconClear: endWay.text.isNotEmpty
                              ? IconButton(
                                  padding:
                                      const EdgeInsets.only(right: 0, top: 5),
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    setState(() {
                                      to = null;
                                      endWay.clear();
                                    });
                                    fetchTrips(context, page: searchPageIndex);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.clear_circled,
                                    size: 18,
                                    color: kPrimaryDarkGrey,
                                  ),
                                )
                              : const SizedBox())),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Icon(
                      Icons.calendar_month,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kPrimaryWhite),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => funcDate(TypeDate.start),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            hintText: 'Сегодня',
                                          ),
                                          enabled: false,
                                          controller: startDate,
                                        ),
                                      ),
                                    ),
                                    if (startDate.text.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              startDate.text = '';
                                              timeMilisecondStart = null;
                                              timeMilisecondEnd = null;
                                              setState(() {});
                                              fetchTrips(context,
                                                  page: searchPageIndex);
                                            },
                                            child: const Icon(Icons.close)),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: ListTile(
              onTap: () => setState(() {
                filter.isPackageTransfer = !filter.isPackageTransfer;
                fetchTrips(context, page: searchPageIndex);
              }),
              leading: Icon(
                filter.isPackageTransfer
                    ? MaterialIcons.radio_button_checked
                    : MaterialIcons.radio_button_unchecked,
                color: filter.isPackageTransfer ? kPrimaryColor : null,
              ),
              title: const Text("Передать посылку"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: GestureDetector(
              onTap: () async {
                final settings = await LocalStorageService.getInstance();
                String? allSearch = settings.getSearch();

                List<String>? history = allSearch?.split('#');
                List<ModelSearch> searchHistory = [];

                if (history != null) {
                  for (var element in history) {
                    final res = jsonDecode(element);
                    searchHistory.add(ModelSearch.fromJson(res));
                  }
                }

                SmartDialog.show(
                  maskColor: const Color.fromRGBO(6, 22, 46, 0.67),
                  builder: (context) {
                    return Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minHeight: 351, maxHeight: 700),
                              // height: height ?? 351,
                              width: 600,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      color: Color.fromRGBO(26, 42, 97, 0.06),
                                    ),
                                  ]),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'История поиска',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),
                                    searchHistory.isEmpty
                                        ? const Text('Пусто')
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            child: _listView(searchHistory),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                  alignment: Alignment.center,
                );
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'История поиска',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView _listView(List<ModelSearch> searchHistory) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchHistory.length,
      // physics: BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  final tripsBloc = BlocProvider.of<TripsBloc>(context);
                  tripsBloc.add(
                    LoadAllTripsList(
                      page: 0,
                      departure: searchHistory[index].departure,
                      destination: searchHistory[index].destination,
                      animals: searchHistory[index].animals,
                      package: searchHistory[index].package,
                      baggage: searchHistory[index].baggage,
                      babyChair: searchHistory[index].babyChair,
                      smoke: searchHistory[index].smoke,
                      twoPlacesInBehind: searchHistory[index].twoPlacesInBehind,
                      conditioner: searchHistory[index].conditioner,
                      gender: searchHistory[index].gender,
                      start: searchHistory[index].start,
                      end: searchHistory[index].end,
                    ),
                  );

                  Map<String, dynamic> tripOne = {
                    "page": 1,
                    "departure": {
                      "coords": {
                        "lat": searchHistory[index].departure!.coords!.lat,
                        "lon": searchHistory[index].departure!.coords!.lon
                      },
                      "district": searchHistory[index].departure!.district,
                      "name": searchHistory[index].departure!.name,
                      "population": searchHistory[index].departure!.population
                    },
                    "destination": {
                      "coords": {
                        "lat": searchHistory[index].destination!.coords!.lat,
                        "lon": searchHistory[index].destination!.coords!.lon
                      },
                      "district": searchHistory[index].destination!.district,
                      "name": searchHistory[index].destination!.name,
                      "population": searchHistory[index].destination!.population
                    },
                    "animals": searchHistory[index].animals,
                    "package": searchHistory[index].package,
                    "baggage": searchHistory[index].baggage,
                    "babyChair": searchHistory[index].babyChair,
                    "smoke": searchHistory[index].smoke,
                    "twoPlacesInBehind": searchHistory[index].twoPlacesInBehind,
                    "conditioner": searchHistory[index].conditioner,
                    "gender": searchHistory[index].gender,
                    "start": searchHistory[index].start,
                    "end": searchHistory[index].end
                  };

                  print('objecthjh $tripOne');

                  final tripsBlocSecond =
                      BlocProvider.of<TripsPassengerBloc>(context);
                  tripsBlocSecond.add(
                    LoadPassengerTripsList(
                      // page: page,
                      departure: searchHistory[index].departure,
                      destination: searchHistory[index].destination,
                      animals: searchHistory[index].animals,
                      package: searchHistory[index].package,
                      baggage: searchHistory[index].baggage,
                      babyChair: searchHistory[index].babyChair,
                      smoke: searchHistory[index].smoke,
                      twoPlacesInBehind: searchHistory[index].twoPlacesInBehind,
                      conditioner: searchHistory[index].conditioner,
                      // gender: filter.gender?.apiTitle,
                    ),
                  );

                  startWay.text = searchHistory[index].departure!.name!;
                  endWay.text = searchHistory[index].destination!.name!;
                  from = searchHistory[index].departure;
                  to = searchHistory[index].destination;

                  // if (from != null &&
                  //     to != null) {
                  String jsonStr = jsonEncode(tripOne);
                  final settings = await LocalStorageService.getInstance();
                  String? allSearch = settings.getSearch();
                  settings.setSearch(
                      allSearch == null ? '$jsonStr' : '$jsonStr#$allSearch');
                  setState(() {});
                  SmartDialog.dismiss();
                  // }
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        searchHistory[index].departure!.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const Expanded(
                      child: Icon(
                        Icons.arrow_right_alt_sharp,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        searchHistory[index].destination!.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Expanded(
                      child: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider()
          ],
        );
      },
    );
  }

  void funcDate(TypeDate typeDate) async {
    if (Platform.isAndroid) {
      final value = await showDialog(
        context: context,
        builder: ((context) {
          return DatePickerDialog(
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 5),
          );
        }),
      );

      timeMilisecondStart = value;
      startDate.text = DateFormat('dd.MM.yyyy').format(value);
    } else {
      await showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.grey[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Stack(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                timeMilisecondStart = timeMilisecondStart ??
                                    DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                startDate.text = DateFormat('dd.MM.yyyy')
                                    .format(timeMilisecondStart!);
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[100],
                                  )),
                              child: const Text('Готово'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      onDateTimeChanged: (value) {
                        if (typeDate == TypeDate.start) {
                          timeMilisecondStart = value;
                          startDate.text =
                              DateFormat('dd.MM.yyyy').format(value);
                        } else {
                          timeMilisecondEnd = value;
                          endDate.text = DateFormat('dd.MM.yyyy').format(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
    timeMilisecondEnd = DateTime.fromMillisecondsSinceEpoch(
        timeMilisecondStart!.millisecondsSinceEpoch + 86400000);
    fetchTrips(context, page: searchPageIndex);
    setState(() {});
  }

  void pickDestinition(
      context,
      TextEditingController contoller,
      Departure? city,
      String title,
      Function(Departure? destination) onChanged) async {
    final Departure? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        city = destinition;
        onChanged(destinition);
      });

      fetchTrips(context, page: searchPageIndex);
    }
  }

  Future<void> fetchTrips(
    context, {
    int? page,
  }) async {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    tripsBloc.add(
      LoadAllTripsList(
        page: page,
        departure: from,
        destination: to,
        animals: filter.isPetTransfer,
        package: filter.isPackageTransfer,
        baggage: filter.isBagadgeTransfer,
        babyChair: filter.isChildSeat,
        smoke: filter.isSmoking,
        twoPlacesInBehind: filter.isTwoBackSeat,
        conditioner: filter.isConditioner,
        gender: filter.gender?.apiTitle,
        start: timeMilisecondStart == null
            ? null
            : (timeMilisecondStart!.microsecondsSinceEpoch),
        end: timeMilisecondEnd == null
            ? null
            : (timeMilisecondEnd!.microsecondsSinceEpoch),
      ),
    );

    Map<String, dynamic> tripOne = {
      "page": page,
      "departure": {
        "coords": {
          "lat": from?.coords!.lat,
          "lon": from?.coords!.lon,
        },
        "district": from?.district,
        "name": from?.name,
        "population": from?.population,
        "subject": from?.subject
      },
      "destination": {
        "coords": {
          "lat": to?.coords!.lat,
          "lon": to?.coords!.lon,
        },
        "district": to?.district,
        "name": to?.name,
        "population": to?.population,
        "subject": to?.subject
      },
      "animals": filter.isPetTransfer,
      "package": filter.isPackageTransfer,
      "baggage": filter.isBagadgeTransfer,
      "babyChair": filter.isChildSeat,
      "smoke": filter.isSmoking,
      "twoPlacesInBehind": filter.isTwoBackSeat,
      "conditioner": filter.isConditioner,
      "gender": filter.gender?.apiTitle,
      "start": timeMilisecondStart == null
          ? null
          : (timeMilisecondStart!.microsecondsSinceEpoch),
      "end": timeMilisecondEnd == null
          ? null
          : (timeMilisecondEnd!.microsecondsSinceEpoch),
    };

    final tripsBlocSecond = BlocProvider.of<TripsPassengerBloc>(context);
    tripsBlocSecond.add(
      LoadPassengerTripsList(
        // page: page,
        departure: from,
        destination: to,
        animals: filter.isPetTransfer,
        package: filter.isPackageTransfer,
        baggage: filter.isBagadgeTransfer,
        babyChair: filter.isChildSeat,
        smoke: filter.isSmoking,
        twoPlacesInBehind: filter.isTwoBackSeat,
        conditioner: filter.isConditioner,
        // gender: filter.gender?.apiTitle,
      ),
    );

    if (from != null && to != null) {
      String jsonStr = jsonEncode(tripOne);
      final settings = await LocalStorageService.getInstance();
      String? allSearch = settings.getSearch();
      settings
          .setSearch(allSearch == null ? '$jsonStr' : '$jsonStr#$allSearch');
    }
  }

  void applyFilters() async {
    final FilterModel? newFilter = await btmSheet.wait(context,
        child: SearchTripBottomSheet(
          initFilter: filter,
          timeMilisecondStart: timeMilisecondStart,
          timeMilisecondEnd: timeMilisecondEnd,
        ));
    if (newFilter != null) {
      setState(() {
        filter = newFilter;
        searchPageIndex = 1;
        fetchTrips(context, page: searchPageIndex);
      });
    }
  }
}
