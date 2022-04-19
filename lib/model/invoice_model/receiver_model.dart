class ReceiverModel {
  final int? receiver_id;
  final String? receiver_name;
  final String? receiver_email;
  final String? receiver_phone;
  final String? billing_address;
  final String? shipping_address;

  ReceiverModel({
    this.receiver_id, 
    this.receiver_name, 
    this.receiver_email, 
    this.receiver_phone, 
    this.billing_address, 
    this.shipping_address
  });

  ReceiverModel.fromJson(Map json) :
    receiver_id = json['receiver_id'] ?? 0,
    receiver_name = json['receiver_name'] ?? '',
    receiver_email = json['receiver_email'] ?? '',
    receiver_phone = json['receiver_phone'] ?? '',
    shipping_address = json['shipping_address'] ?? '',
    billing_address = json['billing_address'] ?? '';
  
  Map toJson() => { 
    'receiver_id' : receiver_id, 
    'receiver_name' : receiver_name,
    'receiver_email' : receiver_email,
    'receiver_phone' : receiver_phone,
    'shipping_address' : shipping_address,
    'billing_address' : billing_address
  };
}
