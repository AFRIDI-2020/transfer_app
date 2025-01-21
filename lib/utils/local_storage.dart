import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class LocalStorage {
  static final getStorage = GetStorage('MyPref');

  String get token => getStorage.read('token') ?? '';

  void setToken(String val) => getStorage.write('token', val);

  String get refreshToken => getStorage.read('refreshToken') ?? '';

  void setRefreshToken(String val) => getStorage.write('refreshToken', val);


  void removeSession() {
    getStorage.remove("token");
  }
}