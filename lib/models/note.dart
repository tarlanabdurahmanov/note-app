import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  int? id;
  String title;
  String content;
  String color;
  String createdAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["title"],
        content: json["content"],
        color: json["color"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "color": color,
        "createdAt": createdAt,
      };

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['content'] = content;
    data['color'] = color;
    data['createdAt'] = createdAt;
    return data;
  }
}
