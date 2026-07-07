class GameModel {
  final String id;
  final String name;
  final String icon;
  final int players;
  final bool isActive;

  GameModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.players,
    this.isActive = false,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      players: json['players'],
      isActive: json['isActive'] ?? false,
    );
  }
}