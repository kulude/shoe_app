import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/pages/finatials_page.dart';
import 'package:shoe_app/services/shoe_service.dart';
import 'package:shoe_app/utilities/delete_dialog.dart';
import 'package:shoe_app/utilities/shoe_tile.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shoeServicce = Provider.of<ShoeService>(context);
    final lengthOfShoeToDelete = shoeServicce.shoesForDelete;
    return Scaffold(
      appBar: AppBar(
        title: lengthOfShoeToDelete.isEmpty
            ? Text('Inventory')
            : Text('${lengthOfShoeToDelete.length} selected'),
        actions: [
          lengthOfShoeToDelete.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FinancialsPage()),
                    );
                  },
                  child: Text(
                    'Navigate to financials',
                    style: TextStyle(color: Colors.brown),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialog();
                      },
                    );
                  },
                  child: Text('Delete ${lengthOfShoeToDelete.length} shoes'),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ShoeService>(
          builder: (context, shoeService, child) {
            return GridView.builder(
              itemCount: shoeService.getAllShoes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final shoe = shoeService.getAllShoes[index];
                return ShoeTile(shoe: shoe);
              },
            );
          },
        ),
      ),
    );
  }
}
