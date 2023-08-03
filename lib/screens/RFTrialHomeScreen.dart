import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/screens/RFEmailSignInScreen.dart';
import 'package:usastarnail/screens/RFResetPasswordScreen.dart';
import 'package:usastarnail/screens/RFSignUpScreen.dart';
import 'package:usastarnail/utils/RFColors.dart';
import 'package:usastarnail/utils/RFString.dart';
import 'package:provider/provider.dart';

import '../providers/Bookings.dart';
import 'RFServicesScreen.dart';
import 'RFTrialBookingScreen.dart';

class RFTrialHomeScreen extends StatefulWidget {
  const RFTrialHomeScreen({Key? key}) : super(key: key);

  @override
  State<RFTrialHomeScreen> createState() => _RFTrialHomeScreenState();
}

class _RFTrialHomeScreenState extends State<RFTrialHomeScreen> {
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
      loading = true;
    });
    final provider = Provider.of<Bookings>(context, listen: false);
    //loading
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
    return Stack(
      children: [
        Container(
          color: rf_primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: context.width(),
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/roomFinding/usastar_0.png',
                              width: MediaQuery.of(context).size.width * 0.85,
                            ),
                            8.height,
                            Text(
                              'BOOKING NOW',
                              style: TextStyle(
                                  color: rf_primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ).paddingOnly(bottom: 10),
                          ],
                        ).paddingOnly(top: 10)),
                    Container(
                      color: rf_primaryColor,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SELECT A BRANCH FROM LIST BELOW',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ).paddingOnly(top: 30)
                            ],
                          ),
                          20.height,
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'CLAPHAM SOUTH BRANCH',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'BATTERSEA BRANCH',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'Kingcross Branch',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'Hampstead Branch',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'Elephant',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.all(10),
                          //   child: AppButton(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen()));
                          //     },
                          //     child: Text(
                          //       'KILBURN BRANCH',
                          //       softWrap: true,
                          //       style: TextStyle(color: rf_primaryColor),
                          //     ),
                          //     width: context.width(),
                          //     elevation: 3,
                          //     shapeBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(color: Colors.white)),
                          //   ),
                          // ),
                          Container(
                            child:loading?Center(child: CircularProgressIndicator(color: Colors.white,),) :ListView.builder(
                                itemCount: danhMucs.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index){
                                  return
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: AppButton(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RFTrailBookingScreen(titleBranch: danhMucs[index]['name'].toString(),idBranch: danhMucs[index]['id'].toString().toInt(),)));
                                        },
                                        child: Text(
                                          danhMucs[index]['name'].toString(),
                                          softWrap: true,
                                          style: TextStyle(color: rf_primaryColor),
                                        ),
                                        width: context.width(),
                                        elevation: 3,
                                        shapeBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    );

                                }
                            ),
                          ),
                          10.height,
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.only(left: 10, right: 10),
                          //   child: AppButton(
                          //     color: Color(0xffAC1D67),
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFEmailSignInScreen())
                          //       );
                          //     },
                          //     child: Align(
                          //       alignment:Alignment.center,
                          //       child: Text(
                          //         'You are already have an account?\nLOGIN NOW!',
                          //         softWrap: true,
                          //         style: TextStyle(color: Colors.white, fontSize: 12),
                          //         textAlign: TextAlign.center,
                          //       ),
                          //     ),
                          //     shapeBorder: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(5)
                          //     ),
                          //     width: context.width(),
                          //   ),
                          // ),
                          // 10.height,
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.only(left: 10, right: 10),
                          //   child: AppButton(
                          //     color: Color(0xffAC1D67),
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => RFSignUpScreen())
                          //       );
                          //     },
                          //     child: Align(
                          //       alignment:Alignment.center,
                          //       child: Text(
                          //         'You need an account?\nSIGN UP NOW!',
                          //         softWrap: true,
                          //         style: TextStyle(color: Colors.white,fontSize: 12),
                          //         textAlign: TextAlign.center,
                          //       ),
                          //     ),
                          //     shapeBorder: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(5)
                          //     ),
                          //     width: context.width(),
                          //   ),
                          // ),
                          // TextButton(
                          //   onPressed: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => RFResetPasswordScreen())
                          //     );
                          //   },
                          //   child: Text('Request new password ?', style: TextStyle(
                          //       color: Colors.white
                          //   ),),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: rf_primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RFEmailSignInScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffAC1D67),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'You are already have an account?\nLOGIN NOW!',
                              softWrap: true,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ).paddingOnly(top: 3, bottom: 3),
                        ),
                      ),
                    ),
                    10.height,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RFSignUpScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffAC1D67),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'You need an account?\nSIGN UP NOW!',
                            softWrap: true,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ).paddingOnly(top: 3, bottom: 3),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RFResetPasswordScreen()));
                      },
                      child: Text(
                        'Request new password ?',
                        style: TextStyle(color: Colors.white),
                      ).paddingOnly(top: 8),
                    )
                  ],
                ),
                // child:
                //   Text('fvbfhsdvf').paddingOnly(left: 10, right: 10, top: 15, bottom: 15),
              ),
            ).paddingOnly(left: 15, right: 15, bottom: 15),
          ),
        ),
      ],
    );
  }
}
