import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/main.dart';
import 'package:usastarnail/providers/Booking.dart';
import 'package:usastarnail/providers/Bookings.dart';
import 'package:usastarnail/screens/RFServicesScreen.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:provider/provider.dart';
import '../utils/RFImages.dart';
import '../utils/RFWidget.dart';
import 'package:intl/intl.dart';


class RFBookingFragment extends StatefulWidget {
  @override
  _RFBookingFragmentState createState() => _RFBookingFragmentState();
}

class _RFBookingFragmentState extends State<RFBookingFragment> {
var loading =  false;
late List<Map<String, dynamic>> danhMucs=[];
  @override
  void initState() {
    _reloadDanhMuc(context);
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
  Future<void> _reloadDanhMuc(BuildContext context) async {
    setState(() {
      this.loading = true;
    });
    final provider = Provider.of<Bookings>(context, listen: false);
    await provider.getListBranch(context).then((value) {
      setState(() {
       danhMucs = provider.items;
        print('danhMucs ${danhMucs}');
        // print('title ${danhMucs[0]['id']}');
        loading = false;
      });
    });
    // .onError((error, stackTrace){
    // print(error.toString());
    // setState(() {
    //   loading = false;
    // });
    // });
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
          title: Text('Booking', style: boldTextStyle(color: appStore.textPrimaryColor)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
                children: [
                  Center(
                    child: Text(
                      'SELECT A BRANCH FROM LIST BELOW',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      softWrap: true,
                    ),
                  ),
                  16.height,
                  Container(
                    child: ListView.builder(
                      itemCount: danhMucs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(8),
                            decoration: boxDecorationWithShadow(
                              backgroundColor: context.cardColor,
                              boxShadow: defaultBoxShadow(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  danhMucs[index]['name'].toString(),
                                  style: primaryTextStyle(
                                      color: rf_primaryColor,
                                      size: 15,
                                      weight: FontWeight.bold),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                           onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RFServicesScreen(idBranch: danhMucs[index]['id'].toString().toInt(),)));
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                                // builder: (context) => ChiTietBuaAn(
                                //   soLuong: data.field_so_luong,
                                //   tenBuaAn: data.title,
                                //   thongTinBuaAn: danhSachThucPhamTrongNgay[index]
                                //       .field_thuc_pham,
                                //   tongChiSoBuaAn: tongChiSoTrongNgay[index],
                                // ),
                            //   ),
                            // );
                           },
                        ).paddingOnly(bottom: 8);
                        }
                    ),
                  )
                ]
            )
        ).paddingAll(10)
    );
  }
}
