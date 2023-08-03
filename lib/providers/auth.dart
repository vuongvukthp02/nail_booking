import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/models/http_exeption.dart';
import 'package:usastarnail/utils/RFString.dart';
import 'package:usastarnail/utils/RFWidget.dart' as RFWidget;

import '../screens/RFEmailSignInScreen.dart';

class Auth with ChangeNotifier {
  late String _token = '';
  late DateTime _expiryDate = DateTime.now();
  late String _userId = '';

  bool get isAuth {
    return token != '';
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String url, String email, String password) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'username': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      // print(object)
      final responseData = json.decode(response.body);
      if (!responseData['success'])
        throw HttpException(responseData['content']);

      _token = responseData['user']['auth'].toString();
      _userId = responseData['user']['uid'].toString();
      notifyListeners();
    }
    catch (error) {
      throw error;
    }
  }

  Future<void> _authenticateDangKy(BuildContext context,
    String url,
    String hoTen,
    String dienThoai,
    String email,
    String matKhau,
    String nhapLaiMatKhau,
  ) async {
    // try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'username': hoTen,
            'dien_thoai': dienThoai,
            'email': email,
            'password': matKhau,
            'rePassword': nhapLaiMatKhau,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      final responseData = json.decode(response.body);
      print(responseData);

      if (!responseData['success'])
        throw HttpException(responseData['content']);

      // _token = responseData['content']['user']['auth'];
      // _userId = responseData['content']['user']['uid'].toString();

      final snackBar = SnackBar(
        padding: EdgeInsets.all(8),
        backgroundColor:
        getColorFromHex(responseData['success'] ? '#379237' : '#FF4040'),
        content: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(responseData['success']
                    ? Ionicons.checkmark_circle
                    : Ionicons.close_circle,
                  color: Colors.white,),
                3.width,
                Text(responseData['content'], softWrap: true, style: TextStyle(color: Colors.white),),
              ],
              // text: "${responseData['content']}. Login Now?",
              // prefix: Icon(
              //   responseData['success']
              //       ? Ionicons.checkmark_circle
              //       : Ionicons.close_circle,
              //   color: Colors.white,
              // ),
              // textStyle: TextStyle(color: Colors.white)
            ),
            TextButton(
                onPressed: () {
                  responseData['success']
                      ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RFEmailSignInScreen(
                            clear: true,
                          )),
                          (route) => false)
                      : print('ok');
                },
                child: Text('OK')),
          ],
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
    // } catch (error) {
    //   throw error;
    // }
  }

  Future<void> signup( BuildContext context,
    String hoTen,
    String dienThoai,
    String email,
    String matKhau,
    String nhapLaiMatKhau,
  ) async {
    return _authenticateDangKy( context,
      RFBaseSignUp,
      hoTen,
      dienThoai,
      email,
      matKhau,
      nhapLaiMatKhau,
    );
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    const url = RFBaseLogin;
    return _authenticate(url, email, password);
  }

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
        Uri.parse(RFLogout),
        body: json.encode({
          'uid': userId,
          'auth': token,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
    );

    final responseData = json.decode(response.body);

    if(!responseData['success'])
      throw HttpException(responseData['content']);
    else{
      _token = '';
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (context) => RFEmailSignInScreen(
                contentAlert: responseData['content'],
                showDialog: true,
                clear: true,
              )),
              (route) => false);
      print("responseData['content'] ${responseData['content']}");
    }
    notifyListeners();
  }
}
