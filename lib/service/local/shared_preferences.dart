import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();

    _instance!._preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  static const String _searchList = 'SEARCH_LIST';

  String? getSearch() => _preferences!.getString(_searchList);

  void setSearch(String value) => _preferences!.setString(_searchList, value);
}
