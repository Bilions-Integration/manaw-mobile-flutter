import 'account_model.dart';

class AccountDataModel {
  List<AccountModel>? data;

  AccountDataModel({this.data});

  factory AccountDataModel.fromJson(Map json) => AccountDataModel(
    data: (json['data'] as List).map((e) => AccountModel.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'data': data,
  };
}
