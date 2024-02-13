import 'package:shared_preferences/shared_preferences.dart';

import 'LogHelper.dart';

class MyPreferenceManager {
  static MyPreferenceManager _myPreferenceManager;
  static SharedPreferences _preferences;

  static final _TAG = "MyPreferenceManager";

  static const String EMAIL = 'email';

  static Future<MyPreferenceManager> getInstance() async {
    if (_myPreferenceManager == null) {
      LogHelper.printLog(_TAG, "initialized Preference Manager");
      _myPreferenceManager = MyPreferenceManager();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _myPreferenceManager;
  }

  /*
  //We are not using generic methods to save data for better understanding of developer that which kind of data he or she is going to save.

  void saveData<T>(String key, T content) {
    LogHelper.printLog(TAG, '_saveData. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    } else {
      throw Exception('Invalid type tried to save in preference.');
    }
  }

  dynamic getData(String key) {
    var value = _preferences.get(key);
    return value;
  }*/

  //Setter methods
  void setString(String key, String value) {
    _preferences.setString(key, value);
  }

  void setBool(String key, bool value) {
    LogHelper.printLog("Prefrence...........", value.toString() + key);
    _preferences.setBool(key, value);
  }

  void setDouble(String key, double value) {
    _preferences.setDouble(key, value);
  }

  void setInt(String key, int value) {
    _preferences.setInt(key, value);
  }

  void setStringList(String key, List<String> value) {
    _preferences.setStringList(key, value);
  }

  //Getter methods
  String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }

  double getDouble(String key) {
    return _preferences.getDouble(key) ?? 0;
  }

  int getInt(String key) {
    return _preferences.getInt(key) ?? 0;
  }

  List<String> getStringList(String key) {
    return _preferences.getStringList(key) ?? [];
  }

  void removeKey(String key) {
    _preferences.remove(key);
  }

  void clearData() {

    String emailValue = _preferences.getString(MyPreferenceManager.REMEMBERME_ID);
    String pswdValue = _preferences.getString(MyPreferenceManager.REMEMBERME_PASWD);

    _preferences.clear();

    _preferences.setString(MyPreferenceManager.REMEMBERME_ID, emailValue);
    _preferences.setString(MyPreferenceManager.REMEMBERME_PASWD, pswdValue);
  }

  static const String IS_USER_LOGIN = 'is_user_login';
  static const String DEVICE_TOKEN = 'device_token';
  static const String REMEMBERME_ID = 'rememberme_id';
  static const String REMEMBERME_PASWD = 'rememberme_paswd';

  static const String LOGIN_USER_NAME = 'login_user_namme';
  static const String LOGIN_USER_EMAIL = 'email';
  static const String LOGIN_USER_TOKEN = 'login_user_token';
  static const String LOGIN_USER_PHONE_NUBER = 'login_user_phone';
  static const String LOGIN_USER_ID = 'login_user_id';
  static const String DEVICE_RENDOM_NUMBER = 'device_rendom_generatednumber';

  static const String CART_COUNT = 'cart_count';

}
