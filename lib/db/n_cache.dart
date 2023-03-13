import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class NCache {
  SharedPreferences? prefs;

  NCache._() {
    init();
  }

  static NCache? _instance;

  NCache._pre(SharedPreferences this.prefs);

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<NCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = NCache._pre(prefs);
    }
    return _instance!;
  }

  static NCache getInstance() {
    _instance ??= NCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  void set<T>(String key, T value) {
    if (value is String) {
      setString(key, value);
    } else if (value is double) {
      setDouble(key, value);
    } else if (value is int) {
      setInt(key, value);
    } else if (value is bool) {
      setBool(key, value);
    } else if (value is List<String>) {
      setStringList(key, value);
    }
  }
}
