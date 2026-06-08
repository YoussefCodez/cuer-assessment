import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int iconCodePoint;
  final String price;

  const ServiceEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconCodePoint,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, description, iconCodePoint, price];
}
