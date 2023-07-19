// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  int selectedVoice;
  int selectedMood;
  Settings({
    required this.selectedVoice,
    required this.selectedMood,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectedVoice': selectedVoice,
      'selectedMood': selectedMood,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      selectedVoice: (map['selectedVoice'] ?? 0) as int,
      selectedMood: (map['selectedMood'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) => Settings.fromMap(json.decode(source) as Map<String, dynamic>);
}
