import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/further_shoe_service.dart';
import 'package:shoe_app/services/shoe_service.dart';

class FinancialsPage extends StatelessWidget {
  //final Shoe shoea;
  const FinancialsPage({super.key}); //required this.shoea});

  @override
  Widget build(BuildContext context) {
    final shoeService = Provider.of<ShoeService>(context);
    final futherShoeService = FurtherShoeService(
      shoeService: shoeService,
      //dateBought: shoea.dateBought,
      //dateSold: shoea.dateSold,
    );

    final groupedByMap = futherShoeService.shoesBoughtDay;
    final entries = groupedByMap.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    final groupedBySoldMap = futherShoeService.shoesSoldDay;

    final soldEntries = groupedBySoldMap.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    //final allShoes = futherShoeService.shoesBoughtOn;
    return Scaffold(
      appBar: AppBar(title: Text('Financials page')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final datekey = entries[index].key;
                final shoesPerKey = entries[index].value;
                final dateTime = convertDateToString(datekey);
                final spent = shoesPerKey.fold<double>(
                  0.0,
                  (sum, shoe) => sum + shoe.profit,
                );
                return Card(
                  margin: EdgeInsets.all(9),
                  elevation: 4,
                  color: Colors.brown[300],
                  child: ListTile(
                    title: Text('${shoesPerKey.length} bought on $dateTime'),
                    subtitle: Text('sh ${spent} spend '),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Shoes sold and the day',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (soldEntries.isEmpty) ...[Text('No shoes sold yet')],
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: soldEntries.length,
              itemBuilder: (context, index) {
                if (soldEntries.isEmpty) {
                  return Center(child: Text('No shoes sold yet'));
                }
                final dateKey = soldEntries[index].key;
                final shoesSoldPerDay = soldEntries[index].value;
                final dateTime = convertDateToString(dateKey);
                final sellPrice = shoesSoldPerDay.fold<double>(
                  0.0,
                  (sum, shoe) => sum + shoe.sellPrice,
                );
                return Card(
                  margin: EdgeInsets.all(9),
                  elevation: 4,
                  color: Colors.brown[300],
                  child: ListTile(
                    title: Text('${shoesSoldPerDay.length} sold on $dateTime'),
                    subtitle: Text('sold for sh $sellPrice '),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String convertDateToString(DateTime date) {
    String year = date.year.toString();

    String month = date.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = date.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }
    return '$year/$month/$day';
  }
}
