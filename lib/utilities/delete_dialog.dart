import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/services/shoe_service.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeService>(context);
    return AlertDialog(
      title: Text('Are you sure you want to delete these shoes'),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    provider.clearSelection();
                  },
                  child: Text('cancels'),
                ),
                TextButton(
                  onPressed: () {
                    provider.deleteSelectedShoes();
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
