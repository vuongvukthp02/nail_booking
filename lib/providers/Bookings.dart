import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/providers/Booking.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import '../utils/RFWidget.dart' as RFWidget;
import '../models/http_exeption.dart';

class Bookings with ChangeNotifier {
  late String authToken;
  late int uid;
  late List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;
  set items(List<Map<String, dynamic>> value) {
    _items = value;
  }

  Bookings({required this.authToken,required this.uid, items});

  Future<void> getListBranch(BuildContext context) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetListBranch),
          body: json.encode({
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );
      final responseData = json.decode(response.body);

      if (!responseData['success'])
        throw HttpException(responseData['content']);
      else {
        final extractedData = List<Map<String, dynamic>>.from(jsonDecode(
            response
                .body)['content']); //json.decode(response.body) as Map<String, dynamic>;
        print("responseData ${responseData}");
        final List<Map<String,dynamic>> listContent =[];
        extractedData.forEach((element) {
          // Booking newBranch = new Booking(
          //   id: element['id'].toString().toInt(),
          //   name: element['name'],
          //   type: element['type'],
          //   code: element['code'],
          //   price: element['price'].toString().toDouble(),
          //   orderBranch: element['order_branch'].toString().toInt(),
          //   phone: element['phone'].toString().toInt(),
          //   address: element['address'],
          //   hide: element['hide'].toString().toInt(),
          //   parentId: element['parent_id'].toString().toInt(),
          //   note: element['note'],
          //   image: element['image'],
          //   active: element['active'].toString().toInt(),
          //   expire: element['expire'],
          //   discount: element['discount'].toString().toDouble(),
          // );
          Map<String, dynamic> newBranch = element;
          listContent.add(newBranch);
        });
        _items = listContent;
        print('_items ${_items}');
      }
      notifyListeners();
    }
  }
}