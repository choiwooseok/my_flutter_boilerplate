import 'dart:convert';

class PostEntity {
  int id;
  String title;
  String body;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });

  PostEntity copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostEntity.fromMap(Map<String, dynamic> map) {
    return PostEntity(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());
  factory PostEntity.fromJson(String source) =>
      PostEntity.fromMap(json.decode(source));

  @override
  String toString() => 'PostEntity(id: $id, title: $title, body: $body)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostEntity &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}
