import 'package:flutter/cupertino.dart';

class PlanModel {
  final String name;
  final Map<String, int> prices;
  final String currency;
  final String image;
  final bool isPopular;
  final Color color;
  List<String> planDetails;

  PlanModel({
    required this.name,
    required this.prices,
    required this.currency,
    required this.image,
    required this.planDetails,
    this.isPopular = false,
    required this.color,
  });
}
