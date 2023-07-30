// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:messages/messages/dummy_data.dart';
import 'package:messages/messages/message_details.dart';
import 'package:messages/shared/ui/spam_tile.dart';
import 'package:telephony/telephony.dart';

import '../shared/constants/app_colors.dart';
import '../shared/themes/text_theme.dart';

class SpamScreen extends StatefulWidget {
  const SpamScreen({super.key});

  @override
  State<SpamScreen> createState() => _SpamScreenState();
}

class _SpamScreenState extends State<SpamScreen> {
  var dummyData = DummyData().messages;
  List<SmsMessage> allMessages = [];
  final Telephony telephony = Telephony.instance;

  Future<void> _getMessages() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    List<SmsMessage> messages = await telephony.getInboxSms();
    setState(() {
      allMessages = messages;
    });
  }

  bool isSpamMessage(SmsMessage message) {
    // Convert the message body to lowercase for case-insensitive matching
    String body = message.body!.toLowerCase();

    // Criteria 1: Check for specific keywords commonly associated with spam
    if (body.contains('win') ||
        body.contains('free') ||
        body.contains('lottery')) {
      return true;
    }

    // Criteria 2: Check for suspicious URLs
    if (body.contains('http://') || body.contains('https://')) {
      return true;
    }

    // Criteria 3: Check for messages from blacklisted senders
    List<String> blacklistedSenders = [
      '123456', // Add more blacklisted sender addresses or phone numbers here
    ];
    if (blacklistedSenders.contains(message.address)) {
      return true;
    }

    // Criteria 4: Check for excessive use of capital letters or special characters
    int uppercaseCount = body.replaceAll(RegExp(r'[^A-Z]'), '').length;
    if (uppercaseCount > body.length * 0.4) {
      return true;
    }

    // Criteria 5: Check for messages with short length (common in spam)
    if (body.length < 20) {
      return true;
    }

    // If none of the above criteria match, consider it not a spam message
    return false;
  }

  @override
  void initState() {
    super.initState();
    _getMessages();
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
                itemCount: allMessages.where(isSpamMessage).length,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  // Get only spam messages
                  List<SmsMessage> spamMessages =
                      allMessages.where(isSpamMessage).toList();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MessageDetails(
                        //       data: spamMessages[index],
                        //     ),
                        //   ),
                        // );
                      },
                      child: SpamTile(
                        fullname: "${spamMessages[index].address}",
                        description: "${spamMessages[index].body}",
                        date: spamMessages[index].date,
                      ),
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
