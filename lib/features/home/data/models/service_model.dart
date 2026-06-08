import 'package:hive_ce/hive.dart';
import '../../domain/entities/service_entity.dart';

part 'service_model.g.dart';

@HiveType(typeId: 1)
class ServiceModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int iconCodePoint;
  @HiveField(4)
  final String price;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconCodePoint,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        iconCodePoint: json['iconCodePoint'] as int,
        price: json['price'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'iconCodePoint': iconCodePoint,
        'price': price,
      };

  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        title: title,
        description: description,
        iconCodePoint: iconCodePoint,
        price: price,
      );

  factory ServiceModel.fromEntity(ServiceEntity entity) => ServiceModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        iconCodePoint: entity.iconCodePoint,
        price: entity.price,
      );
}
