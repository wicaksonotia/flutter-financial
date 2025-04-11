import 'package:financial_apps/controllers/history_controller.dart';
import 'package:financial_apps/database/api_request.dart';
import 'package:financial_apps/models/category_model.dart';
import 'package:financial_apps/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  HistoryController _historyController = Get.find<HistoryController>();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var selectTransactionExpenseDate = DateTime.now().obs;
  var selectTransactionExpenseTime = TimeOfDay.now().obs;
  var selectTransactionIncomeDate = DateTime.now().obs;
  var selectTransactionIncomeTime = TimeOfDay.now().obs;
  var dataCategoryExpenseId = 0.obs;
  var dataCategoryExpenseName = ''.obs;
  var dataCategoryExpenseFromId = 0.obs;
  var dataCategoryExpenseFromName = ''.obs;
  var dataCategoryIncomeId = 0.obs;
  var dataCategoryIncomeName = ''.obs;
  RxBool isLoading = false.obs;
  var resultDataIncome = <CategoryModel>[].obs;
  var resultDataExpense = <CategoryModel>[].obs;
  var resultDataExpenseFrom = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getListDataIncome();
    getListDataExpense();
    getListDataExpenseFrom();
  }

  void getListDataIncome() async {
    try {
      isLoading(true);
      final result = await RemoteDataSource.listCategories(['PEMASUKAN'], '');
      if (result != null) {
        resultDataIncome.assignAll(result);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  void getListDataExpenseFrom() async {
    try {
      isLoading(true);
      final result = await RemoteDataSource.listCategories(['PEMASUKAN'], '');
      if (result != null) {
        resultDataExpenseFrom.assignAll(result);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  void getListDataExpense() async {
    try {
      isLoading(true);
      final result = await RemoteDataSource.listCategories(['PENGELUARAN'], '');
      if (result != null) {
        resultDataExpense.assignAll(result);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isBefore(DateTime.now().add(const Duration(days: 0))))) {
      return true;
    }
    return false;
  }

  // ==========================
  // EXPENSE
  // ==========================
  void showDialogDatePickerExpense() async {
    var pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectTransactionExpenseDate.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Transaction Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Transaction Date',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.green,
              onPrimary: Colors.white,
              outlineVariant: Colors.grey.shade200,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null &&
        pickedDate != selectTransactionExpenseDate.value) {
      selectTransactionExpenseDate.value = pickedDate;
    }
  }

  void showDialogTimePickerExpense() async {
    var pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectTransactionExpenseTime.value,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.green,
              onPrimary: Colors.white,
              tertiary:
                  MyColors.green, // Background color for am/pm when selected
              onSurfaceVariant: Colors.black, // Text color for am/pm
              onTertiary: Colors.white, // Text color for am/pm when selected
              onPrimaryContainer: Colors
                  .white, // Text color for hours and minutes when selected
              outline: Colors.grey.shade300, // outline color for am/pm
              surface: Colors.black, // Text color
              // onSurface: Colors.yellow,
              surfaceContainerHigh: Colors.white, // Background color
              surfaceContainerHighest: Colors.grey.shade100, // Background clock
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null &&
        pickedTime != selectTransactionExpenseTime.value) {
      selectTransactionExpenseTime.value = pickedTime;
    }
  }

  void saveTransactionExpense() async {
    if (dataCategoryExpenseFromId.value == 0) {
      Get.snackbar('Error', 'Please select category',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else if (dataCategoryExpenseId.value == 0) {
      Get.snackbar('Error', 'Please select category',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else if (amountController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter amount',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else if (descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter description',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else {
      isLoading(true);
      try {
        final result = await RemoteDataSource.saveTransactionExpense(
          dataCategoryExpenseFromId.value,
          dataCategoryExpenseId.value,
          dataCategoryExpenseFromName.value,
          dataCategoryExpenseName.value,
          int.parse(amountController.text.replaceAll(RegExp('[^0-9]'), '')),
          descriptionController.text,
          selectTransactionExpenseDate.value.toString(),
          DateFormat('HH:mm:ss').format(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              selectTransactionExpenseTime.value.hour,
              selectTransactionExpenseTime.value.minute,
            ),
          ),
        );
        if (result) {
          Get.snackbar('Success', 'Transaction added successfully',
              icon: const Icon(Icons.check), snackPosition: SnackPosition.TOP);
          _historyController.getDataByFilter();
        }
      } catch (error) {
        Get.snackbar('Error', error.toString(),
            icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      } finally {
        isLoading(false);
      }
      amountController.clear();
      descriptionController.clear();
      dataCategoryExpenseFromId.value = 0;
      dataCategoryExpenseFromName.value = '';
      dataCategoryExpenseId.value = 0;
      dataCategoryExpenseName.value = '';
      selectTransactionExpenseDate.value = DateTime.now();
      selectTransactionExpenseTime.value = TimeOfDay.now();
    }
  }

  // ==========================
  // INCOME
  // ==========================
  void showDialogDatePickerIncome() async {
    var pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectTransactionIncomeDate.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Transaction Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Transaction Date',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.green,
              onPrimary: Colors.white,
              outlineVariant: Colors.grey.shade200,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectTransactionIncomeDate.value) {
      selectTransactionIncomeDate.value = pickedDate;
    }
  }

  void showDialogTimePickerIncome() async {
    var pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectTransactionIncomeTime.value,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.green,
              onPrimary: Colors.white,
              tertiary:
                  MyColors.green, // Background color for am/pm when selected
              onSurfaceVariant: Colors.black, // Text color for am/pm
              onTertiary: Colors.white, // Text color for am/pm when selected
              onPrimaryContainer: Colors
                  .white, // Text color for hours and minutes when selected
              outline: Colors.grey.shade300, // outline color for am/pm
              surface: Colors.black, // Text color
              // onSurface: Colors.yellow,
              surfaceContainerHigh: Colors.white, // Background color
              surfaceContainerHighest: Colors.grey.shade100, // Background clock
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectTransactionIncomeTime.value) {
      selectTransactionIncomeTime.value = pickedTime;
    }
  }

  void saveTransactionIncome() async {
    if (dataCategoryIncomeId.value == 0) {
      Get.snackbar('Error', 'Please select category',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else if (amountController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter amount',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else if (descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter description',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
    } else {
      isLoading(true);
      try {
        final result = await RemoteDataSource.saveTransactionIncome(
          dataCategoryIncomeId.value,
          dataCategoryIncomeName.value,
          int.parse(amountController.text.replaceAll(RegExp('[^0-9]'), '')),
          descriptionController.text,
          selectTransactionIncomeDate.value.toString(),
          DateFormat('HH:mm:ss').format(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              selectTransactionIncomeTime.value.hour,
              selectTransactionIncomeTime.value.minute,
            ),
          ),
        );
        if (result) {
          Get.snackbar('Success', 'Transaction added successfully',
              icon: const Icon(Icons.check), snackPosition: SnackPosition.TOP);
        }
      } catch (error) {
        Get.snackbar('Error', error.toString(),
            icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      } finally {
        isLoading(false);
      }
      amountController.clear();
      descriptionController.clear();
      dataCategoryIncomeId.value = 0;
      dataCategoryIncomeName.value = '';
      selectTransactionIncomeDate.value = DateTime.now();
      selectTransactionIncomeTime.value = TimeOfDay.now();
    }
  }
}
