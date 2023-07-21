
import 'package:droid_ui/controller/app.dart';
import 'package:droid_ui/core/constants/keys.dart';
import 'package:droid_ui/ui/components/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (app) {
      return ScaffoldWidget(
          maskEdges: true,
          left: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Text(
                  "AYARLAR",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const Divider(),
              const Text("Ses Secimi"),
              Wrap(
                spacing: 5.0,
                children: [
                  for (var item in app.voiceList)
                    ChoiceChip(
                      label: Text(item.name),
                      selected: item.id == app.settings.selectedVoice,
                      onSelected: (value) {
                        app.saveVoice(item.id);
                      },
                    ),
                ],
              ),
              const Divider(),
              const Text("Mod Secimi"),
              Wrap(
                spacing: 5.0,
                children: [
                  for (var item in app.moodList)
                    ChoiceChip(
                      label: Text(item.name),
                      selected: item.id == app.settings.selectedMood,
                      onSelected: (value) {
                        app.saveMood(item.id);
                      },
                    ),
                ],
              ),
              const Divider(),
              const Text("Data Path"),
              Text("${app.dataPath}"),
              const Divider(),
              const Text("Options"),
              Text("${app.dataPath}${Keys.optionsFile}"),
              const Divider(),
              const Text("Settings"),
              Text("${app.dataPath}${Keys.settingsFile}"),
              const Divider(),
              const Text("State"),
              Text("${app.dataPath}${Keys.stateFile}"),
            ],
          ));
    });
  }
}
