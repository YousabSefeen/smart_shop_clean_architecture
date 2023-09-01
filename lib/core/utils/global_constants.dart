import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/home data/domain/entities/products.dart';

GetIt sl = GetIt.instance;
String token = '';
List<Products> allProducts = [];
Map<int, bool> favorites = {};
Map<int, bool> carts = {};

///**************************************************************

Locale currentLocale = const Locale("en");
String language = "en";
//  this is default Direction  in first  Start app
//  because the default Current Locale is ("ar")
TextDirection defaultDirection = TextDirection.rtl;

///**************************************************************
