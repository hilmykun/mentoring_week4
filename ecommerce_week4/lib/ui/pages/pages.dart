import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_week4/custom/shared/shared.dart';
import 'package:ecommerce_week4/model/model.dart';
import 'package:ecommerce_week4/network/network.dart';
import 'package:ecommerce_week4/ui/product/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'main_page.dart';
part 'onboarding_page.dart';
part 'register.dart';
part 'login_page.dart';