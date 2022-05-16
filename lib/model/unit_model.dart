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
        isDefault = json['is_default'],
        salePrice = json['sale_price'],
        purchasePrice = json['purchase_price'],
        unit = json['unit'];

  Map<String, dynamic> toJson() => {
        'coefficient': coefficient,
        'description': description,
        'id': id,
        'is_default': isDefault,
        'sale_price': salePrice,
        'purchase_price': purchasePrice,
        'unit': unit,
      };
}
