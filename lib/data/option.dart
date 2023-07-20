// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Option {
  int id;
  String name;
  String icon;
  String? sample;
  Option({
    required this.id,
    required this.name,
    required this.icon,
    this.sample,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'sample': sample,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      icon: (map['icon'] ?? '') as String,
      sample: map['sample'] != null ? map['sample'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) => Option.fromMap(json.decode(source) as Map<String, dynamic>);
}
