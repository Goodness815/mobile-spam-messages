// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:messages/shared/constants/app_colors.dart';
import 'package:messages/shared/constants/app_icon.dart';
import 'package:messages/shared/themes/text_theme.dart';

class SpamTile extends StatefulWidget {
  String fullname;
  String description;
  int? date;
  SpamTile({
    super.key,
    required this.fullname,
    required this.description,
    required this.date,
  });

  @override
  State<SpamTile> createState() => _SpamTileState();
}

class _SpamTileState extends State<SpamTile> {
  formatDate() {
    int? timestamp = widget.date;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondaryTextColor.withOpacity(0.4),
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          top: 10,
        ),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: 4,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      child: Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColorFaint,
                    ),
                    child: Center(
                      child: Text(
                        widget.fullname.isNotEmpty
                            ? widget.fullname[0].toUpperCase()
                            : '',
                        style: TextThemes(context).getTextStyle(
                          fontSize: 20,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fullname,
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  AppIcons.spamSmall,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${formatDate()}',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
