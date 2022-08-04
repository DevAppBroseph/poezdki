part of 'my_rides_bloc.dart';

class MyRidesEvent {}

class InitMyRides extends MyRidesEvent {}

class LoadMyRides extends MyRidesEvent {}


class AddMyRide extends MyRidesEvent {
  final String startWay;
  final String endWay;
  final bool? childSeat;

  AddMyRide({required this.startWay,required this.endWay, this.childSeat});


}

class CancelMyRide extends MyRidesEvent {}
