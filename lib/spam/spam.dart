// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:messages/messages/dummy_data.dart';
import 'package:messages/shared/ui/spam_tile.dart';

import '../shared/constants/app_colors.dart';
import '../shared/themes/text_theme.dart';
import '../shared/ui/starred_tile.dart';

class SpamScreen extends StatefulWidget {
  const SpamScreen({super.key});

  @override
  State<SpamScreen> createState() => _SpamScreenState();
}

class _SpamScreenState extends State<SpamScreen> {
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
                    'Spam Messages',
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
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dummyData.length,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SpamTile(
                      fullname: dummyData[index]['full name'],
                      description: dummyData[index]['message'],
                      date: dummyData[index]['date'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
