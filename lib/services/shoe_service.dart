import 'package:flutter/material.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/hive_service.dart';
import 'package:shoe_app/supabase/supabase_service.dart';

class ShoeService extends ChangeNotifier {
  final List<Shoe> _shoes = [];
  final hiveService = HiveService();
  final SupabaseService supabaseService = SupabaseService();

  double get totalProfit {
    return _shoes
        .where((shoe) => shoe.dateSold != null || (shoe.status ?? false))
        .fold(0.0, (sum, shoe) => sum + shoe.profit);
  }

  double get totalLoss {
    return _shoes
        .where(
          (shoe) =>
              (shoe.dateSold != null || (shoe.status ?? false)) &&
              shoe.profit.isNegative,
        )
        .fold(0.0, (sum, shoe) {
          return sum + shoe.profit;
        });
  }

  double get totalMony {
    return _shoes
        .where((shoe) => shoe.dateSold != null || (shoe.status ?? false))
        .fold(0.0, (sum, shoe) {
          return sum + shoe.sellPrice;
        });
  }

  double get totalCost {
    return _shoes
        .where((shoe) => shoe.dateSold != null || (shoe.status ?? false))
        .fold(0.0, (sum, shoe) {
          return sum + shoe.costPrice;
        });
  }

  List<Shoe> get shoesSold {
    return _shoes
        .where((shoe) => shoe.dateSold != null || (shoe.status ?? false))
        .toList();
  }

  Duration? get averageTimeTaken {
    final shoesSold = _shoes
        .where((shoe) => shoe.dateSold != null || (shoe.status ?? false))
        .toList();
    if (shoesSold.isEmpty) return null;
    final totalDuration = shoesSold.fold<Duration>(
      Duration.zero,
      (sum, shoe) => sum + (shoe.timeTaken ?? Duration.zero),
    );
    return Duration(
      days: totalDuration.inDays ~/ shoesSold.length,
      hours: (totalDuration.inHours % 24) ~/ shoesSold.length,
      minutes: (totalDuration.inMinutes % 60) ~/ shoesSold.length,
    );
  }

  List<Shoe> get getAllShoes => List.unmodifiable(_shoes);

  void addShoe(Shoe shoe) {
    _shoes.add(shoe);
    hiveService.addShoeToHive(shoe);
    supabaseService.insertShoeToTable(shoe);
    notifyListeners();
  }

  void deleteShoe(String id) {
    _shoes.removeWhere((shoe) => shoe.id == id);
    //hiveService.delete(id);
    supabaseService.deleteShoeFromTable(id);
    notifyListeners();
  }

  void editShoe(
    String id, {
    String? shoeName,
    double? costPrice,
    double? sellPrice,
    DateTime? dateBought,
    DateTime? dateSold,
    String? description,
    bool? status,
  }) {
    final index = _shoes.indexWhere((shoe) => shoe.id == id);
    if (index != -1) {
      _shoes[index] = _shoes[index].copyWith(
        shoeName: shoeName,
        costPrice: costPrice,
        sellPrice: sellPrice,
        dateBought: dateBought,
        dateSold: dateSold,
        description: description,
        status: status,
      );
      notifyListeners();
    }
    supabaseService.updateShoeInTable(_shoes[index]);
  }

  final Set<String> _selectedShoeId = {};

  List<Shoe> get shoesForDelete {
    return _shoes.where((shoe) => _selectedShoeId.contains(shoe.id)).toList();
  }

  bool isSelected(Shoe shoe) => _selectedShoeId.contains(shoe.id);

  void toggleSelection(Shoe shoe) {
    if (_selectedShoeId.contains(shoe.id)) {
      _selectedShoeId.remove(shoe.id);
    } else {
      _selectedShoeId.add(shoe.id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedShoeId.clear();
    notifyListeners();
  }

  void deleteSelectedShoes() {
    _shoes.removeWhere((shoe) => _selectedShoeId.contains(shoe.id));
    hiveService.delete(_selectedShoeId.toList());
    supabaseService.deleteShoeFromTable(_selectedShoeId.toString());
    clearSelection();
    notifyListeners();
  }
}
