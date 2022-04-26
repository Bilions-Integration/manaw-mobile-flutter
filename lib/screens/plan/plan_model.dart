import 'package:flutter/cupertino.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class PlanModel {
  final String name;
  final Map<String, int> prices;
  final String currency;
  final String image;
  final bool isPopular;
  final Color color;
  List<String>? planDetails;

  PlanModel({
    required this.name,
    required this.prices,
    required this.currency,
    required this.image,
    this.planDetails,
    this.isPopular = false,
    required this.color,
  });

  void addDetails(List<String> details) {
    planDetails = details;
  }
}
