class PlanModel {
  final String name;
  final Map<String, int> prices;
  final String currency;
  final String image;
  List<String>? planDetails;

  PlanModel(
      {required this.name,
      required this.prices,
      required this.currency,
      required this.image,
      this.planDetails});

  void addDetails(List<String> details) {
    planDetails = details;
  }
}
