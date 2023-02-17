import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../common.dart';
import '../theme/custom_color.dart';

part 'transaction.g.dart';

@HiveType(typeId: 11)
enum TransactionType {
  @HiveField(1)
  expense('expense'),
  @HiveField(0)
  income('income'),
  @HiveField(2)
  investment('investment');
  /*  @HiveField(2)
  transfer */

  final String type;
  const TransactionType(this.type);

  String get sign {
    switch (this) {
      case TransactionType.expense:
        return '-';
      case TransactionType.income:
        return '+';
      case TransactionType.investment:
        return '△';
    }
  }

  Color? color(BuildContext context) {
    switch (this) {
      case TransactionType.expense:
        return Theme.of(context).extension<CustomColors>()!.red;
      case TransactionType.income:
        return Theme.of(context).extension<CustomColors>()!.green;
      case TransactionType.investment:
        return Theme.of(context).extension<CustomColors>()!.blue;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case TransactionType.income:
        return context.loc.incomeLabel;
      case TransactionType.expense:
        return context.loc.expenseLabel;
      case TransactionType.investment:
        return "Investment";
      /* case TransactionType.transfer:
       return context.loc.transferLabel; */
    }
  }

  String hintName(BuildContext context) {
    switch (this) {
      case TransactionType.income:
        return context.loc.incomeNameLabel;
      case TransactionType.expense:
        return context.loc.expenseNameLabel;
      case TransactionType.investment:
        return "Investment Name";
      /*  case TransactionType.transfer:
       return context.loc.transferNameLabel; */
    }
  }
}

extension TransactionMap on String {
  TransactionType get type {
    switch (this) {
      case 'expense':
        return TransactionType.expense;
      case 'income':
        return TransactionType.income;
      /* case 'transfer':
        return TransactionType.transfer; */
    }
    return TransactionType.expense;
  }
}
