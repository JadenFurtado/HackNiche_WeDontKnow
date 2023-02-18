import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'investment_suggestion_model.dart';

class InvestmentCollectionModel {
  final Map<String, dynamic> pieChart;
  final InvestmentSuggestionModel products;
  InvestmentCollectionModel({
    required this.pieChart,
    required this.products,
  });

  InvestmentCollectionModel copyWith({
    Map<String, dynamic>? pieChart,
    InvestmentSuggestionModel? products,
  }) {
    return InvestmentCollectionModel(
      pieChart: pieChart ?? this.pieChart,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pie_chart': pieChart,
      'products': products.toMap(),
    };
  }

  factory InvestmentCollectionModel.fromMap(Map<String, dynamic> map) {
    return InvestmentCollectionModel(
      pieChart: Map<String, dynamic>.from(map['pie_chart']),
      products: InvestmentSuggestionModel.fromMap(map['products']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentCollectionModel.fromJson(String source) =>
      InvestmentCollectionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'InvestmentCollectionModel(pieChart: $pieChart, products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentCollectionModel &&
        mapEquals(other.pieChart, pieChart) &&
        other.products == products;
  }

  @override
  int get hashCode => pieChart.hashCode ^ products.hashCode;
}
