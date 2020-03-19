import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Networks {
  Networks({@required this.url});

  final String url;

  Future<Map> getVersion() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
            Map<String, dynamic> data = response.data;
            return data;
          } else {
            print(response.statusCode);
          }
    } catch (e) {
      print(e);
    }
  }
}
