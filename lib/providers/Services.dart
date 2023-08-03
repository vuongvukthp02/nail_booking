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
import 'Service.dart';

class Services with ChangeNotifier {
  late String authToken;
  late int uid;
  late List<Service> _items = [];

  List<Service> get items => _items;
  set items(List<Service> value) {
    _items = value;
  }

  Services({required this.authToken, required this.uid, items});
  Future<void> getListService(BuildContext context, int idBranch) async {
    // try
    {
      final response = await http.post(Uri.parse(RFGetListService),
          body: json.encode({"branch": idBranch}),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      final responseData = json.decode(response.body);

      if (!responseData['success'])
        throw HttpException(responseData['content']);
      else {
        final extractedData = Map<String, dynamic>.from(jsonDecode(
            response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
        // print("extractedData ${jsonDecode(response.body)['content']}");
        print('extrac ${extractedData["branch"]}');
        Service listContent = new Service(
          branch: extractedData['branch'].toString().toInt(),
          discount: extractedData['discount'].toString().toDouble(),
          discountBranch: extractedData['discountBranch'].toString().toDouble(),
          services_parent: extractedData['services_parent'],
          strDiscount: extractedData['strDiscount'].toString(),
          title: extractedData['title'].toString(),
        );
        _items.add(listContent);
        print('_items ${_items}');
      }
      notifyListeners();
    }
  }
}
