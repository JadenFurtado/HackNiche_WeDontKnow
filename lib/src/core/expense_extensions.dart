import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../data/expense/model/expense.dart';
import 'common.dart';
import 'enum/filter_budget.dart';
import 'enum/transaction.dart';

extension ExpenseListMapping on Box<Expense> {
  List<Expense> get expenses =>
      values.toList()..sort(((a, b) => b.time.compareTo(a.time)));

  List<Expense> allAccount(int accountId) =>
      expenses.where((element) => element.accountId == accountId).toList();

  List<Expense> get budgetOverView =>
      values.where((element) => element.type != TransactionType.income).toList()
        ..sort((a, b) => b.time.compareTo(a.time));

  List<Expense> isFilterTimeBetween(DateTimeRange range) =>
      values.where((element) => element.time.isAfterBeforeTime(range)).toList();
}

extension TotalAmountOnExpenses on Iterable<Expense> {
  List<Expense> get expenses =>
      toList()..sort(((a, b) => b.time.compareTo(a.time)));

  List<Expense> get investmentList =>
      where((element) => element.type == TransactionType.investment).toList();

  List<Expense> get expenseList =>
      where((element) => element.type == TransactionType.expense).toList();

  List<Expense> get incomeList =>
      where((element) => element.type == TransactionType.income).toList();

  String get balance => (totalIncome - totalExpense).toCurrency();

  List<Expense> isFilterTimeBetween(DateTimeRange range) =>
      where((element) => element.time.isAfterBeforeTime(range)).toList();

  double get filterTotal => fold<double>(0, (previousValue, element) {
        if ({TransactionType.expense, TransactionType.investment}
            .contains(element.type)) {
          return previousValue - element.currency;
        } else {
          return previousValue + element.currency;
        }
      });
  double get fullTotal => totalIncome - totalExpense - totalInvestment;
  double get totalExpense =>
      where((element) => element.type == TransactionType.expense)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get totalInvestment =>
      where((element) => element.type == TransactionType.investment)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get totalIncome =>
      where((element) => element.type == TransactionType.income)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get total => map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get thisMonthExpense => where((element) => {
            TransactionType.expense,
            TransactionType.investment
          }.contains(element.type))
      .where((element) => element.time.month == DateTime.now().month)
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get thisMonthIncome =>
      where((element) => element.type == TransactionType.income)
          .where((element) => element.time.month == DateTime.now().month)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  List<MapEntry<String, List<Expense>>> groupByTime(FilterBudget filterBudget) {
    return groupBy(
            this, (Expense element) => element.time.formatted(filterBudget))
        .entries
        .toList();
  }

  double expensesByAccount(int accountId) =>
      where((element) => element.accountId == accountId).filterTotal;
}
