class Unit {
  final int coefficient;
  final String description;
  final int? id;
  final bool isDefault;
  final int salePrice;
  final int purchasePrice;
  final String unit;

  Unit({
    required this.coefficient,
    required this.description,
    required this.id,
    required this.isDefault,
    required this.salePrice,
    required this.purchasePrice,
    required this.unit,
  });

  Unit.fromJson(Map json)
      : coefficient = json['coefficient'],
        description = json['description'],
        id = json['id'],
        isDefault = json['isDefault'],
        salePrice = json['salePrice'],
        purchasePrice = json['purchasePrice'],
        unit = json['unit'];

  Map<String, dynamic> toJson() => {
        'coefficient': coefficient,
        'description': description,
        'id': id,
        'isDefault': isDefault,
        'salePrice': salePrice,
        'purchasePrice': purchasePrice,
        'unit': unit,
      };
}
