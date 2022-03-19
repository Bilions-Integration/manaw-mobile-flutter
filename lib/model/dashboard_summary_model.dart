class DashboardSummaryModel {
  double revenue;
  double expense;
  double assets;
  double liability;
  double dividends;
  double saleTax;
  double wht;
  double accountPayable;
  double purchaseTax;

  DashboardSummaryModel({
    required this.revenue,
    required this.expense,
    required this.assets,
    required this.liability,
    required this.dividends,
    required this.saleTax,
    required this.wht,
    required this.accountPayable,
    required this.purchaseTax,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      revenue: double.parse(json['revenue'].toString()),
      expense: double.parse(json['expense'].toString()),
      assets: double.parse(json['assets'].toString()),
      liability: double.parse(json['liability'].toString()),
      dividends: double.parse(json['dividends'].toString()),
      saleTax: double.parse(json['sale_tax'].toString()),
      wht: double.parse(json['wht'].toString()),
      accountPayable: double.parse(json['account_payable'].toString()),
      purchaseTax: double.parse(json['purchase_tax'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'revenue': revenue,
        'expense': expense,
        'assets': assets,
        'liability': liability,
        'dividends': dividends,
        'sale_tax': saleTax,
        'wht': wht,
        'account_payable': accountPayable,
        'purchase_tax': purchaseTax,
      };
}
