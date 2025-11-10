import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/modals/graph_modal/bar_data.dart';

class MyBarGrahp extends StatelessWidget {
  final double maxy;
  final double mondayAmount;
  final double tuesDayAmount;
  final double wendayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double satdayAmount;
  final double sundayAmount;
  final double mondayProfit;
  final double tuesDayProfit;
  final double wendayProfit;
  final double thursdayProfit;
  final double fridayProfit;
  final double satdayProfit;
  final double sundayProfit;
  const MyBarGrahp({
    super.key,
    required this.maxy,
    required this.mondayAmount,
    required this.tuesDayAmount,
    required this.wendayAmount,
    required this.thursdayAmount,
    required this.fridayAmount,
    required this.satdayAmount,
    required this.sundayAmount,
    required this.mondayProfit,
    required this.tuesDayProfit,
    required this.wendayProfit,
    required this.thursdayProfit,
    required this.fridayProfit,
    required this.satdayProfit,
    required this.sundayProfit,
  });

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      mondayAmount: mondayAmount,
      tuesDayAmount: tuesDayAmount,
      wendayAmount: wendayAmount,
      thursdayAmount: thursdayAmount,
      fridayAmount: fridayAmount,
      satdayAmount: satdayAmount,
      sundayAmount: sundayAmount,
      mondayProfit: mondayProfit,
      tuesDayProfit: tuesDayProfit,
      wendayProfit: wendayProfit,
      thursdayProfit: thursdayProfit,
      fridayProfit: fridayAmount,
      satdayProfit: satdayProfit,
      sundayProfit: sundayProfit,
    );

    barData.initializeTheBars();
    return BarChart(
      BarChartData(
        maxY: maxy,
        minY: 0,
        alignment: BarChartAlignment.spaceEvenly,
        backgroundColor: Colors.brown[250],
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getTitleWidget,
            ),
          ),
        ),
        barGroups: barData.individualProfitBars
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxy,
                      color: Colors.grey[100],
                    ),
                  ),
                  BarChartRodData(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxy,
                      color: Colors.grey[200],
                    ),
                    toY: data.y2,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 0, 0),
    );

    List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thur',
      'Fri',
      'Sat',
      'Sun',
    ];

    int index = value.toInt();
    Widget text = (index >= 0 && index < daysOfWeek.length)
        ? Text(daysOfWeek[index], style: style)
        : SizedBox.shrink();

    // switch (value.toInt()) {
    //   case 0:
    //     text = const Text('mon', style: style);
    //     break;
    //   case 1:
    //     text = const Text('Tue', style: style);
    //     break;
    //   case 2:
    //     text = const Text('Wed', style: style);
    //     break;
    //   case 3:
    //     text = const Text('Thur', style: style);
    //     break;
    //   case 4:
    //     text = const Text('Fri', style: style);
    //     break;
    //   case 5:
    //     text = const Text('Sat', style: style);
    //     break;
    //   case 6:
    //     text = const Text('Sun', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    // }
    return SideTitleWidget(meta: meta, child: text);
  }
}
