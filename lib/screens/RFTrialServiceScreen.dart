import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/providers/Service.dart';
import 'package:provider/provider.dart';
import 'package:usastarnail/screens/RFCheckOutScreen.dart';

import '../providers/Services.dart';
import '../utils/RFColors.dart';
import '../widgets/SelectServiceDialog.dart';
import 'RFEmailSignInScreen.dart';
import 'RFResetPasswordScreen.dart';
import 'RFSignUpScreen.dart';

class RFTrialServiceScreen extends StatefulWidget {
  String titleBranch;
  int idBranch;

  RFTrialServiceScreen({
    this.titleBranch = '',
    required this.idBranch,
  });

  @override
  State<RFTrialServiceScreen> createState() => _RFTrialServiceScreenState();
}

class _RFTrialServiceScreenState extends State<RFTrialServiceScreen> {
  bool loading = false;
  int itemLength = 0;
  late List<Service> services = [];
  TextEditingController quantityController = TextEditingController(text: '1');
  List<Map<String, dynamic>> listServicesParent = [];
  List<Map<String, dynamic>> itemsService = [
    {
      'Service': 'Fullset Powder Gel with Normal Color',
      'Price': 'From £30',
      'isSelected': false
    },
    {
      'Service': 'Fullset Powder Gel with Normal Color',
      'Price': 'From £30',
      'isSelected': false
    },
    {
      'Service': 'Fullset Powder Gel with Normal Color',
      'Price': 'From £30',
      'isSelected': false
    },
    {
      'Service': 'Fullset Powder Gel with Normal Color',
      'Price': 'From £30',
      'isSelected': false
    },
  ];
  Map<String, dynamic> itemsSlected = {};

  @override
  void initState() {
    _reloadService(context);
    super.initState();
    // print("getClipBoardData ${getClipBoardData()}");
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  num sum(dynamic items) {
    num s = 0;
    for (dynamic item in items) {
      s += item['Price'];
    }
    return s;
  }

  Future<void> _reloadService(BuildContext context) async {
    setState(() {
      this.loading = true;
      print(widget.idBranch);
    });
    final provider = Provider.of<Services>(context, listen: false);
    await provider.getListService(context, widget.idBranch).then((value) {
      setState(() {
        services = provider.items;
        // print('danhMucs ${services}');
        // print('branch ${services[0].branch}');
        // print('services_parent ${services[0].services_parent}');
        // print('services_parent ${services[0].services_parent[0]["id_parent"]}');
        services[0].services_parent.forEach((element) {
          listServicesParent.add(element);
        });
        // listServicesParent.addAll(services[0].services_parent) ;
        print('listServicesParent ${listServicesParent}');
        loading = false;
      });
    }).onError((error, stackTrace) {
      print(error.toString());
      setState(() {
        loading = false;
      });
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
            Text(
              'Choose Services',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            10.height,
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: loading
                  ? Align(
                      child: CircularProgressIndicator(color: Colors.black),
                      alignment: Alignment.topCenter,
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //maxCrossAxisExtent: 300,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 3,
                          childAspectRatio: 5 / 2.5),
                      itemCount: listServicesParent.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SelectServiceDialog(
                                        id_parent: listServicesParent[index]
                                                ['id_parent']
                                            .toString(),
                                        title: widget.titleBranch,
                                        callback: (value) {
                                          setState(() {
                                            print("value ${value}");
                                            setState(() {
                                              itemsSlected.addAll(value);
                                              itemLength =
                                                  itemsSlected['listSer']
                                                      .length;
                                              print(itemLength);
                                            });
                                          });
                                        },
                                      );
                                    });
                              },
                              child: Container(
                                // margin: EdgeInsets.only(bottom: 5, top: 5, left: 2, right: 2),
                                // padding: EdgeInsets.all(8),
                                decoration: boxDecorationWithShadow(
                                  backgroundColor: Color(0xff398ACE),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Align(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    listServicesParent[index]
                                            ['service_parent_name']
                                        .toString(),
                                    style: primaryTextStyle(
                                        color: Colors.white,
                                        size: 13,
                                        weight: FontWeight.bold),
                                    softWrap: true,
                                  ),
                                ),
                              )),
                        );
                      }),
            ),
            itemsSlected.isNotEmpty
                ? Column(
                    children: [
                      for (int i = 0; i < itemLength; i++)
                        (Container(
                          height: MediaQuery.of(context).size.height * 0.2,
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
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '2+6525',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ).paddingOnly(left: 10)
                                ],
                              ),
                              10.height,
                              for (var items in itemsSlected['listSer'])
                                Row(
                                  children: [
                                    Text('Time: 16:00 x').paddingOnly(left: 10),
                                    15.width,
                                    Container(
                                        width: 25,
                                        height: 18,
                                        child: TextField(
                                          controller: quantityController,
                                        )
                                        //     Text('1', textAlign: TextAlign.end),
                                        // decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //         color:
                                        //             Colors.grey.withOpacity(0.3),
                                        //         spreadRadius: 5,
                                        //         blurRadius: 7,
                                        //         offset: Offset(0, 3),
                                        //       )
                                        //     ]),
                                        ),
                                    13.width,
                                    Text("x ${items['Price']}"),
                                    10.width,
                                    Text(
                                      '= ${int.parse(quantityController.text) * items['Price']}',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    5.width,
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Ionicons.trash,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              20.height,
                              Divider(
                                thickness: 1,
                              ).paddingOnly(left: 8, right: 8),
                              10.height,
                              Row(
                                children: [
                                  Text(
                                    'TOTAL: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ).paddingOnly(left: 80),
                                  Text(
                                    '${int.parse(quantityController.text) * 2}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('TOTAL:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                      .paddingOnly(left: 50),
                                  Text(
                                    ' ${int.parse(quantityController.text) * sum(itemsSlected['listSer'])}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ).paddingOnly(left: 25)
                                ],
                              )
                            ],
                          ),
                        )).paddingOnly(top: 20, left: 10, right: 10),
                      30.height,
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RFCheckOutScreen(
                                          titleBranch: widget.titleBranch,
                                        )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffAC1D67),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Booking Without Account',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ).paddingOnly(top: 3, bottom: 3),
                          ),
                        ),
                      ).paddingOnly(left: 8, right: 8),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ).paddingOnly(left: 10, right: 10),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.white,
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
                  style: TextStyle(color: Colors.black),
                ).paddingOnly(top: 8),
              )
            ],
          ),
          // child:
          //   Text('fvbfhsdvf').paddingOnly(left: 10, right: 10, top: 15, bottom: 15),
        ),
      ).paddingOnly(left: 15, right: 15, bottom: 15),
    );
  }
}
