import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/utils/RFColors.dart';

import '../common/constants.dart';
import '../main.dart';
import '../utils/AppTheme.dart';
import '../utils/RFWidget.dart';

class RFCheckOutScreen extends StatefulWidget {
  String titleBranch;

  RFCheckOutScreen({this.titleBranch = ''});

  @override
  State<RFCheckOutScreen> createState() => _RFCheckOutScreenState();
}

class _RFCheckOutScreenState extends State<RFCheckOutScreen> {
  List<String> listTimes = [];
  String newdate = '';


  TextEditingController fullNameController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();
  TextEditingController tuNgayController = TextEditingController();
  TextEditingController denNgayController = TextEditingController();
  TextEditingController noteController = TextEditingController();



  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userDateOfBirthFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode tuNgayFocusNode = FocusNode();
  FocusNode denNgayFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.titleBranch,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
            children: [
              Text('CHECKOUT', style: TextStyle(color: rf_primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
            ],
          ).paddingOnly(left: 10, right: 10, top: 20),
            Row(
              children: [
                Text('Booking information', style: TextStyle(fontWeight: FontWeight.bold),).paddingOnly(left: 10, top: 5, right: 10)
              ],
            ),
            10.height,
            Column(
              children: [
                AppTextField(
                  controller: fullNameController,
                  focus: fullNameFocusNode,
                  nextFocus: dienThoaiFocusNode,
                  textFieldType: TextFieldType.NAME,
                  decoration: rfInputDecoration(
                    lableText: "Full Name",
                    showLableText: true,
                    suffixIcon: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(Icons.person, color: Colors.black, size: 14),
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
                  textFieldType: TextFieldType.OTHER,
                  controller: tuNgayController,
                  focus: tuNgayFocusNode,
                  onTap: () {
                    selectDateAndTime(context);
                  },
                  onFieldSubmitted: (v) {
                    tuNgayFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(f4);
                  },
                  decoration: inputDecoration(
                    context,
                    labelText: 'Birthday',
                    suffixIcon: Icon(Icons.calendar_month_rounded,
                        size: 16,
                        color: appStore.isDarkModeOn ? white : gray),
                  ),
                ),
              ],
            ).paddingOnly(left: 10, right: 10),
            Row(
              children: [
                Text('Note').paddingOnly(left: 10, top: 10)
              ],
            ),
            10.height,
            AppTextField(
                textFieldType: TextFieldType.OTHER,
              controller: noteController,
              focus: noteFocusNode,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.white)
                )
              ),
            ).paddingOnly(left: 10, right: 10),
            Row(
              children: [
                Text('SERVICE', style: TextStyle(color: rf_primaryColor, fontWeight: FontWeight.bold, fontSize: 16),).paddingOnly(top: 10, left: 10, right: 10)
              ],
            ),
            10.height,
            (Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: context.width(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Fullset Powder Gel with Normal Color', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),).paddingOnly(left: 10)
                    ],
                  ),
                  10.height,
                  Row(
                    children: [
                      Text('Time: 16:00 x').paddingOnly(left: 10),
                      15.width,
                      Container(
                        width: 25,
                        height: 18,
                        child: Text('1', textAlign: TextAlign.end),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                      ),
                      13.width,
                      Text('x  From £38  =  '),
                      10.width,
                      Text('£38 ',style: TextStyle(color: Colors.red), ),
                      5.width,
                      GestureDetector(
                        onTap: (){},
                        child: Icon(Ionicons.trash, size: 14, color: Colors.red,),
                      )
                    ],
                  ),
                  20.height,
                  Row(
                    children: [
                      Text('Time: 16:00 x').paddingOnly(left: 10),
                      15.width,
                      Container(
                        width: 25,
                        height: 18,
                        child: Text('1', textAlign: TextAlign.end),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                      ),
                      13.width,
                      Text('x  From £38  =  '),
                      10.width,
                      Text('£38 ',style: TextStyle(color: Colors.red), ),
                      5.width,
                      GestureDetector(
                        onTap: (){},
                        child: Icon(Ionicons.trash, size: 14, color: Colors.red,),
                      )
                    ],
                  ),
                  Divider(thickness: 1,).paddingOnly(left: 8, right: 8),
                  10.height,
                  Row(
                    children: [
                      Text('TOTAL: ', style: TextStyle(fontWeight: FontWeight.bold),).paddingOnly(left: 80),
                      Text('2',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)).paddingOnly(left: 50),
                      Text('£76', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),).paddingOnly(left: 25)
                    ],
                  )
                ],
              ),
            )).paddingOnly(top: 20, left: 10, right: 10, bottom: 20),
          ]
        ),
      )
    );
  }
}
