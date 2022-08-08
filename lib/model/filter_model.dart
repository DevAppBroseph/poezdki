import 'package:app_poezdka/model/gender_model.dart';

class FilterModel {
  bool isPackageTransfer;
  bool isTwoBackSeat;
  bool isBagadgeTransfer;
  bool isChildSeat;
  bool isConditioner;
  bool isSmoking;
  bool isPetTransfer;
  GenderModel? gender;

  FilterModel(
      {required this.isPackageTransfer,
      required this.isTwoBackSeat,
      required this.isBagadgeTransfer,
      required this.isChildSeat,
      required this.isConditioner,
      required this.isSmoking,
      required this.isPetTransfer,
      required this.gender});

  FilterModel copyWith(
      {bool? isPackageTransfer,
      bool? isTwoBackSeat,
      bool? isBagadgeTransfer,
      bool? isChildSeat,
      bool? isConditioner,
      bool? isSmoking,
      bool? isPetTransfer,
      GenderModel? gender}) {
    return FilterModel(
        isPackageTransfer: isPackageTransfer ?? this.isPackageTransfer,
        isTwoBackSeat: isTwoBackSeat ?? this.isTwoBackSeat,
        isBagadgeTransfer: isBagadgeTransfer ?? this.isBagadgeTransfer,
        isChildSeat: isChildSeat ?? this.isChildSeat,
        isConditioner: isConditioner ?? this.isConditioner,
        isSmoking: isSmoking ?? this.isSmoking,
        isPetTransfer: isPetTransfer ?? this.isPetTransfer,
        gender: gender ?? this.gender);
  }
}
