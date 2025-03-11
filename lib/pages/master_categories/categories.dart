import 'package:financial_apps/controllers/category_controller.dart';
import 'package:financial_apps/pages/master_categories/chips.dart';
import 'package:financial_apps/pages/master_categories/list_categories.dart';
import 'package:financial_apps/utils/search_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormCategories extends StatefulWidget {
  const FormCategories({super.key});

  @override
  State<FormCategories> createState() => _FormCategoriesState();
}

class _FormCategoriesState extends State<FormCategories> {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
              color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         Get.defaultDialog(
        //           title: 'Add Categories',
        //           content: Obx(
        //             () => Padding(
        //               padding: const EdgeInsets.all(10.0),
        //               child: Center(
        //                 child: SingleChildScrollView(
        //                   child: Column(
        //                     children: [
        //                       InputDecorator(
        //                         decoration: const InputDecoration(
        //                             border: OutlineInputBorder(),
        //                             labelText: "Category",
        //                             contentPadding:
        //                                 EdgeInsets.fromLTRB(10, 3, 3, 3)),
        //                         child: DropdownButtonHideUnderline(
        //                           child: DropdownButton(
        //                             value: categoryController.tipeContoller.value,
        //                             // items: tipeKategori.map(
        //                             //   (val) {
        //                             //     return DropdownMenuItem<String>(
        //                             //       value: val['id'],
        //                             //       child: Text(val['nama']!),
        //                             //     );
        //                             //   },
        //                             // ).toList(),
        //                             items: dropDownKategori.map(
        //                               (String value) {
        //                                 return DropdownMenuItem(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               },
        //                             ).toList(),
        //                             onChanged: (value) {
        //                               categoryController.tipeContoller.value =
        //                                   value!;
        //                             },
        //                             isExpanded: true,
        //                             style: const TextStyle(
        //                                 fontSize: 17,
        //                                 color: MyColors.darkTextColor),
        //                           ),
        //                         ),
        //                       ),
        //                       const Gap(10),
        //                       TextFormField(
        //                         controller: categoryController.nameController,
        //                         // keyboardType: TextInputType.number,
        //                         decoration: const InputDecoration(
        //                             border: OutlineInputBorder(),
        //                             labelText: "Category Name"),
        //                       ),
        //                       const Gap(10),
        //                       Row(
        //                         children: [
        //                           Expanded(
        //                             child: ElevatedButton(
        //                               style: ElevatedButton.styleFrom(
        //                                 foregroundColor: MyColors.primary,
        //                                 backgroundColor: Colors.white,
        //                                 minimumSize: const Size(0, 45),
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius:
        //                                         BorderRadius.circular(8),
        //                                     side: const BorderSide(
        //                                         color: MyColors.primary)),
        //                               ),
        //                               onPressed: () {
        //                                 Get.back();
        //                               },
        //                               child: const Text(
        //                                 'CANCEL',
        //                               ),
        //                             ),
        //                           ),
        //                           const SizedBox(width: 10),
        //                           Expanded(
        //                             child: ElevatedButton(
        //                               style: ElevatedButton.styleFrom(
        //                                 foregroundColor: const Color(0xFFFFFFFF),
        //                                 backgroundColor: MyColors.primary,
        //                                 minimumSize: const Size(0, 45),
        //                                 shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadius.circular(8),
        //                                 ),
        //                               ),
        //                               onPressed: () {
        //                                 categoryController.insertCategory();
        //                               },
        //                               child: const Text(
        //                                 'SAVE',
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       icon: const Icon(
        //         Icons.add_box,
        //         color: Colors.white,
        //         size: 30,
        //       ),
        //     ),
        //   ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SearchBarContainer(),
          ),
          const Chips(),
          Expanded(
            child: ListCategories(),
          ),
        ],
      ),
    );
  }
}
