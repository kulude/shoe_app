import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoe_app/modals/shoe_modal.dart';

class MyContainer extends StatelessWidget {
  final Shoe shoe;
  final Duration duration;
  final bool isSelected;
  const MyContainer({
    super.key,
    required this.shoe,
    required this.duration,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final uintlist = base64Decode(shoe.imageUrl);
    final hight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: duration,
      curve: isSelected ? Curves.easeOut : Curves.easeIn,
      height: isSelected ? hight / 4 : hight / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
        child: Stack(
          children: [
            // Shoe Image
            Positioned.fill(
              child: Hero(
                tag: 'shoe-image-${shoe.id}',
                child: Image.memory(
                  uintlist,
                  fit: BoxFit.cover, // keeps image proportions correct
                ),
              ),
            ),

            // Dark overlay for better text readability
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: isSelected ? 0.6 : 0.35,
                duration: duration,
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),

            // Price (bottom-left)
            Positioned(
              bottom: 8,
              left: 8,
              child: _infoTag('sh ${shoe.costPrice}'),
            ),

            // Name (bottom-right)
            Positioned(bottom: 8, right: 8, child: _infoTag(shoe.shoeName)),

            // Selling price (top-left)
            Positioned(
              top: 8,
              left: 8,
              child: _infoTag('sh ${shoe.sellPrice}'),
            ),

            // Status (top-right)
            Positioned(
              top: 8,
              right: 8,
              child: isSelected
                  ? Icon(Icons.check_box)
                  : _infoTag(
                      shoe.status! ? 'Sold' : 'In stock',
                      color: shoe.status! ? Colors.redAccent : Colors.green,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTag(String text, {Color color = Colors.black54}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
