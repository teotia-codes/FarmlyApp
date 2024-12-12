import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class CommodityPrice {
  final String state;
  final String district;
  final String market;
  final String commodity;
  final String variety;
  final String grade;
  final DateTime arrivalDate;
  final String minPrice;
  final String maxPrice;
  final String modalPrice;
  final String commodityCode;

  CommodityPrice({
    required this.state,
    required this.district,
    required this.market,
    required this.commodity,
    required this.variety,
    required this.grade,
    required this.arrivalDate,
    required this.minPrice,
    required this.maxPrice,
    required this.modalPrice,
    required this.commodityCode,
  });

  factory CommodityPrice.fromJson(Map<String, dynamic> json) {
    return CommodityPrice(
      state: json['State'],
      district: json['District'],
      market: json['Market'],
      commodity: json['Commodity'],
      variety: json['Variety'],
      grade: json['Grade'],
      arrivalDate: _parseDate(json['Arrival_Date']),
      minPrice: json['Min_Price'],
      maxPrice: json['Max_Price'],
      modalPrice: json['Modal_Price'],
      commodityCode: json['Commodity_Code'],
    );
  }

// Custom method to parse date in dd/MM/yyyy format
  static DateTime _parseDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      print('Date parsing error for $dateString');
      return DateTime(1970); // Return a default/fallback date if parsing fails
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'State': state,
      'District': district,
      'Market': market,
      'Commodity': commodity,
      'Variety': variety,
      'Grade': grade,
      'Arrival_Date': arrivalDate.toIso8601String(),
      'Min_Price': minPrice,
      'Max_Price': maxPrice,
      'Modal_Price': modalPrice,
      'Commodity_Code': commodityCode,
    };
  }

  static List<CommodityPrice> parseList(List<dynamic> jsonList) {
    return jsonList.map((json) => CommodityPrice.fromJson(json)).toList();
  }
}
