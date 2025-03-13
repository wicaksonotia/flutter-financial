import 'package:financial_apps/controllers/history_controller.dart';
import 'package:financial_apps/pages/transaction/transaction_list.dart';
import 'package:financial_apps/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final HistoryController historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
              color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: MyColors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: MyColors.green,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Income"),
                Tab(text: "Expenses"),
              ],
              onTap: (index) {
                if (index == 1) {
                  historyController.getData('PENGELUARAN');
                } else {
                  historyController.getData('PEMASUKAN');
                }
              },
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    if (historyController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return TransactionList();
                    }
                  }),
                  Obx(() {
                    if (historyController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return TransactionList();
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
