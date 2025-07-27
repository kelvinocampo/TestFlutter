class ApiKey {
  final int? id;
  final String name;
  final String key;
  final bool isActive;

  ApiKey({
    this.id,
    required this.key,
    required this.name,
    this.isActive = false,
  });

  ApiKey copyWith({int? id, String? name, String? key, bool? isActive}) {
    return ApiKey(
      id: id ?? this.id,
      name: name ?? this.name,
      key: key ?? this.key,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() => {
    'key_id': id,
    'name': name,
    'key': key,
    'is_active': isActive ? 1 : 0,
  };

  factory ApiKey.fromMap(Map<String, dynamic> map) => ApiKey(
    id: map['key_id'],
    name: map['name'],
    key: map['key'],
    isActive: map['is_active'] == 1,
  );
}
