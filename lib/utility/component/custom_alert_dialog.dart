import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({@required this.onPress});
  Function onPress;

  @override
  Widget build(BuildContext context) {
    return NetworkGiffyDialog(
//            key: keys[1],
      image: Image.asset(
        'images/ali.png',
        fit: BoxFit.cover,
      ),
      entryAnimation: EntryAnimation.TOP_LEFT,
      title: Text(
        'بروز رسانی نرم افزار',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,fontFamily: 'sansBold'),
      ),
      description: Text(
        'لطفا آخرین نسخه نرم افزار گرین کاتالوگ را نصب کنید',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300,fontFamily: 'sans'),

      ),
      buttonOkText: Text(
        'بروز رسانی',
        style: TextStyle(color: Colors.white,fontFamily: 'sans'),
      ),
      buttonCancelText: Text(
        'انصراف',
        style: TextStyle(color: Colors.white,fontFamily: 'sans'),
      ),
      cornerRadius: 10.0,
      onOkButtonPressed: onPress,
    );
  }
}
