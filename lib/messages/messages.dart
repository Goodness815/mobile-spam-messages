// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:messages/messages/dummy_data.dart';
import 'package:messages/shared/constants/app_colors.dart';
import 'package:messages/shared/themes/text_theme.dart';
import 'package:messages/shared/ui/message_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var dummyData = DummyData().messages;
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> allMessages = [];

  String greeting = 'Day';
  String getGreeting(DateTime time) {
    int hour = time.hour;
    String greeting;
    String emoji;

    if (hour < 12) {
      greeting = 'Morning';
      emoji = '☀️';
    } else if (hour < 18) {
      greeting = 'Afternoon';
      emoji = '🌤️';
    } else {
      greeting = 'Evening';
      emoji = '🌙';
    }

    return greeting + ' ' + emoji;
  }

  Future<void> _getMessages() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    List<SmsMessage> messages = await telephony.getInboxSms();
    setState(() {
      allMessages = messages;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMessages();
    DateTime now = DateTime.now();
    greeting = getGreeting(now);
  }

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
                    'Good $greeting',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 27,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorFaint,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      style: TextThemes(context).getTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Search for messages',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(0, 14, 124, 188),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintStyle: TextThemes(context).getTextStyle(
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                itemCount: allMessages.length,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MessageTile(
                      fullname: allMessages[index].address,
                      description: allMessages[index].body,
                      date: allMessages[index].date,
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
