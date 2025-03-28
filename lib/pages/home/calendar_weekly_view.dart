import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:financial_apps/controllers/history_controller.dart';
import 'package:financial_apps/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CalendarWeeklyView extends StatefulWidget {
  const CalendarWeeklyView({super.key});

  @override
  State<CalendarWeeklyView> createState() => _CalendarWeeklyViewState();
}

class _CalendarWeeklyViewState extends State<CalendarWeeklyView> {
  // int? groupValue = 0;
  final HistoryController historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    // Widget calendarBox(BuildContext context) {
    //   return SizedBox(
    //     height: MediaQuery.of(context).size.height * 0.1,
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     child: Container(
    //         alignment: Alignment.center,
    //         child: CupertinoSlidingSegmentedControl<int>(
    //             backgroundColor: Colors.transparent,
    //             thumbColor: Colors.greenAccent,
    //             padding: const EdgeInsets.all(5),
    //             groupValue: groupValue,
    //             children: {
    //               0: Text('a'),
    //               1: Text('a'),
    //               2: Text('a'),
    //               3: Text('a'),
    //               4: Text('a'),
    //             },
    //             onValueChanged: (value) {
    //               setState(() {
    //                 groupValue = value;
    //                 print(groupValue);
    //               });
    //             })),
    //   );
    // }

    return Column(
      children: [
        // calendarBox(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last Week's Transaction",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              // Row(
              //   children: [
              //     Text(
              //       CurrencyFormat.convertToIdr(10000, 0),
              //       style: TextStyle(
              //           color: Colors.grey[700], fontWeight: FontWeight.w500),
              //     ),
              //     const Icon(
              //       Icons.arrow_forward_ios,
              //       size: 12,
              //     )
              //   ],
              // )
            ],
          ),
        ),
        const Gap(15),
        CalendarAppBar(
          accent: Colors.transparent,
          white: MyColors.primary,
          backButton: false,
          onDateChanged: (value) {
            // historyController.singleDate.value = value;
            // DateTime date = DateTime(
            //     value.year,
            //     value.month,
            //     value.day);
            // var convertedDateBackToInt = date.millisecondsSinceEpoch;
            historyController.getDataSingleDate(value);
          },
          firstDate: DateTime.now().subtract(const Duration(days: 366)),
          lastDate: DateTime.now(),
        ),
      ],
    );
  }
}
