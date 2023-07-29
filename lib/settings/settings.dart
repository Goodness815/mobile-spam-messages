// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:messages/shared/constants/app_icon.dart';
import 'package:messages/shared/ui/settings_tile.dart';

import '../messages/dummy_data.dart';
import '../shared/constants/app_colors.dart';
import '../shared/themes/text_theme.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  var dummyData = DummyData().messages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Settings',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 27,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SettingsTiles(
                buttonValue: 'FeedBack',
                descripionValue: 'Give us a quick feedback on the app',
                iconValue: AppIcons.message,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
