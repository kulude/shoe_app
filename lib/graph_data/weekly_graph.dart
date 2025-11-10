import 'package:flutter/material.dart';
import 'package:shoe_app/graph_data/bar_graph.dart';
import 'package:shoe_app/services/further_shoe_service.dart';
import 'package:shoe_app/services/shoe_service.dart';

class WeeklyGraph extends StatelessWidget {
  final ShoeService shoeService;
  const WeeklyGraph({super.key, required this.shoeService});

  @override
  Widget build(BuildContext context) {
    final eachDaysData = FurtherShoeService(shoeService: shoeService);
    final startOfWeek = eachDaysData.startOfWeek1();
    final monday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 0)),
    );
    final tuesday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 1)),
    );
    final wensday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 2)),
    );
    final thursday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 3)),
    );
    final friday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 4)),
    );
    final sutday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 5)),
    );
    final sunday = eachDaysData.convertDateTimeToString(
      startOfWeek.add(const Duration(days: 6)),
    );
    final data = eachDaysData.graphMapSold;
    final data2 = eachDaysData.graphMapBought();
    return SizedBox(
      height: 280,
      child: MyBarGrahp(
        maxy: 2000,
        mondayAmount: data[monday] ?? 0.0,
        tuesDayAmount: data[tuesday] ?? 0.0,
        wendayAmount: data[wensday] ?? 0.0,
        thursdayAmount: data[thursday] ?? 0.0,
        fridayAmount: data[friday] ?? 0.0,
        satdayAmount: data[sutday] ?? 0.0,
        sundayAmount: data[sunday] ?? 0.0,
        mondayProfit: data2[monday] ?? 0.0,
        tuesDayProfit: data2[tuesday] ?? 0.0,
        wendayProfit: data2[wensday] ?? 0.0,
        thursdayProfit: data2[thursday] ?? 0.0,
        fridayProfit: data2[friday] ?? 0.0,
        satdayProfit: data2[sutday] ?? 0.0,
        sundayProfit: data2[sunday] ?? 0.0,
      ),
    );
  }
}
