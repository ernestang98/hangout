class Poi {
  final String id;
  final String name;
  final String category;
  final String location;
  final String displayImage;
  final String description;
  final bool trending;
  final String type;

  const Poi({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.displayImage,
    required this.description,
    required this.trending,
    required this.type,
  });
}
