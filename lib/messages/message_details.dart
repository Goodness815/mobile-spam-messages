import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messages/messages/sms_message_model.dart';
import 'package:messages/shared/constants/app_colors.dart';
import 'package:messages/shared/themes/text_theme.dart';
import 'package:messages/shared/ui/appbar.dart';
import 'package:telephony/telephony.dart';

class MessageDetails extends StatefulWidget {
  List<SmsMessage> messages;
  String fullName;
  MessageDetails({required this.messages, required this.fullName});

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.fullName,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(51, 208, 208, 208).withOpacity(0.4),
                  width: 1.0,
                ),
              ),
            ),
          ),
          Expanded(
            // Use Expanded to make ListView take the remaining available height
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                SmsMessage message = widget.messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${message.body}',
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              formatDate(message.date),
                              overflow: TextOverflow.ellipsis,
                              style: TextThemes(context).getTextStyle(
                                color: AppColors.primaryColorFaint,
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(int? timestamp) {
    if (timestamp == null) {
      return 'Unknown Date';
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
