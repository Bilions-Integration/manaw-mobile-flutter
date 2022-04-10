import 'package:my_app/helpers/moment.dart';

class ReceiverModel {
  final String name;
  final String? shipping_address;
  ReceiverModel({required this.name, this.shipping_address});
  ReceiverModel.fromJson(Map json) : name = json['receiver_name'], shipping_address = json['shipping_address'];
  Map<String, dynamic> toJson() => { 'name' : name, 'shipping_address' : shipping_address };
}

class AccountModel {
  final String bank_name;
  AccountModel({required this.bank_name});
  AccountModel.fromJson(Map json) : bank_name = json['bank_name'];
  Map<String, dynamic> toJson() => { 'bank_name' : bank_name };
}

class ProductModel {
  final int id;
  final int quantity;
  final int price;
  ProductModel(this.id, this.quantity, this.price);
  ProductModel.fromJson(Map json) 
    : id = json['id'], 
      quantity = json['quantity'], 
      price = json['price'];
}

class InvoiceModel {
  final int? id;
  final String type;
  final String invoice_date;
  final String due_date;
  final int total;
  final int grand_total;
  final String invoice_number;
  final int tax_value;
  final String created_at;
  final Map? receiver;
  final Map? account;
  final List<ProductModel> products;
  // final dynamic status;
  // final int user_id;
  // final int tax;
  // final String vat_type;
  // final int? discount;
  // final int? percent;
  // final String discount_type;
  // final bool partial_paid;
  // final dynamic payment_type;
  // final dynamic payment_status;
  // final int paid_amount;
  // final int remain_amount;
  // final int account_id;
  // final dynamic account_balance;
  // final int company_id;
  // final dynamic platform;
  // final dynamic reference_number;
  // final dynamic coupon_code;
  // final bool is_manual;

  InvoiceModel({
    this.id,
    required this.type, 
    required this.invoice_number, 
    this.receiver,
    this.account,
    required this.products,
    required this.invoice_date, 
    required this.due_date, 
    required this.total, 
    required this.grand_total, 
    required this.tax_value, 
    required this.created_at
    // required this.status, 
    // required this.user_id, 
    // required this.tax, 
    // required this.vat_type, 
    // this.discount, 
    // this.percent, 
    // required this.discount_type, 
    // required this.partial_paid, 
    // required this.payment_type, 
    // required this.payment_status, 
    // required this.paid_amount, 
    // required this.remain_amount, 
    // required this.account_id, 
    // required this.account_balance, 
    // required this.company_id, 
    // required this.platform, 
    // required this.reference_number, 
    // required this.coupon_code, 
    // required this.is_manual, 
  });

  InvoiceModel.fromJson(Map json) 
    : id = json['id'],
      type = json['type'],
      invoice_number = json['invoice_number'],
      created_at = moment(json['created_at']).format(),
      grand_total = json['grand_total'],
      invoice_date = moment(json['invoice_date']).format(),
      due_date = moment(json['due_date']).format(),
      total = json['total'],
      tax_value = json['tax_value'],
      receiver = ReceiverModel.fromJson(json['receiver']).toJson(),
      account = AccountModel.fromJson(json['account']).toJson(),
      products= ( json['products'] as List ).map((e) => ProductModel.fromJson(e)).toList();
      // status = json['status'],
      // user_id = json['user_id'],
      // tax = json['tax'],
      // vat_type = json['vat_type'],
      // discount = json['discount'],
      // percent = json['percent'],
      // discount_type = json['discount_type'],
      // partial_paid = json['partial_paid'],
      // payment_type = json['payment_type'],
      // payment_status = json['payment_status'],
      // paid_amount = json['paid_amount'],
      // remain_amount = json['remain_amount'],
      // account_id = json['account_id'],
      // account_balance = json['account_balance'],
      // company_id = json['company_id'],
      // platform = json['platform'],
      // reference_number = json['reference_number'],
      // coupon_code = json['coupon_code'],
      // is_manual = json['is_manual'],


  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'invoice_number' : invoice_number,
    'created_at' : created_at,
    'invoice_date' : invoice_date,
    'due_date' : due_date,
    'total' : total,
    'grand_total' : grand_total,
    'tax_value' : tax_value,
    // 'status' : status,
    // 'user_id' : user_id,
    // 'tax' : tax,
    // 'vat_type' : vat_type,
    // 'discount' : discount,
    // 'percent' : percent,
    // 'discount_type' : discount_type,
    // 'partial_paid' : partial_paid,
    // 'payment_type' : payment_type,
    // 'payment_status' : payment_status,
    // 'paid_amount' : paid_amount,
    // 'remain_amount' : remain_amount,
    // 'account_id' : account_id,
    // 'account_balance' : account_balance,
    // 'company_id' : company_id,
    // 'platform' : platform,
    // 'reference_number' : reference_number,
    // 'coupon_code' : coupon_code,
    // 'is_manual' : is_manual,
  };
}

class InvoiceDataModel {
  final List<InvoiceModel> invoices;
  final int total;
  final bool last_page;

  InvoiceDataModel({
    required this.invoices,
    required this.total,
    required this.last_page,
  });

  InvoiceDataModel.fromJson(Map json) 
    : invoices = ( json['data'] as List ).map((e) => InvoiceModel.fromJson(e)).toList(),
      total = json['total'], 
      last_page = json['last_page'];

  Map<String, dynamic> toJson() => {
    'invoices' : invoices,
    'total' : total, 
    'last_page' : last_page
  };
}
