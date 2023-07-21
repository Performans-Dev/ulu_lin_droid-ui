import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:droid_ui/core/constants/keys.dart';
import 'package:droid_ui/data/default.dart';
import 'package:droid_ui/data/option.dart';
import 'package:droid_ui/data/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AppController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    runInitTasks();
  }

  //#region VARIABLES
  final RxnString _dataPath = RxnString();
  String? get dataPath => _dataPath.value;

  final RxString _appState = RxString("idle");
  String get appState => _appState.value;
  void setAppState(String s) {
    _appState.value = s;
    if (appStateList.isEmpty || s != appStateList.first) {
      _appStateList.insert(0, s);
    }
    update();
  }

  final RxList<String> _appStateList = <String>[].obs;
  List<String> get appStateList => _appStateList;

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

  final Rx<Settings> _settings =
      Settings(selectedMood: 0, selectedVoice: 0).obs;
  Settings get settings => _settings.value;
  void setSettings(Settings s) {
    _settings.value = s;
    update();
  }
  //#endregion

  //#region METHODS
  Future<void> saveMood(int m) async {
    Settings s = settings;
    s.selectedMood = m;
    setSettings(s);
    await writeSettings(s);
  }

  Future<void> saveVoice(int m) async {
    Settings s = settings;
    s.selectedVoice = m;
    setSettings(s);
    await writeSettings(s);
  }
  //#endregion

  //#region CREATE FILES WITH DEFAULT DATA
  Future<void> createDefaultOptionsFile() async {
    String filePath = "${dataPath!}${Keys.optionsFile}";
    File f = File(filePath);
    await f.create(recursive: true);
    f.writeAsString(json.encode(defaultOptions));
  }

  Future<void> createDefaultSettingsFile() async {
    String filePath = "${dataPath!}${Keys.settingsFile}";
    File f = File(filePath);
    await f.create(recursive: true);
    f.writeAsString(json.encode(defaultSettings));
  }

  Future<void> createDefaultStateFile() async {
    String filePath = "${dataPath!}${Keys.stateFile}";
    File f = File(filePath);
    await f.create(recursive: true);
    f.writeAsString(json.encode(defaultState));
  }
  //#endregion

  //#region DISK READER
  Future<void> loadOptionLists() async {
    List<Option> vList = [];
    List<Option> mList = [];
    try {
      String filePath = "${dataPath!}${Keys.optionsFile}";
      File f = File(filePath);
      if (!await f.exists()) {
        await createDefaultOptionsFile();
        loadOptionLists();
        return;
      }
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
    } on IOException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> readSettings() async {
    try {
      String filePath = "${dataPath!}${Keys.settingsFile}";
      File f = File(filePath);
      if (!await f.exists()) {
        await createDefaultSettingsFile();
        readSettings();
        return;
      }
      String dataString = await f.readAsString();
      Map<String, dynamic> dataJson = json.decode(dataString);
      Settings s = Settings.fromMap(dataJson);

      setSettings(s);
    } catch (e) {
      setSettings(Settings(selectedVoice: 1, selectedMood: 1));
    }
  }

  Future<void> readAppState() async {
    if (kDebugMode) {
      print("reading app state");
    }
    try {
      String filePath = "${dataPath!}${Keys.stateFile}";
      File f = File(filePath);
      if (!await f.exists()) {
        await createDefaultStateFile();
        readAppState();
        return;
      }
      String dataString = await f.readAsString();
      Map<String, dynamic> dataJson = json.decode(dataString);
      String s = dataJson['state'] ?? 'idle';
      setAppState(s);
      await writeAppState('idle');
      Future.delayed(const Duration(milliseconds: 3000), () => readAppState());
    } catch (e) {
      setAppState('idle');
    }
  }
  //#endregion

  //#region DISK WRITER
  Future<bool> writeSettings(Settings s) async {
    try {
      String filePath = "${dataPath!}${Keys.settingsFile}";
      File f = File(filePath);
      await f.writeAsString(json.encode(settings.toMap()));
      setSettings(s);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> writeAppState(String s) async {
    try {
      String filePath = "${dataPath!}${Keys.stateFile}";
      File f = File(filePath);
      await f.writeAsString(json.encode({"state": s}));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  //#endregion

  //#region INIT
  Future<void> runInitTasks() async {
    //
    String path = await getPath();
    _dataPath.value = path;
    update();
    await loadOptionLists();
    await readSettings();
    await readAppState();
  }
  //#endregion  

  //#region HELPER
  Future<String> getPath() async {
    Directory directory = await getApplicationSupportDirectory();
    return directory.path;
  }
  //#endregion
}
