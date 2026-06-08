class ServiceEntity {
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          iconCodePoint == other.iconCodePoint &&
          price == other.price;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      iconCodePoint.hashCode ^
      price.hashCode;
}
