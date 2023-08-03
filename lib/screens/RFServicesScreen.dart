import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/providers/Service.dart';
import 'package:usastarnail/providers/Services.dart';
import 'package:usastarnail/utils/RFWidget.dart';
import 'package:provider/provider.dart';


import '../main.dart';
import '../utils/RFColors.dart';

class Item{
  Item({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false

});
  String headerText;
  String expandedText;
  bool isExpanded;
}


class RFServicesScreen extends StatefulWidget {
  int idBranch ;
  RFServicesScreen({required this.idBranch});

  @override
  State<RFServicesScreen> createState() => _RFServicesScreenState();
}

class _RFServicesScreenState extends State<RFServicesScreen> {
  bool loading = false;
  late List<Service> services=[];
  List<Map<String, dynamic>> listServicesParent =[];
  @override
  void initState() {
    _reloadService(context);
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
    })
    .onError((error, stackTrace){
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
        title: Text('Services', style: boldTextStyle(color: appStore.textPrimaryColor)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listServicesParent.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadow(
                backgroundColor: context.cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: defaultBoxShadow(),
              ),
              child: Column(
                children: [
                  Text(
                    listServicesParent[index]['service_parent_name'].toString(),
                    style: primaryTextStyle(
                        color: rf_primaryColor,
                        size: 15,
                        weight: FontWeight.bold),
                      softWrap: true,
                  )
                ],
              ),
            ),
          );
        }
        ),
    //         body: ListView.builder(
    //   scrollDirection: Axis.vertical,
    //   itemCount: chiTietThucPhamTrongNgays.length,
    //   shrinkWrap: true,
    //   physics: NeverScrollableScrollPhysics(),
    //   itemBuilder: (BuildContext context, int index) {
    //     ChiTietThucPhamTrongNgay data = chiTietThucPhamTrongNgays[index];
    //     final thucPhams = jsonDecode(data.field_thuc_pham!);
    //     print(thucPhams);
    //     return
    //       GestureDetector(
    //         child: ListTileTheme(
    //           contentPadding: EdgeInsets.all(0),
    //           child: ExpansionTile(
    //             childrenPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    //             leading: Icon(Icons.fastfood_rounded, color: Colors.lightGreen, size: 30),
    //             title: Text('${data.title}', style: primaryTextStyle()),
    //             subtitle: Container(
    //               child: Row(
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Text("Kcal: 0"),
    //                       8.width,
    //                       Text("Chất béo: 0"),
    //                       8.width,
    //                       Text("Tinh bột: 0"),
    //                       Text("Chất xơ: 0"),
    //                       Text("Protein: 0"),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //             trailing: isExpanded.validate(value: false)
    //               ? Container(
    //                     child: Icon(Icons.keyboard_arrow_up, color: Colors.blue, size: 30),
    //                     padding: EdgeInsets.all(4),
    //                     decoration: BoxDecoration(borderRadius: radius(100), color: Colors.blue.withAlpha(32)),
    //               )
    //               : Container(
    //                 decoration: BoxDecoration(borderRadius: radius(100), color: context.cardColor),
    //                 padding: EdgeInsets.all(4),
    //                 child: Icon(Icons.keyboard_arrow_down, color: context.iconColor, size: 30),
    //               ),
    //             onExpansionChanged: (t) {
    //               isExpanded = !isExpanded.validate(value: false);
    //               setState(() {});
    //             },
    //             children: [
    //               Container(
    //                 decoration: BoxDecoration(color: Colors.blue.withAlpha(32), borderRadius: radius()),
    //                 padding: EdgeInsets.all(16),
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Text(
    //                           'Purchase UI Kits to boost your design process.Get Material-X',
    //                           style: boldTextStyle(size: 18),
    //                         ).expand(),
    //                         Container(
    //                           padding: EdgeInsets.all(4),
    //                           decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius(100)),
    //                           child: Icon(
    //                             Icons.more_horiz,
    //                             color: context.iconColor,
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     16.height,
    //                     SettingItemWidget(
    //                       title: 'Design System Tokens',
    //                       subTitle: '16 March, 2020',
    //                       leading: Container(
    //                         padding: EdgeInsets.all(4),
    //                         decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
    //                         child: Icon(
    //                           Icons.folder_open,
    //                           color: Colors.blue,
    //                         ),
    //                       ),
    //                     ),
    //                     SettingItemWidget(
    //                       title: 'Design Specs',
    //                       subTitle: '18 March, 2018',
    //                       leading: Container(
    //                         padding: EdgeInsets.all(4),
    //                         decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
    //                         child: Icon(Icons.folder_open, color: Colors.blue),
    //                       ),
    //                     ),
    //                     SettingItemWidget(
    //                       title: 'Guidelines',
    //                       subTitle: '31 December, 2020',
    //                       leading: Container(
    //                         padding: EdgeInsets.all(4),
    //                         decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
    //                         child: Icon(Icons.folder_open, color: Colors.blue),
    //                       ),
    //                     ),
    //                     Text(
    //                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
    //                     ).paddingAll(8),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: [
    //                         AppButton(
    //                           onTap: () {},
    //                           color: context.cardColor,
    //                           shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
    //                           text: 'Purchase Me',
    //                           textStyle: primaryTextStyle(),
    //                           padding: EdgeInsets.all(8),
    //                         ),
    //                         8.width,
    //                         AppButton(
    //                           onTap: () {},
    //                           shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
    //                           text: 'I want this Kit',
    //                           textStyle: primaryTextStyle(color: Colors.white),
    //                           padding: EdgeInsets.all(8),
    //                           color: Colors.blueAccent,
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         onTap: (){
    //         },
    //       );
    //   },
    // );

    );
  }
}
