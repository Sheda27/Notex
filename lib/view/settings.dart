import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/extrnalwidgets.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

ThemeCtrl _themeCtrl = Get.put(ThemeCtrl());

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings')),
      body: Column(
        children: [
          SizedBox(height: 10),
          GetBuilder<ThemeCtrl>(
            builder:
                (cotroller) => SwitchListTile(
                  value: cotroller.isDark.value,
                  title: Text('Dark mode'),
                  onChanged: (value) {
                    cotroller.isDark.value = value;
                    if (value == true) {
                      log('dark mode is on');
                      Get.changeTheme(themeDark());
                    } else {
                      log('light mode is on');
                      Get.changeTheme(themeLight());
                    }
                    setState(() {});
                    _themeCtrl.setThemePref(value);
                  },
                ),
          ),
        ],
      ),
    );
  }
}
