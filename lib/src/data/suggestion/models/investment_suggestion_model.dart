import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:paisa/src/data/suggestion/models/investment_product_model.dart';

class InvestmentSuggestionModel {
  final List<InvestmentProductModel> equityMarket;
  final List<InvestmentProductModel> fd;
  final List<InvestmentProductModel> govBonds;
  final List<InvestmentProductModel> mutualFunds;

  InvestmentSuggestionModel({
    required this.equityMarket,
    required this.fd,
    required this.govBonds,
    required this.mutualFunds,
  });

  InvestmentSuggestionModel copyWith({
    List<InvestmentProductModel>? equityMarket,
    List<InvestmentProductModel>? fd,
    List<InvestmentProductModel>? govBonds,
    List<InvestmentProductModel>? mutualFunds,
  }) {
    return InvestmentSuggestionModel(
      equityMarket: equityMarket ?? this.equityMarket,
      fd: fd ?? this.fd,
      govBonds: govBonds ?? this.govBonds,
      mutualFunds: mutualFunds ?? this.mutualFunds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'equity_market': equityMarket.map((x) => x.toMap()).toList(),
      'fd': fd.map((x) => x.toMap()).toList(),
      'gov_bonds': govBonds.map((x) => x.toMap()).toList(),
      'mutual_funds': mutualFunds.map((x) => x.toMap()).toList(),
    };
  }

  factory InvestmentSuggestionModel.fromMap(Map<String, dynamic> map) {
    return InvestmentSuggestionModel(
      equityMarket: List<InvestmentProductModel>.from(
          map['equity_market']?.map((x) => InvestmentProductModel.fromMap(x))),
      fd: List<InvestmentProductModel>.from(
          map['fd']?.map((x) => InvestmentProductModel.fromMap(x))),
      govBonds: List<InvestmentProductModel>.from(
          map['gov_bonds']?.map((x) => InvestmentProductModel.fromMap(x))),
      mutualFunds: List<InvestmentProductModel>.from(
          map['mutual_funds']?.map((x) => InvestmentProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentSuggestionModel.fromJson(String source) =>
      InvestmentSuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InvestmentSuggestionModel(equityMarket: $equityMarket, fd: $fd, govBonds: $govBonds, mutualFunds: $mutualFunds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentSuggestionModel &&
        listEquals(other.equityMarket, equityMarket) &&
        listEquals(other.fd, fd) &&
        listEquals(other.govBonds, govBonds) &&
        listEquals(other.mutualFunds, mutualFunds);
  }

  @override
  int get hashCode {
    return equityMarket.hashCode ^
        fd.hashCode ^
        govBonds.hashCode ^
        mutualFunds.hashCode;
  }
}
