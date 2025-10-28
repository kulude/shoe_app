import 'package:flutter/material.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/pages/show_details.dart';

import 'dart:typed_data';

class HomeScreenImage extends StatelessWidget {
  final Shoe shoe;
  final Uint8List imageBytes;
  const HomeScreenImage({
    super.key,
    required this.shoe,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailsPage(shoe: shoe)),
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
                child: Hero(
                  tag: 'shoe-image-${shoe.id}',
                  child: Image.memory(imageBytes, fit: BoxFit.cover),
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
  }
}
