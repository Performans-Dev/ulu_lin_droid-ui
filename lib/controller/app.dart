import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:droid_ui/core/constants/keys.dart';
import 'package:droid_ui/data/option.dart';
import 'package:droid_ui/data/settings.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AppController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    loadOptionLists();
  }

  final RxList<Option> _voiceList = RxList.empty();
  List<Option> get voiceList => _voiceList;
  void setVoiceList(List<Option> list) {
    _voiceList.assignAll(list);
    update();
  }

  final RxList<Option> _moodList = RxList.empty();
  List<Option> get moodList => _moodList;
  void setMoodList(List<Option> list) {
    _moodList.assignAll(list);
    update();
  }

  final Rx<Settings> _settings = Settings(selectedMood: 0, selectedVoice: 0).obs;
  Settings get settings => _settings.value;
  void setSettings(Settings s) {
    _settings.value = s;
    update();
  }

  Future<void> loadOptionLists() async {
    List<Option> vList = [];
    List<Option> mList = [];
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}${Keys.optionsFile}";
      File f = File(filePath);
      String dataStr = await f.readAsString();
      Map<String, dynamic> dataJson = json.decode(dataStr);
      //voice
      dynamic voiceData = dataJson["voices"];
      if (voiceData != null && voiceData is List) {
        for (var j in voiceData) {
          Option o = Option.fromMap(j);
          vList.add(o);
        }
        setVoiceList(vList);
      }
      //mood
      dynamic moodData = dataJson["moods"];
      for (var j in moodData) {
        Option o = Option.fromMap(j);
        mList.add(o);
      }
      setMoodList(mList);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> readSettings() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}${Keys.settingsFile}";
      File f = File(filePath);
      String dataString = await f.readAsString();
      Map<String, dynamic> dataJson = json.decode(dataString);
      Settings s = Settings.fromMap(dataJson);

      setSettings(s);
    } catch (e) {
      setSettings(Settings(selectedVoice: 1, selectedMood: 1));
    }
  }
}
