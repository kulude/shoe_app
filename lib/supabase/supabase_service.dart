import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supaBase = Supabase.instance.client;

  Future<void> insertShoeToTable(Shoe shoe) async {
    try {
      await supaBase.from('shoeTable').insert(shoe.toMap());
    } catch (e) {
      print('Error inserting shoe: $e');
    }
  }

  Future<List<Shoe>> getShoesFromTable() async {
    try {
      final response = await supaBase.from('shoeTable').select();

      if (response.isNotEmpty) {
        final List<Shoe> shoes = response
            .map((shoe) => Shoe.fromMap(shoe))
            .toList();
        return shoes;
      }
    } catch (e) {
      print('Error fetching shoes: $e');
    }
    return [];
  }

  Future<void> updateShoeInTable(Shoe shoe) async {
    try {
      await supaBase.from('shoeTable').update(shoe.toMap()).eq('id', shoe.id);
    } catch (e) {
      print('Error updating shoe: $e');
    }
  }

  Future<void> deleteShoeFromTable(String id) async {
    try {
      await supaBase.from('shoeTable').delete().eq('id', id);
    } catch (e) {
      print('Error deleting shoe: $e');
    }
  }
}
