import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashModel {
  //************************get token user
  void getToken() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
//      HomeSplash.tokenUSer = token;
      saveData(token);
    });
  }

  //************************save token user in shared pref
  Future<bool> saveData(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('my token is : $token');
    return await prefs.setString('token', token);
  }
}
