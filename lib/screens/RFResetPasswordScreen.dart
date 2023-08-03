import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/screens/RFEmailSignInScreen.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:usastarnail/utils/RFWidget.dart';

import '../providers/profile.dart';
import 'RFTrialHomeScreen.dart';

class RFResetPasswordScreen extends StatefulWidget {
  @override
  _RFResetPasswordScreenState createState() => _RFResetPasswordScreenState();
}

class _RFResetPasswordScreenState extends State<RFResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<proFile>( context, listen: false)
          .forgotpass(context, emailController.text).then((value) {
        setState(() {
          _isLoading = false;
        });
      });

    } on HttpException catch (error) {
      showErrorDialog(error.message, context);
    } catch (error) {
      print(error);
      showErrorDialog(error.toString(), context);
      print(error.toString());
    setState(() {
      _isLoading = false;
    });
    }
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
                  height: MediaQuery.of(context).size.height-150,
                  margin: EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15),)
                  ),
                  child: Column(
                    children: [
                      Text('FORGOT PASSWORD', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),),
                      25.height,
                      AppTextField(
                        controller: emailController,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: rfInputDecoration(
                          lableText: "Email Address",
                          showLableText: true,
                          // suffixIcon: Container(
                          //   padding: EdgeInsets.all(2),
                          //   decoration: boxDecorationWithRoundedCorners(
                          //       boxShape: BoxShape.circle, backgroundColor: redColor),
                          //   child: Icon(Icons.done, color: Colors.white, size: 14),
                          // ),
                        ),
                      ),
                      16.height,
                      AppButton(
                        color: rf_primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Text('Continue', style: boldTextStyle(color: white), textAlign: TextAlign.center,)),
                            Icon(Icons.arrow_forward, color: Colors.white,)
                          ],
                        ),
                        width: context.width(),
                        elevation: 0,
                        onTap: () {
                          _submit();
                        },
                      ),
                      10.height,
                      Text('or', style: TextStyle(color: Color(0xff848A94), fontSize: 16),),
                      16.height,
                      AppButton(
                        color: rf_primaryColor,
                        child: Text('Sign Up', style: boldTextStyle(color: white, size: 16)),
                        width: context.width(),
                        elevation: 0,
                        onTap: () {
                          // _submit();
                          RFEmailSignInScreen().launch(context);
                        },
                      ),
                      15.height,
                      AppButton(
                        color: Colors.white,
                        child: Text('Already have account', style: TextStyle(color: rf_primaryColor, fontWeight: FontWeight.w600, fontSize: 14)),
                        width: context.width(),
                        shapeBorder: Border.all(color: rf_primaryColor),
                        elevation: 0,
                        onTap: () {
                          // _submit();
                          RFEmailSignInScreen().launch(context);
                        },
                      ),
                      15.height,
                      AppButton(
                        color: rf_primaryColor,
                        child: Text('Booking Without Account', style: boldTextStyle(color: white, size: 14)),
                        width: context.width(),
                        elevation: 0,
                        onTap: () {
                          // _submit();
                          RFTrialHomeScreen().launch(context);
                        },
                      ),
                    ],
                  ).paddingOnly(left: 20, right: 20, bottom: 30, top: 30),
                ).paddingOnly(top: 20),
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(top: 40),
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
