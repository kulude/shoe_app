import 'package:hive/hive.dart';
import 'package:shoe_app/modals/shoe_modal.dart';

class HiveService {
  final box = Hive.box<Shoe>('shoeBox');

  void addShoeToHive(Shoe shoe) async {
    await box.put(shoe.id, shoe);
  }

  List<Shoe> getAllShoes() {
    final box2 = box.values.toList();
    return box2;
  }

  Shoe? getShoe(String id) {
    return box.get(id);
  }

  void delete(List<String> id) {
    box.deleteAll(id);
  }

  void insertAtIndex(Shoe shoe) {
    box.put(shoe.id, shoe);
  }
}
