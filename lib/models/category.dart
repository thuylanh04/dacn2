// Model: Category
// Backend-driven category with icon name and color hex.

class Category {
  final int id;
  final String name;
  final String icon;   // e.g. "restaurant"
  final String color;  // e.g. "#2E5BFF"

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? 'category',
      color: json['color'] as String? ?? '#2E5BFF',
    );
  }
}
