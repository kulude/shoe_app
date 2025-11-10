import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/graph_data/weekly_graph.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/pages/add_shoe_page.dart';
import 'package:shoe_app/pages/inventory_pade.dart';
import 'package:shoe_app/services/shoe_service.dart';
// import 'package:shoe_app/utilities/home_screen_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final List<Shoe> _shoes = [];
  @override
  Widget build(BuildContext context) {
    final shoeSerice = Provider.of<ShoeService>(context);

    final totalMoney = shoeSerice.totalMony;
    final totalCost = shoeSerice.totalCost;
    final totalProfit = shoeSerice.totalProfit;
    final totolLoss = shoeSerice.totalLoss;
    final shoeSold = shoeSerice.shoesSold;
    //final avgTime = shoeSerice.averageTimeTaken;
    // String avgTimeString = avgTime == null
    //     ? 'No time yet'
    //     : '${avgTime.inDays} days';
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('Navigate to my inventory'),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => InventoryPage()));
            },
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total accumulated cost'),
                        Text(
                          totalCost.toString(),
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total accumulated money'),
                        Text(
                          totalMoney.toString(),
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total accumulated profit'),
                        Text(
                          totalProfit.toString(),
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total accumulated Loss'),
                        Text(
                          totolLoss.toString(),
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Total accumulated time'),
                    //     Text(
                    //       avgTimeString,
                    //       style: TextStyle(color: Colors.brown),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total number of sold shoes'),
                        Text(
                          shoeSold.length.toString(),
                          style: TextStyle(color: Colors.brown, fontSize: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              rowLegend(),
              SizedBox(height: 8),
              WeeklyGraph(shoeService: shoeSerice),
              // Expanded(
              // child: Consumer<ShoeService>(
              //   builder: (context, value, child) {
              //     return ListView.builder(
              //       itemCount: value.shoesSold.length,
              //       itemBuilder: (context, index) {
              //         final shoe = value.shoesSold[index];
              //         //Uint8List imageBytes = base64Decode(shoe.imageUrl);
              //         return value.shoesSold.isEmpty
              //             ? Center(child: Text('No shoes added yet!'))
              //             : HomeScreenImage(
              //                 shoe: shoe,
              //                 imageBytes: shoe.imageBytes,
              //               );
              //       },
              //     );
              //   },
              // ),
              //),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute<Shoe>(builder: (context) => AddShoePage()));
        },
        heroTag: 'Add new shoe',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget rowLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.indeterminate_check_box, color: Colors.black),
        SizedBox(width: 3),
        Text('Profit'),
        SizedBox(width: 8),
        Icon(Icons.indeterminate_check_box, color: Colors.blueGrey),
        SizedBox(width: 3),
        Text('Cost price'),
      ],
    );
  }
}
