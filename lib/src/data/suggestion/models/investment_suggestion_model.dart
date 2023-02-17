import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:paisa/src/data/suggestion/models/investment_product_model.dart';

class InvestmentSuggestionModel {
  final List<InvestmentProductModel> debt;
  final List<InvestmentProductModel> equityMarket;
  final List<InvestmentProductModel> fd;
  final List<InvestmentProductModel> govBonds;
  final List<InvestmentProductModel> mutualFunds;
  final List<InvestmentProductModel> ppf;

  const InvestmentSuggestionModel({
    required this.debt,
    required this.equityMarket,
    required this.fd,
    required this.govBonds,
    required this.mutualFunds,
    required this.ppf,
  });

  InvestmentSuggestionModel copyWith({
    List<InvestmentProductModel>? debt,
    List<InvestmentProductModel>? equityMarket,
    List<InvestmentProductModel>? fd,
    List<InvestmentProductModel>? govBonds,
    List<InvestmentProductModel>? mutualFunds,
    List<InvestmentProductModel>? ppf,
  }) {
    return InvestmentSuggestionModel(
      debt: debt ?? this.debt,
      equityMarket: equityMarket ?? this.equityMarket,
      fd: fd ?? this.fd,
      govBonds: govBonds ?? this.govBonds,
      mutualFunds: mutualFunds ?? this.mutualFunds,
      ppf: ppf ?? this.ppf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'debt': debt.map((x) => x.toMap()).toList(),
      'equity_market': equityMarket.map((x) => x.toMap()).toList(),
      'fd': fd.map((x) => x.toMap()).toList(),
      'gov_bonds': govBonds.map((x) => x.toMap()).toList(),
      'mutual_funds': mutualFunds.map((x) => x.toMap()).toList(),
      'ppf': ppf.map((x) => x.toMap()).toList(),
    };
  }

  factory InvestmentSuggestionModel.fromMap(Map<String, dynamic> map) {
    return InvestmentSuggestionModel(
      debt: List<InvestmentProductModel>.from(
          map['debt']?.map((x) => InvestmentProductModel.fromMap(x))),
      equityMarket: List<InvestmentProductModel>.from(
          map['equity_market']?.map((x) => InvestmentProductModel.fromMap(x))),
      fd: List<InvestmentProductModel>.from(
          map['fd']?.map((x) => InvestmentProductModel.fromMap(x))),
      govBonds: List<InvestmentProductModel>.from(
          map['gov_bonds']?.map((x) => InvestmentProductModel.fromMap(x))),
      mutualFunds: List<InvestmentProductModel>.from(
          map['mutual_funds']?.map((x) => InvestmentProductModel.fromMap(x))),
      ppf: List<InvestmentProductModel>.from(
          map['ppf']?.map((x) => InvestmentProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentSuggestionModel.fromJson(String source) =>
      InvestmentSuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InvestmentSuggestionModel(debt: $debt, equity_market: $equityMarket, fd: $fd, gov_bonds: $govBonds, mutual_funds: $mutualFunds, ppf: $ppf)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentSuggestionModel &&
        listEquals(other.debt, debt) &&
        listEquals(other.equityMarket, equityMarket) &&
        listEquals(other.fd, fd) &&
        listEquals(other.govBonds, govBonds) &&
        listEquals(other.mutualFunds, mutualFunds) &&
        listEquals(other.ppf, ppf);
  }

  @override
  int get hashCode {
    return debt.hashCode ^
        equityMarket.hashCode ^
        fd.hashCode ^
        govBonds.hashCode ^
        mutualFunds.hashCode ^
        ppf.hashCode;
  }
}
