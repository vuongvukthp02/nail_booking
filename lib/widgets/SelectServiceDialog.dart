import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';

class SelectServiceDialog extends StatefulWidget {
  String id_parent;
 String title;
 late Function(Map<String, dynamic>) callback;

 SelectServiceDialog({this.title= '',required this.callback, required this.id_parent });

  @override
  State<SelectServiceDialog> createState() => _SelectServiceDialogState();
}

class _SelectServiceDialogState extends State<SelectServiceDialog> {
  bool loading = false;
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
  List<Map<String, dynamic>> itemsSelected=[];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // To make the card compact
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text('Choose service for ${widget.title}',
                        style: boldTextStyle(
                            color: appStore.textPrimaryColor, size: 15), softWrap: true,).expand(),
                    // Container(
                    //     padding: EdgeInsets.all(4),
                    //     alignment: Alignment.centerRight,
                    //     child:
                    //     Icon(Icons.close, color: appStore.textPrimaryColor))
                  ],
                ),
              ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemsService.length,
            itemBuilder: (BuildContext context, int index){
              return  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: rf_primaryColor,
                      value: itemsService[index]['isSelected'],
                      onChanged: (value) {
                        setState(() {
                          itemsService[index]['isSelected'] = !itemsService[index]['isSelected'];
                        });
                      }),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        itemsService[index]['isSelected'] = !itemsService[index]['isSelected'];
                      });
                    },
                    child: Row(
                      children: [
                        Text(itemsService[index]['Service'], softWrap: true,).expand(),
                        Text(itemsService[index]['Price']),
                      ],
                    ),
                  ).expand(),
                ],
              );
            }
        ),
              16.height,
              loading
                  ? Center(
                child: CircularProgressIndicator(color: rf_primaryColor, strokeWidth: 4,),
              )
                  : Center(
                    child: AppButton(
                color: rf_primaryColor,
                child: Text('Choose',
                      style: boldTextStyle(
                        color: white,
                      )).paddingOnly(left: 50, right: 50),

                elevation: 5,
                shapeBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: rf_primaryColor)),
                onTap: () {
                  itemsSelected=[];
                  itemsService.forEach((element) {
                    if(element['isSelected']){
                      itemsSelected.add(element);
                    }
                  });
                  print('danh sach da chon ${itemsSelected}');
                  itemsSelected.isNotEmpty ?
                  widget.callback({
                    'id_parent': widget.id_parent,
                    'listSer': itemsSelected
                  }) : SizedBox();
                  finish(context);
                },
              ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
