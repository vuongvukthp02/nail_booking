import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import '../utils/RFWidget.dart' as RFWidget;
import '../models/http_exeption.dart';

class Booking with ChangeNotifier {
  int id = 0;

  Booking(
      {this.id = 0,

        });


}
