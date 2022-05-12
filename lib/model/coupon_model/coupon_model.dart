class CouponModel {
  int? id;
  String? name;
  String? couponCode;
  dynamic customerEmails;
  String? type;
  int? amount;
  int? percent;
  dynamic useableTime;
  dynamic validFrom;
  dynamic validTo;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  int? userId;
  bool? status;
  List<dynamic>? discountProducts;

  CouponModel({
    this.id,
    this.name,
    this.couponCode,
    this.customerEmails,
    this.type,
    this.amount,
    this.percent,
    this.useableTime,
    this.validFrom,
    this.validTo,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.userId,
    this.status,
    this.discountProducts,
  });

  factory CouponModel.fromJson(Map json) => CouponModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        couponCode: json['coupon_code'] as String?,
        customerEmails: json['customer_emails'] as dynamic,
        type: json['type'] as String?,
        amount: json['amount'] as int?,
        percent: json['percent'] as int?,
        useableTime: json['useable_time'] as dynamic,
        validFrom: json['valid_from'] as dynamic,
        validTo: json['valid_to'] as dynamic,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        companyId: json['company_id'] as int?,
        userId: json['user_id'] as int?,
        status: json['status'] as bool?,
        discountProducts: json['discount_products'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coupon_code': couponCode,
        'customer_emails': customerEmails,
        'type': type,
        'amount': amount,
        'percent': percent,
        'useable_time': useableTime,
        'valid_from': validFrom,
        'valid_to': validTo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'company_id': companyId,
        'user_id': userId,
        'status': status,
        'discount_products': discountProducts,
      };
}
