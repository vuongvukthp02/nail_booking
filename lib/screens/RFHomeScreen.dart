import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/fragment/RFBookingFragment.dart';
import 'package:usastarnail/fragment/RFHomeFragment.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:ionicons/ionicons.dart';

import '../fragment/RFProfileFragment.dart';


class RFHomeScreen extends StatefulWidget {
  static const routeName = '/home';
  int selectedIndex = 0;
  int selectedTabDonHang = 0;

  late bool showDialog = false;
  String contentAlert = '';
  Timer? timer;

  RFHomeScreen({this.selectedIndex = 0});

  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {
  var _pages = [
    RFHomeFragment(),
    RFBookingFragment(),
    RFProfileFragment(),
  ];
//
//
  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 12),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: rf_textColor,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Ionicons.home_outline, size: 22,),
          label: 'Home',
          activeIcon: Icon(Ionicons.home, color: rf_textColor, size: 22),
        ),
        BottomNavigationBarItem(
            icon: Icon(Ionicons.calendar_outline, size: 22), //rf_search.iconImage(),
            label: 'Booking',
            activeIcon: Icon(Ionicons.calendar, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
        BottomNavigationBarItem(
            icon: Icon(Ionicons.ellipsis_horizontal_outline, size: 22), //rf_search.iconImage(),
            label: 'More',
            activeIcon: Icon(Ionicons.ellipsis_horizontal, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if(widget.selectedTabDonHang > 0){
        widget.selectedIndex = 5;
        widget.selectedTabDonHang = 0;
      }
      else
        widget.selectedIndex = index;
    });
  }

  @override
  void initState() {

    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(rf_textColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(widget.selectedIndex)),
    );
  }
}
