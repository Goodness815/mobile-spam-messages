// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:messages/messages/dummy_data.dart';
import 'package:messages/messages/message_details.dart';
import 'package:messages/shared/constants/app_colors.dart';
import 'package:messages/shared/themes/text_theme.dart';
import 'package:messages/shared/ui/message_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telephony/telephony.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> allMessages = [];
  Map<String, List<SmsMessage>> messageThreads = {};

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
      _groupMessagesIntoThreads();
    });
  }

  void _groupMessagesIntoThreads() {
    messageThreads.clear();
    for (SmsMessage message in allMessages) {
      String? sender = message.address;
      if (messageThreads.containsKey(sender)) {
        messageThreads[sender]!.add(message);
      } else {
        messageThreads['$sender'] = [message];
      }
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Good $greeting',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 27,
                    ),
                  ),
                  SizedBox(height: 20),
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
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
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
            SizedBox(height: 10),
            Expanded(
              child: allMessages.isEmpty
                  ? ListView.builder(
                      itemCount: 7,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryTextColor
                                    .withOpacity(0.4),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Shimmer.fromColors(
                            baseColor:
                                AppColors.secondaryTextColor.withOpacity(0.25),
                            highlightColor: Colors.white,
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 47,
                                  height: 47,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryTextColor,
                                    borderRadius: BorderRadius.circular(
                                      300,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 47,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryTextColor,
                                        borderRadius: BorderRadius.circular(
                                          7,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 97,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryTextColor,
                                        borderRadius: BorderRadius.circular(
                                          7,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: messageThreads.length,
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        String sender = messageThreads.keys.toList()[index];
                        List<SmsMessage> messages = messageThreads[sender]!;
                        SmsMessage latestMessage = messages.first;
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
                            child: MessageTile(
                              fullname: sender,
                              description: latestMessage.body,
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
