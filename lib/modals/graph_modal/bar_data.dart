import 'package:shoe_app/modals/graph_modal/graph_coordinates.dart';

class BarData {
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
  BarData({
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

  List<GraphCoordinates> individualProfitBars = [];

  void initializeTheBars() {
    individualProfitBars = [
      GraphCoordinates(x: 0, y: mondayAmount, y2: mondayProfit),
      GraphCoordinates(x: 1, y: tuesDayAmount, y2: tuesDayProfit),
      GraphCoordinates(x: 2, y: wendayAmount, y2: wendayProfit),
      GraphCoordinates(x: 3, y: thursdayAmount, y2: thursdayProfit),
      GraphCoordinates(x: 4, y: fridayAmount, y2: fridayProfit),
      GraphCoordinates(x: 5, y: satdayAmount, y2: satdayProfit),
      GraphCoordinates(x: 6, y: sundayAmount, y2: sundayProfit),
    ];
  }

  //index can be 0, 7 ,14, 21 etc
  // List<GraphCoordinates> toWeeks(int index) {
  //   List<GraphCoordinates> allList = [
  //     GraphCoordinates(x: index, y: mondayAmount, y2: mondayProfit),
  //     GraphCoordinates(x: index + 1, y: tuesDayAmount, y2: tuesDayProfit),
  //     GraphCoordinates(x: index + 2, y: wendayAmount, y2: wendayProfit),
  //     GraphCoordinates(x: index + 3, y: thursdayAmount, y2: thursdayProfit),
  //     GraphCoordinates(x: index + 4, y: fridayAmount, y2: fridayProfit),
  //     GraphCoordinates(x: index + 5, y: satdayAmount, y2: satdayProfit),
  //     GraphCoordinates(x: index + 6, y: sundayAmount, y2: sundayProfit),
  //   ];
  //   return allList;
  // }
}
