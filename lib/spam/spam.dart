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
  List<SmsMessage> allMessages = [];
  final Telephony telephony = Telephony.instance;
  Map<String, List<SmsMessage>> spamMessageThreads = {};
  bool isLoading = false;

  Future<void> _getMessages() async {
    setState(() {
      isLoading = true;
    });
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    List<SmsMessage> messages = await telephony.getInboxSms();
    setState(() {
      allMessages = messages;
      _groupSpamMessagesIntoThreads();
    });
  }

  void _groupSpamMessagesIntoThreads() {
    spamMessageThreads.clear();
    for (SmsMessage message in allMessages) {
      if (isSpamMessage(message)) {
        String sender = '${message.address}';
        if (spamMessageThreads.containsKey(sender)) {
          spamMessageThreads[sender]!.add(message);
        } else {
          spamMessageThreads[sender] = [message];
        }
      }
    }
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
    if (body.contains('http://')) {
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
    if (body.length < 10) {
      return true;
    }

    // If none of the above criteria match, consider it not a spam message
    setState(() {
      isLoading = false;
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
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
            SizedBox(height: 10),
            Expanded(
              child: isLoading == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Loading Possible Spam Messages",
                            style: TextThemes(context).getTextStyle(
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  : spamMessageThreads.isEmpty
                      ? Center(
                          child: Text("No spam messages."),
                        )
                      : ListView.builder(
                          itemCount: spamMessageThreads.length,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            String sender =
                                spamMessageThreads.keys.toList()[index];
                            List<SmsMessage> messages =
                                spamMessageThreads[sender]!;
                            SmsMessage latestMessage = messages.last;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessageDetails(
                                        messages: messages,
                                        fullName: sender,
                                      ),
                                    ),
                                  );
                                },
                                child: SpamTile(
                                  fullname: sender,
                                  description: "${latestMessage.body}",
                                  date: latestMessage.date,
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
