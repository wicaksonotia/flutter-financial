import 'package:financial_apps/controllers/history_controller.dart';
import 'package:financial_apps/controllers/total_per_type_controller.dart';
import 'package:financial_apps/pages/home/calendar_weekly_view.dart';
import 'package:financial_apps/pages/home/header.dart';
import 'package:financial_apps/pages/home/planning_ahead.dart';
import 'package:financial_apps/pages/home/transaction_list.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TotalPerTypeController totalPerTypeController =
      Get.find<TotalPerTypeController>();
  final HistoryController historyController = Get.find<HistoryController>();

  Future<void> _refresh() async {
    totalPerTypeController.getTotal();
    totalPerTypeController.getTotalPerType();
    historyController.getDataByFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey[50], // Set background color
          ),
          RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              children: const [
                Header(),
                Gap(15),
                PlanningAhead(),
                Gap(15),
                CalendarWeeklyView(),
                SizedBox(
                  height: 260,
                  child: TransactionList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
