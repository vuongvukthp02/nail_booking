import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:usastarnail/utils/RFWidget.dart' as RFWidget;

import '../models/http_exeption.dart';
import '../screens/RFEmailSignInScreen.dart';
import '../screens/RFHomeScreen.dart';
import '../utils/RFString.dart';

class proFile with ChangeNotifier {
  int? nid;
  late String authToken;
  late int uid;
  String? name;
  String? mail;
  String? field_ho_ten;
  String? field_ngay_sinh;
  String? field_dien_thoai;
  String? field_dia_chi;
  String? field_da_xac_minh_email;
  String? field_da_xac_minh_sdt;
  String? picture;

  proFile(
      {
      this.nid =0,
      this.authToken ='',
      this.uid = 0,
      this.name,
      this.mail,
      this.field_ho_ten,
      this.field_ngay_sinh,
      this.field_dien_thoai,
      this.field_dia_chi,
      this.field_da_xac_minh_email,
      this.field_da_xac_minh_sdt,
      this.picture
      });

  Future<void> getProfile() async {
    print("RFGetProFile ${RFGetProFile}");
    final response = await http.post(Uri.parse(RFGetProFile),
        body: json.encode({
          "uid": this.uid,
          "auth": this.authToken,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        });
    final responseData = json.decode(response.body);
    if (!responseData['success'])
      throw HttpException(responseData['content']);
    else {
      this.uid = responseData['content']['uid'].toString().toInt();
      this.name= responseData['content']['name'];
      this.mail= responseData['content']['mail'];
      this.field_ho_ten= responseData['content']['field_ho_ten'];
      this.field_dien_thoai= responseData['content']['field_dien_thoai'];
      this.field_ngay_sinh= responseData['content']['field_ngay_sinh'];
      this.picture = responseData['content']['picture'];
      notifyListeners();
    }
  }

  Future<void> save(Map<String, dynamic> profile, BuildContext context) async {
    try {
      final response = await http.put(Uri.parse(RFSaveProfile),
          body: json.encode({
            'uid': this.uid,
            "auth": this.authToken,
            "field_ho_ten": profile['field_ho_ten'],
            "field_ngay_sinh": profile['field_ngay_sinh'],
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });

      final responseData = json.decode(response.body);
      final snackBar = SnackBar(
        padding: EdgeInsets.all(8),
        backgroundColor:
        getColorFromHex(responseData['success'] ? '#379237' : '#FF4040'),
        content: TextIcon(
          text: responseData['content'],
          prefix: Icon(
            responseData['success']
                ? Ionicons.checkmark_circle
                : Ionicons.close_circle,
            color: Colors.white,
          ),
          textStyle: TextStyle(color: Colors.white),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => RFHomeScreen(
                  selectedIndex: 2,
                )),
                (route) => false);
        print("responseData['content'] ${responseData['content']}");
      }
      notifyListeners();
    }on HttpException catch(error) {
      RFWidget.showErrorDialog(error.message, context);
      throw error;
    }
    catch (error) {
      throw error;
    }
  }

  Future<void> suamatkhau(BuildContext context, String? pass_old,
      String? pass_new, String? pass_confirm) async {
    // try {
      print(this.uid);
      print(this.authToken);
      final response = await http.put(Uri.parse(RFEditPass),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'passwordOld': pass_old,
            'passwordNew': pass_new,
            'passwordConfirm': pass_confirm,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      final responseData = json.decode(response.body);
      print("respondata: ${responseData}");
      print(responseData['content']);
      print('response body ${response.body}');

      final snackBar = SnackBar(
        padding: EdgeInsets.all(8),
        backgroundColor:
        getColorFromHex(responseData['success'] ? '#379237' : '#FF4040'),
        content: TextIcon(
          text: responseData['content'],
          prefix: Icon(
            responseData['success']
                ? Ionicons.checkmark_circle
                : Ionicons.close_circle,
            color: Colors.white,
          ),
          textStyle: TextStyle(color: Colors.white),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
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
    // } catch (error) {
    //   throw error;
    // }
  }

  Future<void> forgotpass(BuildContext context, String? username) async {
    try {
      // ncscs
      print(this.uid);
      print(this.authToken);
      final response = await http.post(Uri.parse(RFForgotPassWord),
          body: json.encode({'username': username}),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });

      final responseData = json.decode(response.body);
      if (!responseData['success'])
        throw HttpException(responseData['content']);
      else {
        Navigator.pushAndRemoveUntil( context,
            MaterialPageRoute(
                builder: (context) =>
                    RFEmailSignInScreen(
                      contentAlert: responseData['content'],
                      showDialog: true,
                      clear: true,
                    )),
                (route) => false);
        print("responseData['content'] ${responseData['content']}");
      }
      notifyListeners();
    }on HttpException catch(error) {
      // RFWidget.showErrorDialog(error.message, context);
      throw error;
    }
    catch (error) {
      throw error;
    }
  }
}
