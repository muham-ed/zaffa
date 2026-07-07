class RoomModel {
  final String id;
  final String name;
  final String category;
  final int participants;
  final String? imageUrl;
  final bool isLive;

  const RoomModel({
    required this.id,
    required this.name,
    required this.category,
    required this.participants,
    this.imageUrl,
    this.isLive = false,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      participants: json['participants'],
      imageUrl: json['imageUrl'],
      isLive: json['isLive'] ?? false,
    );
  }
}