import 'package:chips_choice/chips_choice.dart';
import 'package:financial_apps/controllers/category_controller.dart';
import 'package:financial_apps/utils/colors.dart';
import 'package:financial_apps/utils/lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chips extends StatefulWidget {
  const Chips({super.key});

  @override
  _ChipsState createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  final CategoryController categoryController = Get.find<CategoryController>();
  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    return ChipsChoice.multiple(
      value: tags,
      onChanged: (val) => setState(() {
        tags = val;
        categoryController.tags.value = val;
        categoryController.getData(val);
      }),
      choiceItems: C2Choice.listFrom<String, Map<String, String>>(
        source: tipeKategori,
        value: (i, v) => v['value']!,
        label: (i, v) => v['nama']!,
      ),
      choiceStyle: C2ChoiceStyle(
        showCheckmark: true,
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(5),
      ),
      choiceActiveStyle: const C2ChoiceStyle(
        color: MyColors.green,
      ),
    );
  }
}
