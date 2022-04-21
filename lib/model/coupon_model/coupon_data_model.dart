import 'coupon_model.dart';

class CouponDataModel {
  bool? lastPage;
  int? total;
  List<CouponModel>? data;

  CouponDataModel({this.lastPage, this.total, this.data});

  factory CouponDataModel.fromJson(Map json) => CouponDataModel(
    lastPage: json['last_page'] as bool?,
    total: json['total'] as int?,
    data: (json['data'] as List).map((e) => CouponModel.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'last_page': lastPage,
    'total': total,
    'data': data,
  };
}
