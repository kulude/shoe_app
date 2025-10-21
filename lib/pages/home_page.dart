import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/pages/add_shoe_page.dart';
import 'package:shoe_app/pages/inventory_pade.dart';
import 'package:shoe_app/pages/show_details.dart';
import 'package:shoe_app/services/shoe_service.dart';

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
    final shoesSold = shoeSerice.shoesSold;
    final avgTime = shoeSerice.averageTimeTaken;
    String avgTimeString = avgTime == null
        ? 'Not much time  taken to sold shoe yet'
        : '${avgTime.inDays} days and ${avgTime.inHours % 24} hours';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 230,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total accumulated time'),
                      Text(
                        avgTimeString,
                        style: TextStyle(color: Colors.brown),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total number of sold shoes'),
                      Text(
                        shoesSold.length.toString(),
                        style: TextStyle(color: Colors.brown, fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shoesSold.length,
                itemBuilder: (context, index) {
                  final shoe = shoesSold[index];
                  Uint8List imageBytes = base64Decode(shoe.imageUrl);
                  return shoesSold.isEmpty
                      ? Center(child: Text('No shoes added yet!'))
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(shoe: shoe),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.memory(
                                      imageBytes,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      shoe.shoeName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute<Shoe>(builder: (context) => AddShoePage()));
          // setState(() {
          //   // _shoeService.getAllShoes.add(shoe!);
          //   _shoes.add(shoe!);
          // });
        },
        heroTag: 'Add new shoe',
        child: Icon(Icons.add),
      ),
    );
  }
}
