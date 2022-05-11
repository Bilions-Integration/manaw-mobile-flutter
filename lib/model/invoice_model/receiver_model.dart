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

  ReceiverModel.fromJson(Map json)
      : receiverId = json['receiver_id'] ?? 0,
        receiverName = json['receiver_name'] ?? '',
        receiverEmail = json['receiver_email'] ?? '',
        receiverPhone = json['receiver_phone'] ?? '',
        shippingAddress = json['shipping_address'] ?? '',
        billingAddress = json['billing_address'] ?? '';

  Map toJson() => {
        'receiver_id': receiverId,
        'receiver_name': receiverName,
        'receiver_email': receiverEmail,
        'receiver_phone': receiverPhone,
        'shipping_address': shippingAddress,
        'billing_address': billingAddress
      };
}
