import 'dart:developer';

import 'package:flutter/material.dart';

class Service with ChangeNotifier {
  dynamic services_parent;
  int branch;
  String strDiscount;
  double discount;
  double discountBranch;
  String title;

  Service({
    this.services_parent ,
    this.branch = 0,
    this.strDiscount = '',
    this.discount = 0,
    this.discountBranch = 0,
    this.title = '',
  });

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return '{nid: ${nid}, title: ${title}, field_ngay_dinh_duong_ref: ${field_ngay_dinh_duong_ref}, field_thuc_pham: ${field_thuc_pham}, field_so_luong: ${field_so_luong}}';
  // }
}
