import 'package:financial_apps/database/api_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_apps/models/history_model.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  var resultData = <DataHistory>[].obs;
  var resultDataSingleDate = <DataHistory>[].obs;
  RxBool isLoading = false.obs;
  RxList<dynamic> tags = [].obs;
  var singleDate = DateTime.now().obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var textSingleDate = ''.obs;
  var textStartDate = ''.obs;
  var textEndDate = ''.obs;
  var checkSingleDate = true.obs;

  @override
  void onInit() {
    super.onInit();
    getDataByDate();
  }

  void getDataSingleDate(selectedDate) async {
    try {
      isLoading(true);
      final result = await RemoteDataSource.historyByDate(
        startDate.value,
        endDate.value,
        selectedDate,
        true,
        ["PEMASUKAN", "PENGELUARAN"],
      );
      if (result != null && result.data != null) {
        resultDataSingleDate.assignAll(result.data!);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  void getDataByDate() async {
    try {
      isLoading(true);
      final result = await RemoteDataSource.historyByDate(
        startDate.value,
        endDate.value,
        singleDate.value,
        checkSingleDate.value,
        tags,
      );
      if (result != null && result.data != null) {
        resultData.assignAll(result.data!);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.TOP);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  /// ===================================
  /// FILTER DATE
  /// ===================================
  bool disableDate(DateTime day) {
    if ((day.isBefore(DateTime.now().add(const Duration(days: 0))))) {
      return true;
    }
    return false;
  }

  chooseDate(singleOrstartOrend) async {
    var initialDate = DateTime.now();
    if (singleOrstartOrend == 'single') {
      initialDate = singleDate.value;
    } else if (singleOrstartOrend == 'start') {
      initialDate = startDate.value;
    } else {
      initialDate = endDate.value;
    }
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
    );
    if (pickedDate != null) {
      if (singleOrstartOrend == 'single') {
        if (pickedDate != singleDate.value) {
          singleDate.value = pickedDate;
          textSingleDate.value =
              DateFormat('dd MMMM yyyy').format(singleDate.value);
        }
      } else if (singleOrstartOrend == 'start') {
        if (pickedDate != startDate.value) {
          startDate.value = pickedDate;
          textStartDate.value =
              DateFormat('dd MMMM yyyy').format(startDate.value);
        }
      } else {
        if (pickedDate != endDate.value) {
          endDate.value = pickedDate;
          textEndDate.value = DateFormat('dd MMMM yyyy').format(endDate.value);
        }
      }
    }
  }
}
