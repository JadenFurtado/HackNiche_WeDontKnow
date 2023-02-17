import 'dart:convert';

class InvestmentProductModel {
  final String productName;
  final InvestmentProductMetadataModel productMetadata;
  InvestmentProductModel({
    required this.productName,
    required this.productMetadata,
  });

  InvestmentProductModel copyWith({
    String? productName,
    InvestmentProductMetadataModel? productMetadata,
  }) {
    return InvestmentProductModel(
      productName: productName ?? this.productName,
      productMetadata: productMetadata ?? this.productMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'product_metadata': productMetadata.toMap(),
    };
  }

  factory InvestmentProductModel.fromMap(Map<String, dynamic> map) {
    return InvestmentProductModel(
      productName: map['product_name'] ?? '',
      productMetadata:
          InvestmentProductMetadataModel.fromMap(map['product_metadata']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentProductModel.fromJson(String source) =>
      InvestmentProductModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'InvestmentProductModel(productName: $productName, productMetadata: $productMetadata)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentProductModel &&
        other.productName == productName &&
        other.productMetadata == productMetadata;
  }

  @override
  int get hashCode => productName.hashCode ^ productMetadata.hashCode;
}

class InvestmentProductMetadataModel {
  final String creditRating;
  final double cost;
  final int quantity;
  InvestmentProductMetadataModel({
    required this.creditRating,
    required this.cost,
    required this.quantity,
  });

  InvestmentProductMetadataModel copyWith({
    String? creditRating,
    double? cost,
    int? quantity,
  }) {
    return InvestmentProductMetadataModel(
      creditRating: creditRating ?? this.creditRating,
      cost: cost ?? this.cost,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'credit_rating': creditRating,
      'cost': cost,
      'quantity': quantity,
    };
  }

  factory InvestmentProductMetadataModel.fromMap(Map<String, dynamic> map) {
    return InvestmentProductMetadataModel(
      creditRating: map['credit_rating'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentProductMetadataModel.fromJson(String source) =>
      InvestmentProductMetadataModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'InvestmentProductMetadataModel(creditRating: $creditRating, cost: $cost, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentProductMetadataModel &&
        other.creditRating == creditRating &&
        other.cost == cost &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => creditRating.hashCode ^ cost.hashCode ^ quantity.hashCode;
}
