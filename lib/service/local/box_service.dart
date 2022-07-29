import 'package:hive/hive.dart';

enum HiveBox {
  appBox("appBox"),
  userBox("userBox"),
  reservedBox("ReservedBox");

  final String box;
  const HiveBox(this.box);
}

class HiveBoxService {
  final String boxName;
  HiveBoxService._(this.boxName);
  static final instance = HiveBoxService._(HiveBox.appBox.box);
  

  static const _isFirstLaunch = 'isFirstLaunch';



  bool? firstLaunch() {
    var box = Hive.box(instance.boxName);
    bool? firstLaunch = box.get(_isFirstLaunch);
    return firstLaunch;
  }

  void setFirstLaunch(bool set) {
    var box = Hive.box(instance.boxName);
    box.put(_isFirstLaunch, set);
  }

}
