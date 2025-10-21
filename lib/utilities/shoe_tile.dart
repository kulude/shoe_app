import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/pages/show_details.dart';
import 'package:shoe_app/services/shoe_service.dart';
import 'package:shoe_app/utilities/container.dart';

class ShoeTile extends StatelessWidget {
  final Shoe shoe;
  const ShoeTile({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeService>(context, listen: false);
    final shoesForDelete = provider.shoesForDelete;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final duration = reduceMotion
        ? Duration.zero
        : const Duration(microseconds: 700);
    return GestureDetector(
      onDoubleTap: () {
        provider.toggleSelection(shoe);
      },
      onTap: () {
        if (shoesForDelete.isNotEmpty) {
          provider.toggleSelection(shoe);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailsPage(shoe: shoe)),
          );
        }
      },
      child: Selector<ShoeService, bool>(
        selector: (context, shoeService) => shoeService.isSelected(shoe),
        builder: (context, isSelected, _) {
          return MyContainer(
            shoe: shoe,
            duration: duration,
            isSelected: isSelected,
          );
        },
      ),
    );
  }
}
