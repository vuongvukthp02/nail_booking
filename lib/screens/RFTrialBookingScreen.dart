import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/screens/RFTrialServiceScreen.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../main.dart';
import '../providers/Bookings.dart';
import '../utils/AppTheme.dart';
import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';
import 'RFEmailSignInScreen.dart';
import 'RFResetPasswordScreen.dart';
import 'RFSignUpScreen.dart';

class RFTrailBookingScreen extends StatefulWidget {
  String titleBranch;
  int idBranch;

  RFTrailBookingScreen({this.titleBranch = '', required this.idBranch});

  @override
  State<RFTrailBookingScreen> createState() => _RFTrailBookingScreenState();
}

class _RFTrailBookingScreenState extends State<RFTrailBookingScreen> {
  List<String> listTimes = [];
  String newdate = '';
  var loading =  false;
  late List<Map<String, dynamic>> danhMucs=[];

  TextEditingController tuNgayController = TextEditingController();
  TextEditingController denNgayController = TextEditingController();

  FocusNode tuNgayFocusNode = FocusNode();
  FocusNode denNgayFocusNode = FocusNode();
  FocusNode f4 = FocusNode();

  DateTime? selectedDate;

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

  Map<int, dynamic> itemsCalendar = {
    0: {
      'color': '1',
      'id': '1',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    1: {
      'color': '1',
      'id': '2',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    2: {
      'color': '1',
      'id': '3',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    3: {
      'color': '1',
      'id': '4',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    4: {
      'color': '1',
      'id': '5',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    5: {
      'color': '1',
      'id': '6',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    6: {
      'color': '1',
      'id': '7',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    7: {
      'color': '1',
      'id': '8',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    8: {
      'color': '1',
      'id': '9',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    9: {
      'color': '1',
      'id': '10',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    10: {
      'color': '1',
      'id': '11',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    11: {
      'color': '1',
      'id': '12',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    12: {
      'color': '1',
      'id': '13',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    13: {
      'color': '1',
      'id': '14',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    14: {
      'color': '1',
      'id': '15',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    15: {
      'color': '1',
      'id': '16',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    16: {
      'color': '1',
      'id': '17',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
    17: {
      'color': '1',
      'id': '18',
      'time': '09:30',
      'shift': 'AM',
      'amount': '5 Left'
    },
  };

  List<String> listSelectedDate = [];

  void initState() {
    newdate = tuNgayController.text;
    tuNgayController.addListener(() {
      if (newdate != tuNgayController.text) {
        listTimes.add(tuNgayController.text);
      }
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Pick_times(title: '')));
    });
    // TODO: implement initState
    super.initState();
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? ThemeData.dark()
              : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        setState(() {
          tuNgayController.text =
              "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
        });
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  void selectDateAndTime2(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? ThemeData.dark()
              : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        denNgayController.text =
            "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return BackButton(
        color: appStore.textPrimaryColor,
        onPressed: () {
          toasty(context, 'Back button');
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.titleBranch,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Select date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  10.height,
                  AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    controller: tuNgayController,
                    focus: tuNgayFocusNode,
                    readOnly: true,
                    onTap: () {
                      selectDateAndTime(context);
                    },
                    onFieldSubmitted: (v) {
                      tuNgayFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(f4);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "Choose a date",
                      suffixIcon: Icon(Icons.calendar_month_rounded,
                          size: 16,
                          color: appStore.isDarkModeOn ? white : gray),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  tuNgayController.text.isNotEmpty
                      ? Column(
                          children: [
                            Text(
                              "Select TimeSlot",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            5.height,
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          //maxCrossAxisExtent: 300,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          crossAxisCount: 6
                                      ),
                                  itemCount: itemsCalendar.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          listSelectedDate.contains(
                                                  itemsCalendar[index]['id'])
                                              ? (listSelectedDate.remove(
                                                  itemsCalendar[index]['id']))
                                              : (listSelectedDate.add(
                                                  itemsCalendar[index]['id']));
                                          listSelectedDate.contains(
                                                  itemsCalendar[index]['id'])
                                              ? itemsCalendar[index]['color'] =
                                                  '2'
                                              : itemsCalendar[index]['color'] =
                                                  '1';
                                        });
                                      },
                                      child: Container(
                                        //alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: itemsCalendar[index]
                                                        ['color'] ==
                                                    '1'
                                                ? Colors.blue.shade300
                                                : Color(0xFF3c763d),
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Column(
                                          verticalDirection:
                                              VerticalDirection.up,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              alignment: Alignment.center,
                                              height: 13,
                                              width:
                                                  MediaQuery.of(ctx).size.width,
                                              color: Colors.white12,
                                              child:
                                              Text(
                                                // itemsCalendar[index]['amount'],
                                                // style: TextStyle(
                                                //     color: Colors.white,
                                                //     fontSize: 13
                                                // ),
                                                ''
                                              ),
                                            ),
                                            Text(
                                              itemsCalendar[index]['shift'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 7.7
                                              ),
                                            ),
                                            Text(
                                              itemsCalendar[index]['time'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 7.7
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            30.height,
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: AppButton(
                                color: Color(0xffAC1D67),
                                onTap: () {
                                  RFTrialServiceScreen(idBranch: widget.idBranch,titleBranch: widget.titleBranch,).launch(context);
                                },
                                child: Align(
                                  alignment:Alignment.center,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                width: context.width(),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  10.height,
                ],
              ),
            ),
            30.height,
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: AppButton(
                color: Color(0xffAC1D67),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RFEmailSignInScreen()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'You are already have an account?\nLOGIN NOW!',
                    softWrap: true,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                width: context.width(),
              ),
            ),
            10.height,
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: AppButton(
                color: Color(0xffAC1D67),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RFSignUpScreen()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'You need an account?\nSIGN UP NOW!',
                    softWrap: true,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                width: context.width(),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RFResetPasswordScreen()));
              },
              child: Text(
                'Request new password ?',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ).paddingOnly(
        top: 10,
        left: 15,
        right: 15,
      ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Container(
        //   height:  MediaQuery.of(context).size.height *0.245,
        //   width: MediaQuery.of(context).size.width,
        //   child: Container(
        //     color: Colors.white,
        //     child: Column(
        //       children: [
        //         Container(
        //           alignment: Alignment.center,
        //           padding: EdgeInsets.only(left: 10, right: 10),
        //           child: AppButton(
        //             color: Color(0xffAC1D67),
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => RFEmailSignInScreen()));
        //             },
        //             child: Align(
        //               alignment: Alignment.center,
        //               child: Text(
        //                 'You are already have an account?\nLOGIN NOW!',
        //                 softWrap: true,
        //                 style: TextStyle(color: Colors.white, fontSize: 12),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //             shapeBorder: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(5)),
        //             width: context.width(),
        //           ),
        //         ),
        //         10.height,
        //         Container(
        //           alignment: Alignment.center,
        //           padding: EdgeInsets.only(left: 10, right: 10),
        //           child: AppButton(
        //             color: Color(0xffAC1D67),
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => RFSignUpScreen()));
        //             },
        //             child: Align(
        //               alignment: Alignment.center,
        //               child: Text(
        //                 'You need an account?\nSIGN UP NOW!',
        //                 softWrap: true,
        //                 style: TextStyle(color: Colors.white, fontSize: 12),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //             shapeBorder: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(5)),
        //             width: context.width(),
        //           ),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => RFResetPasswordScreen()));
        //           },
        //           child: Text(
        //             'Request new password ?',
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         )
        //       ],
        //     ),
        //     // child:
        //     //   Text('fvbfhsdvf').paddingOnly(left: 10, right: 10, top: 15, bottom: 15),
        //   ),
        // ).paddingOnly(left: 15, right: 15, bottom: 15)
    );
  }
}
