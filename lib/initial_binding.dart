import 'package:financial_apps/controllers/category_controller.dart';
import 'package:financial_apps/controllers/history_controller.dart';
import 'package:financial_apps/controllers/search_bar_controller.dart';
import 'package:financial_apps/controllers/total_per_type_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    // Get.lazyPut<CategoryController>(() => CategoryController());
    Get.put<CategoryController>(CategoryController());
    Get.put<SearchBarController>(SearchBarController());
    Get.put<HistoryController>(HistoryController());
    Get.put<TotalPerTypeController>(TotalPerTypeController());
  }
}
