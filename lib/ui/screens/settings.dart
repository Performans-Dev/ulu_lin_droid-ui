import 'dart:convert';
import 'dart:io';

import 'package:droid_ui/core/constants/keys.dart';
import 'package:droid_ui/ui/components/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedVoice = "";
  List<String> voices = [];
  @override
  void initState() {
    super.initState();
    readOptions();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      left: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ),
      content: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AYARLAR"),
          Text("Ses"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in voices)
                Chip(
                  label: Text(item),
                ),
            ],
          ),
          Divider(),
          Text("Mod"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                label: Text("mutlu"),
              ),
              Chip(
                label: Text("normal"),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Future<void> readOptions() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    String filePath = "${path}/droid/${Keys.optionsFile}";
    File f = File(filePath);

    String content = await f.readAsString(); //filestream to string
    Map<String, dynamic> data = json.decode(content);
    List<String> list = [];
    for (var item in data['voice']) {
      list.add(item);
    }
    setState(() {
      voices = list;
    });
  }
 


}
