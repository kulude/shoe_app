import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/shoe_service.dart';

class FurtherShoeService {
  final ShoeService shoeService;
  // final DateTime dateBought;
  //final DateTime? dateSold;
  FurtherShoeService({
    required this.shoeService,
    //required this.dateBought,
    //this.dateSold,
  });

  Map<DateTime, List<Shoe>> get shoesBoughtDay {
    final Map<DateTime, List<Shoe>> groupedShoe = {};

    for (var shoe in shoeService.getAllShoes) {
      final boughtShoe = shoe.dateBought;
      final dateKey = DateTime(
        boughtShoe.year,
        boughtShoe.month,
        boughtShoe.day,
      );

      groupedShoe.putIfAbsent(dateKey, () => []).add(shoe);
    }
    return groupedShoe;
  }

  Map<DateTime, List<Shoe>> get shoesSoldDay {
    final Map<DateTime, List<Shoe>> groupedShoe = {};

    for (var shoe in shoeService.getAllShoes) {
      final dateSold = shoe.dateSold;
      if (dateSold != null && (shoe.status ?? false)) {
        final dateKey = DateTime(dateSold.year, dateSold.month, dateSold.day);
        groupedShoe.putIfAbsent(dateKey, () => []).add(shoe);
      }
    }
    return groupedShoe;
  }

  DateTime startOfWeek() {
    DateTime today = DateTime.now();

    return today.subtract(Duration(days: today.weekday - 1));
  }

  String convertDateTimeToString(DateTime date) {
    String year = date.year.toString();

    String month = date.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = date.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }
    return '$year$month$day';
  }

  Map<String, double> graphMapBought() {
    Map<String, double> shoeDataBought = {};

    for (var shoe in shoeService.getAllShoes) {
      String date = convertDateTimeToString(shoe.dateBought);
      double amountBought = shoe.costPrice;
      if (shoeDataBought.containsKey(date)) {
        final currentAmount = shoeDataBought[date]!;
        amountBought += currentAmount;
        shoeDataBought[date] = amountBought;
      } else {
        shoeDataBought.addAll({date: amountBought});
      }
    }
    return shoeDataBought;
  }

  Map<String, double> graphMapSold() {
    Map<String, double> shoeDataSold = {};

    for (var shoe in shoeService.getAllShoes) {
      if (shoe.dateSold != null && (shoe.status ?? false)) {
        String dateKey = convertDateTimeToString(shoe.dateSold!);
        double amountSold = shoe.sellPrice;

        if (shoeDataSold.containsKey(dateKey)) {
          final currentAmount = shoeDataSold[dateKey]!;
          amountSold += currentAmount;
          shoeDataSold[dateKey] = amountSold;
        } else {
          shoeDataSold.addAll({dateKey: amountSold});
        }
      }
    }
    return shoeDataSold;
  }
}
