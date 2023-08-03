import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/common/constants.dart';
import 'package:usastarnail/components/RFCommonAppComponent.dart';
import 'package:usastarnail/components/RFCongratulatedDialog.dart';
import 'package:usastarnail/main.dart';
import 'package:usastarnail/models/http_exeption.dart';
import 'package:usastarnail/providers/auth.dart';
import 'package:usastarnail/screens/RFEmailSignInScreen.dart';
import 'package:usastarnail/screens/RFTrialHomeScreen.dart';
import 'package:usastarnail/utils/AppTheme.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:usastarnail/utils/RFWidget.dart';
import 'package:usastarnail/utils/RFWidget.dart' as RFWidget;
import 'package:intl/intl.dart';

// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RFSignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  _RFSignUpScreenState createState() => _RFSignUpScreenState();
}

class _RFSignUpScreenState extends State<RFSignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();


  FocusNode fullNameFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode f4 = FocusNode();

  var _isLoading = false;

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

  String formatDate(String? dateTime,
      {String format = DATE_FORMAT_2,
      bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(
          dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try
        {
      await Provider.of<Auth>(context, listen: false).signup( context,
          fullNameController.text,
          dienThoaiController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text);
      setState(() {
        _isLoading = false;
      });
      // RFEmailSignInScreen rfEmailSignInScreen = new RFEmailSignInScreen();
      // rfEmailSignInScreen.contentAlert = 'Đăng ký tài khoản thành công';
      // rfEmailSignInScreen.showDialog = true;

      // rfEmailSignInScreen.launch(context,);

      // Navigator.pushAndRemoveUntil(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) =>
      //                         RFEmailSignInScreen(clear: true,)),
      //                     (route) => false);
      //
    }on HttpException catch (error) {
      showErrorDialog(error.message, context);
      setState(() {
        _isLoading = false;
      });
    }catch (error) {
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
        Container(color: Colors.white),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 120),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Text('Create your account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),softWrap: true,),
                      10.height,
                      AppTextField(
                        controller: fullNameController,
                        focus: fullNameFocusNode,
                        nextFocus: dienThoaiFocusNode,
                        textFieldType: TextFieldType.NAME,
                        decoration: rfInputDecoration(
                          lableText: "Name",
                          showLableText: true,
                          suffixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.person, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        controller: dienThoaiController,
                        focus: dienThoaiFocusNode,
                        nextFocus: emailFocusNode,
                        textFieldType: TextFieldType.PHONE,
                        decoration: rfInputDecoration(
                          lableText: "Phone Number",
                          showLableText: true,
                          suffixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.phone, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        controller: emailController,
                        focus: emailFocusNode,
                        nextFocus: passWordFocusNode,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: rfInputDecoration(
                          lableText: "Email",
                          showLableText: true,
                          suffixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.mail, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        controller: passwordController,
                        focus: passWordFocusNode,
                        nextFocus: confirmPasswordFocusNode,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: rfInputDecoration(
                          lableText: 'Password',
                          showLableText: true,
                          suffixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.lock, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        controller: confirmPasswordController,
                        focus: confirmPasswordFocusNode,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: rfInputDecoration(
                          showLableText: true,
                          lableText: 'Retype Password',
                          suffixIcon: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.lock, color: Colors.black, size: 14),
                          ),
                        ),
                      ),
                      16.height,
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        AppButton(
                          color: rf_primaryColor,
                          child: Text('Sign Up', style: boldTextStyle(color: white)),
                          width: context.width(),
                          elevation: 0,
                          onTap: () {
                            _submit();
                            // RFHomeScreen().launch(context);
                          },
                        ),
                      16.height,
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
                      5.height,
                      TextButton(
                          onPressed: (){},
                          child: Text("or", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff848A94)),)
                      ),
                      5.height,
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
                  ).paddingOnly(left: 20, right: 20, bottom: 30, top: 45),
                ).paddingOnly(left: 5, right: 5),
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(top: 30),
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
