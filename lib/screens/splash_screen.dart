import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:repaircar/utility/component/custom_alert_dialog.dart';
import 'package:repaircar/utility/consts.dart';
import 'package:repaircar/utility/network/networks.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeSplash extends StatefulWidget {
  static String id = 'splash_screen';
  static String tokenUSer;

  @override
  _HomeSplashState createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  String _projectVersion = '';
  String token;
  List<String> versionServer = [];
  List<String> versionApp = [];

  @override
  initState() {
    super.initState();
    getToken();
    getVersionApp();
    getVersionServer();
  }

  getToken() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      HomeSplash.tokenUSer = token;
      saveData(token);
    });
  }

  Future<bool> saveData(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('my token is : $token');
    return await prefs.setString('token', token);
  }

  //********get version from Server
  getVersionServer() async {
    Networks networks = Networks(url: kBaseUrl + 'version');
    var versions = await networks.getVersion();
    versionServer = (versions['Data'][0]['Number']).split('.');
    checkUpdate();
  }

//********get version from App
  void getVersionApp() async {
    String projectVersion;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print('1 : $appName');
    print('2 : $packageName');
    print('3 : $version');
    print('4 : $buildNumber');

    projectVersion = '1.0.0';
    setState(() {
      _projectVersion = 'VER ' + projectVersion;
    });
//    print('version app is : $projectVersion');
    versionApp = projectVersion.split('.');
    print('first number app' + versionApp[0]);

//      Navigator.pushNamed(context, OtpOne.id);
  }

  void checkUpdate() {
    print('salam' + versionApp[0]);
    print('salam' + versionServer[0]);

    if (int.parse(versionServer[0]) > int.parse(versionApp[0])) {
      print('number app' + versionApp[0] + versionServer[0]);
      showDialog(
          context: context,
          builder: (_) => CustomDialog(
                onPress: () {},
              ));
    } else {
      if (int.parse(versionServer[1]) > int.parse(versionApp[1])) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  onPress: () {},
                ));
      } else {
        if (int.parse(versionServer[2]) > int.parse(versionApp[2])) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog(
                    onPress: () {},
                  ));
        } else {
          Future.delayed(const Duration(milliseconds: 200), () {
//            Navigator.pushNamed(context, OtpOne.id);
//            Navigator.of(context).push(SlideRightRoute(page: OtpOne()));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Text(
                kAppName,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'walt',
                    fontSize: 30.0,
                    color: kColorPrimary),
              ),
            ),
            Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                child: Image.asset('images/logo_green.png'),
              ),
            ),
            Text(
              'آنلاین ببین و دیده شو',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'sans',
                  fontSize: 15.0,
                  color: kColorPrimary),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                _projectVersion,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: 'mons',
                    fontSize: 15.0,
                    color: kColorPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
