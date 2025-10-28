//import 'package:show_biz/modals/shoe_status.dart';
//library shoe_modal;
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
//part 'shoe_modal.g.dart';

@HiveType(typeId: 0)
class Shoe {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String shoeName;
  @HiveField(2)
  final double costPrice;
  @HiveField(3)
  final double sellPrice;
  @HiveField(4)
  final DateTime dateBought;
  @HiveField(5)
  final Uint8List imageBytes;
  @HiveField(6)
  final DateTime? dateSold;
  @HiveField(7)
  final String description;
  @HiveField(8)
  final bool? status;
  //final ShoeStatus? shoeStatus;

  Shoe({
    String? id,
    required this.shoeName,
    required this.costPrice,
    required this.sellPrice,
    required this.dateBought,
    required this.imageBytes,
    this.dateSold,
    required this.description,
    this.status,
    //this.shoeStatus,
  }) : id = id ?? Uuid().v4();

  double get profit => sellPrice - costPrice;

  Duration? get timeTaken => dateSold?.difference(dateBought);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shoeName': shoeName,
      'costPrice': costPrice,
      'sellPrice': sellPrice,
      'dateBought': dateBought.toIso8601String(),
      'imageUrl': imageBytes,
      'dateSold': dateSold?.toIso8601String(),
      'description': description,
      'status': status,
      //'shoeStatus': shoeStatus,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      id: map['id'],
      shoeName: map['shoeName'],
      costPrice: map['costPrice'],
      sellPrice: map['sellPrice'],
      dateBought: DateTime.parse(map['dateBought']),
      imageBytes: map['imageUrl'],
      dateSold: map['dateSold'] != null
          ? DateTime.parse(map['dateSold'])
          : null,
      description: map['description'],
      status: map['status'],
      //shoeStatus: map['shoeStatus'],
    );
  }

  Shoe copyWith({
    String? id,
    String? shoeName,
    double? costPrice,
    double? sellPrice,
    DateTime? dateBought,
    Uint8List? imageBytes,
    DateTime? dateSold,
    String? description,
    bool? status,
  }) {
    return Shoe(
      id: id ?? this.id,
      shoeName: shoeName ?? this.shoeName,
      costPrice: costPrice ?? this.costPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      dateBought: dateBought ?? this.dateBought,
      imageBytes: imageBytes ?? this.imageBytes,
      dateSold: dateSold ?? this.dateSold,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
