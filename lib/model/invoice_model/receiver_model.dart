class ReceiverModel {
  final int? receiverId;
  final String? receiverName;
  final String? receiverEmail;
  final String? receiverPhone;
  final String? billingAddress;
  final String? shippingAddress;

  ReceiverModel(
      {this.receiverId,
      this.receiverName,
      this.receiverEmail,
      this.receiverPhone,
      this.billingAddress,
      this.shippingAddress});

  factory ReceiverModel.fromJson(Map? json) {
    if(json != null ) {
      return ReceiverModel(
        receiverId : json['receiver_id'] ?? 0,
        receiverName : json['receiver_name'] as String?,
        receiverEmail : json['receiver_email'] as String?,
        receiverPhone : json['receiver_phone'] as String?,
        shippingAddress : json['shipping_address'] as String?,
        billingAddress : json['billing_address'] as String?
      );
    } else {
      return ReceiverModel();
    }
  }

  Map toJson() => {
        'receiver_id': receiverId,
        'receiver_name': receiverName,
        'receiver_email': receiverEmail,
        'receiver_phone': receiverPhone,
        'shipping_address': shippingAddress,
        'billing_address': billingAddress
      };
}
