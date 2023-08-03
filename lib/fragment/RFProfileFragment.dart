import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/main.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:provider/provider.dart';
import '../utils/RFWidget.dart';
import 'package:intl/intl.dart';


class RFProfileFragment extends StatefulWidget {
  @override
  _RFProfileFragmentState createState() => _RFProfileFragmentState();
}

class _RFProfileFragmentState extends State<RFProfileFragment> {

  @override
  void initState() {
    super.initState();
    // print("getClipBoardData ${getClipBoardData()}");
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    var categoryWidth = (width - 56) / 3;

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
          title: Text('Profile', style: boldTextStyle(color: appStore.textPrimaryColor)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ]
            )
        )
    );
  }
}
