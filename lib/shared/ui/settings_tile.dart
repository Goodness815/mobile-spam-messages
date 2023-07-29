// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';
import '../constants/app_icon.dart';
import '../themes/text_theme.dart';

class SettingsTiles extends StatelessWidget {
  String buttonValue;

  String iconValue;

  String descripionValue;

  SettingsTiles(
      {super.key,
      required this.buttonValue,
      required this.iconValue,
      required this.descripionValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: AppColors.inactiveTextFormFieldColor, width: 1.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          bottom: 15,
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconValue,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonValue,
                      style: FormTextThemes(context).getFormTextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      descripionValue,
                      style: FormTextThemes(context).getFormTextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(
              AppIcons.arrowRight,
              color: AppColors.secondaryTextColor,
            )
          ],
        ),
      ),
    );
  }
}
