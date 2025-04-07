import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:financial_apps/controllers/transaction_controller.dart';
import 'package:financial_apps/utils/colors.dart';
import 'package:financial_apps/utils/routes.dart';
import 'package:financial_apps/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormExpense extends StatefulWidget {
  const FormExpense({super.key});

  @override
  State<FormExpense> createState() => _FormExpenseState();
}

class _FormExpenseState extends State<FormExpense> {
  final TransactionController _transactionController =
      Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(RouterClass.expensefrom);
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      _transactionController
                              .dataCategoryExpenseFromName.value.isNotEmpty
                          ? _transactionController
                              .dataCategoryExpenseFromName.value
                          : 'Expense from',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black54),
                ],
              ),
            ),
          ),
          const Gap(10),
          InkWell(
            onTap: () {
              Get.toNamed(RouterClass.expense);
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      _transactionController
                              .dataCategoryExpenseName.value.isNotEmpty
                          ? _transactionController.dataCategoryExpenseName.value
                          : 'Category Item',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black54),
                ],
              ),
            ),
          ),
          const Gap(10),
          TextFormField(
            controller: _transactionController.amountController,
            inputFormatters: [
              CurrencyTextInputFormatter.currency(
                locale: 'id',
                decimalDigits: 0,
                symbol: 'Rp.',
              )
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const Gap(10),
          TextFormField(
            controller: _transactionController.descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .55,
                child: Obx(
                  () => TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today,
                          color: Colors.black54),
                    ),
                    onTap: () {
                      _transactionController.showDialogDatePickerExpense();
                    },
                    controller: TextEditingController(
                      text: DateFormat('dd MMMM yyyy').format(
                        _transactionController
                            .selectTransactionExpenseDate.value,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: MySizes.fontSizeMd,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: Obx(
                  () => TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      suffixIcon:
                          const Icon(Icons.access_time, color: Colors.black54),
                    ),
                    onTap: () {
                      _transactionController.showDialogTimePickerExpense();
                    },
                    controller: TextEditingController(
                      text: DateFormat('HH:mm').format(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          _transactionController
                              .selectTransactionExpenseTime.value.hour,
                          _transactionController
                              .selectTransactionExpenseTime.value.minute,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: MySizes.fontSizeMd,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _transactionController.saveTransactionExpense();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.red, // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: MySizes.fontSizeMd,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
