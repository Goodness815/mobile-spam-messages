// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messages/shared/constants/app_colors.dart';
import 'package:messages/shared/constants/app_icon.dart';
import 'package:messages/shared/themes/text_theme.dart';

class StarredTile extends StatelessWidget {
  String fullname;
  String description;
  String date;
  StarredTile({
    super.key,
    required this.fullname,
    required this.description,
    required this.date,
  });

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
                        fullname.isNotEmpty ? fullname[0].toUpperCase() : '',
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
                          fullname,
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
                          description,
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
                  AppIcons.starredSmall,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  date,
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
