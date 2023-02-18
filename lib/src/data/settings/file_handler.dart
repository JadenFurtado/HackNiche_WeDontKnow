import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/enum/box_types.dart';
import '../../service_locator.dart';
import '../accounts/data_sources/account_local_data_source.dart';
import '../accounts/model/account.dart';
import '../category/data_sources/category_local_data_source.dart';
import '../category/model/category.dart';
import '../expense/data_sources/expense_manager_local_data_source.dart';
import '../expense/model/expense.dart';
import 'data.dart';

class FileHandler {
  Future<String> fetchExpensesAndEncode() async {
    final expenseDataStore =
        await locator.getAsync<LocalExpenseManagerDataSource>();
    final Iterable<Expense> expenses = await expenseDataStore.exportData();

    final accountDataStore =
        await locator.getAsync<LocalAccountManagerDataSource>();

    final categoryDataStore =
        await locator.getAsync<LocalCategoryManagerDataSource>();

    return const ListToCsvConverter().convert(
      csvDataList(
        expenses.toList(),
        accountDataStore,
        categoryDataStore,
      ),
    );
  }

  List<List<String>> csvDataList(
    List<Expense> expenses,
    LocalAccountManagerDataSource accountDataSource,
    LocalCategoryManagerDataSource categoryDataSource,
  ) =>
      [
        [
          'No',
          'Transaction',
          'Amount',
          'Date',
          'Category Name',
          'Category Description',
          'Account Name',
          'Bank Name',
          'Account Type',
        ],
        ...List.generate(
          expenses.length,
          (index) {
            final expense = expenses[index];
            final account = accountDataSource.fetchAccount(expense.accountId);
            final category =
                categoryDataSource.fetchCategory(expense.categoryId);
            return expenseRow(
              index,
              expense: expense,
              account: account,
              category: category,
            );
          },
        ),
      ];

  List<String> expenseRow(
    int index, {
    required Expense expense,
    required Account account,
    required Category category,
  }) =>
      [
        '$index',
        expense.name,
        '${expense.currency}',
        expense.time.toIso8601String(),
        category.name,
        category.description ?? '',
        account.name,
        account.bankName,
        account.cardType!.name,
      ];

  Future<void> createBackUpFile(Function(String) callback) async {
    final result = await _checkPermission();
    if (!result) {
      return callback.call('Permission error');
    }

    final String data = await fetchExpensesAndEncode();
    final directory = await getExternalStorageDirectory();
    final dir = await Directory(directory!.path).create(recursive: true);
    final file = File('${dir.path}/${DateTime.now().toIso8601String()}.json');
    await file.writeAsString(data);
    callback.call('Creating backup');
  }

  Future<void> restoreBackUpFile({
    FileSystemEntity? fileSystemEntity,
  }) async {
    final result = await _checkPermission();
    if (!result) {
      return;
    }

    File? file;
    if (fileSystemEntity != null) {
      file = File(fileSystemEntity.path);
    } else {
      file = await _pickJSONFile();
    }
    if (file != null) {
      final jsonString = await file.readAsString();
      final data = Data.fromRawJson(jsonString);
      final accountBox = Hive.box<Account>(BoxType.accounts.name);
      final categoryBox = Hive.box<Category>(BoxType.category.name);
      final expenseBox = Hive.box<Expense>(BoxType.expense.name);
      await expenseBox.clear();
      await categoryBox.clear();
      await accountBox.clear();

      await expenseBox.addAll(data.expenses);
      await categoryBox.addAll(data.categories);
      await accountBox.addAll(data.accounts);
    }
  }

  Future<File?> _pickJSONFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<bool> _checkPermission() async {
    final result = await Permission.manageExternalStorage.status;
    if (result.isGranted) {
      return true;
    } else if (result.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    return false;
  }
}
