import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/pages/edit_shoe.dart';

class DetailsPage extends StatelessWidget {
  final Shoe shoe;
  DetailsPage({super.key, required this.shoe});

  final space = SizedBox(height: 7);
  final style = TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final animDuration = reduceMotion
        ? Duration.zero
        : Duration(milliseconds: 300);
    final bytes = base64Decode(shoe.imageUrl);
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.navigate_before),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditShoe(shoe: shoe),
                      ),
                    );
                  },
                  child: Text(
                    'Edit shoe',
                    style: TextStyle(fontSize: 20, color: Colors.brown),
                  ),
                ),
              ],
            ),
            space,
            Container(
              height: hight / 5 + 50,
              width: double.infinity,
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
                child: Hero(
                  tag: 'shoe-image-${shoe.id}',
                  child: Image.memory(bytes, fit: BoxFit.cover),
                ),
              ),
            ),
            space,
            AnimatedContainer(
              duration: animDuration,
              curve: Curves.easeOut,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shoe.shoeName, style: TextStyle(fontSize: 20)),
                  space,
                  Text(
                    'The shoe was bought for: sh ${shoe.costPrice}',
                    style: style,
                  ),
                  space,
                  Text(
                    'The shoe was sold for: sh ${shoe.sellPrice}',
                    style: style,
                  ),
                  space,
                  Text('Shoe details: ${shoe.description}', style: style),
                  space,
                  Text(
                    'The shoe was bought on: sh ${shoe.dateBought}',
                    style: style,
                  ),
                  space,
                  Text(
                    shoe.dateSold != null
                        ? 'The shoe was sold for: sh ${shoe.dateSold}'
                        : 'The date for when the shoe was sold has not been updated',
                  ),
                  space,
                  Text(
                    shoe.status!
                        ? 'The shoe is Sold'
                        : 'The shoe is still In stock',
                    style: TextStyle(
                      fontSize: 20,
                      color: shoe.status!
                          ? Colors.brown[700]
                          : Colors.brown[500],
                    ),
                  ),
                  space,
                  Text(
                    'Shoe profit: ${!shoe.profit.isNegative ? shoe.profit : 0.0}',
                    style: style,
                  ),
                  space,
                  Text(
                    'Shoe loss: ${shoe.profit.isNegative ? shoe.profit : 0.0}',
                    style: style,
                  ),
                  space,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
