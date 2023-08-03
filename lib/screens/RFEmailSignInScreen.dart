import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/components/RFCommonAppComponent.dart';
import 'package:usastarnail/components/RFConformationDialog.dart';
import 'package:usastarnail/providers/auth.dart';
import 'package:usastarnail/screens/RFResetPasswordScreen.dart';
import 'package:usastarnail/screens/RFSignUpScreen.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:usastarnail/utils/RFString.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:usastarnail/utils/RFWidget.dart' as RFWidget;

import '../components/RFCongratulatedDialog.dart';
import '../models/http_exeption.dart';
import '../utils/RFWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'RFResetPasswordScreen.dart';
import 'RFTrialHomeScreen.dart';

enum AuthMode { Signup, Login }

// ignore: must_be_immutable
class RFEmailSignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  bool showDialog;
  String contentAlert;
  bool clear = false;

  RFEmailSignInScreen({this.showDialog = false, this.clear = false, this.contentAlert = ''});

  @override
  _RFEmailSignInScreenState createState() => _RFEmailSignInScreenState();
}

@HiveType(typeId: 1)
class Person {
  Person({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return '$username: $username';
  }
}

class _RFEmailSignInScreenState extends State<RFEmailSignInScreen> {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {'email': '', 'password': ''};
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  Timer? timer;
  late Box box1;

  @override
  void initState() {
    super.initState();
    // final Directory appDocDir = await getApplicationDocumentsDirectory();
    // Hive.init(appDocDir.path);
    initHive();
    init();
  }

  void clear() async {
    setState(() {
      box1.clear();
    });
  }

  void initHive() async {
    await Hive.initFlutter();
    box1 = await Hive.openBox('thongTinDangNhap2');
    getData();
  }


  void getData() async {
    setState(() {
      if (box1.get('emailController') != null) {
        emailController.text = box1.get('emailController');
        isChecked == false;
      };
      if (box1.get('passwordController') != null) {
        passwordController.text = box1.get('passwordController');
        isChecked == false;
      }
      ;
      if (widget.clear == true) {
        passwordController.text = '';
        emailController.text = '';
      }
      if (passwordController.text != '' && emailController.text != '') {
        _submit();
      }
    });
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);

    widget.showDialog
        ? Timer.run(() {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                Future.delayed(Duration(seconds: 5), () {
                  Navigator.of(context).pop(true);
                });
                return Material(
                    type: MaterialType.transparency,
                    child: RFConformationDialog(widget.contentAlert));
              },
            );
          })
        : SizedBox();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async {
    if (isChecked) {
      box1.put('emailController', emailController.text);
      box1.put('passwordController', passwordController.text);
      box1.put('isChecked', true);
    }
    setState(() {
      _isLoading = true;
    });

    try {
      // await Provider.of<Auth>(context, listen: false)
      //     .login(emailController.text, passwordController.text, context);
      // Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog('Thông báo', 'Đăng nhập thành công');
      // });
    } on HttpException catch (error) {
      RFWidget.showErrorDialog(error.message, context);
    } catch (error) {
      print(error);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog();
      // });
      RFWidget.showErrorDialog(error.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: rf_primaryColor,),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Text('BOOKING USASTARNAILS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: rf_primaryColor),softWrap: true),
                      Text('LOGIN', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      20.height,
                      Row(
                        children: [
                          Text('Give your Email or Phone number to login', softWrap: true, style: TextStyle(color: Color(0xff848A94), fontSize: 12),),
                        ],
                      ),
                      10.height,
                      AppTextField(
                        controller: emailController,
                        focus: emailFocusNode,
                        nextFocus: passWordFocusNode,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: rfInputDecoration(
                          lableText: "Your Email or Phone number",
                          showLableText: true,
                          prefixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.mail, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      10.height,
                      AppTextField(
                        controller: passwordController,
                        focus: passWordFocusNode,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: rfInputDecoration(
                          lableText: "Password",
                          showLableText: true,
                          prefixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.lock, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:
                        GestureDetector(
                            child: Text("Fotgot Password?", style: primaryTextStyle(color: rf_primaryColor, weight: FontWeight.w600, size: 14)),
                            onTap: () {
                              RFResetPasswordScreen().launch(context);
                            }),
                      ).paddingOnly(top: 5),
                      15.height,
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        AppButton(
                          color: rf_primaryColor,
                          child: Text('Login', style: boldTextStyle(color: white)),
                          width: context.width(),
                          elevation: 0,
                          onTap: () {
                            _submit();
                          },
                        ),
                      5.height,
                      TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RFSignUpScreen()));
                          },
                          child: Text("Don't have account ? \n or", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff848A94)),)
                      ),
                      5.height,
                      AppButton(
                        color: rf_primaryColor,
                        child: Text('Booking Without Account', style: boldTextStyle(color: white, size: 14)),
                        width: context.width(),
                        elevation: 0,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RFTrialHomeScreen()));
                        },
                      ),
                    ],
                  ).paddingOnly(left: 20, right: 20, bottom: 30, top: 75),
                ).paddingOnly(left: 20, right: 20),
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 12,
                          offset: const Offset(
                              0, 16), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "images/roomFinding/logotron.png",
                      width: 110,
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
