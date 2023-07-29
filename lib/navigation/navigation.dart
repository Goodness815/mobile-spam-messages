// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messages/messages/messages.dart';
import 'package:messages/settings/settings.dart';
import 'package:messages/shared/constants/app_icon.dart';
import 'package:messages/spam/spam.dart';
import 'package:messages/starred/starred.dart';
import '../shared/constants/app_colors.dart';
import '../shared/constants/app_strings.dart';
import '../shared/themes/text_theme.dart';

class BaseBottomNavigation extends StatefulWidget {
  const BaseBottomNavigation({super.key});

  @override
  State<BaseBottomNavigation> createState() => _BaseBottomNavigationState();
}

class _BaseBottomNavigationState extends State<BaseBottomNavigation> {
  int? active = 0;

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    MessagesScreen(),
    StarredScreen(),
    SpamScreen(),
    settingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        selectedLabelStyle: TextThemes(context).getTextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextThemes(context).getTextStyle(
          fontWeight: FontWeight.w500,
        ),
        items: [
          _bottomNavItem(
            AppIcons.message,
            AppStrings.messages,
            _selectedIndex,
            0,
          ),
          _bottomNavItem(
            AppIcons.starred,
            AppStrings.starred,
            _selectedIndex,
            1,
          ),
          _bottomNavItem(
            AppIcons.spam,
            AppStrings.spam,
            _selectedIndex,
            2,
          ),
          _bottomNavItem(
            AppIcons.settings,
            AppStrings.settings,
            _selectedIndex,
            3,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _bottomNavItem(
  String imagePath,
  String label,
  int selectedIndex,
  int navIndex,
) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      imagePath,
      color: selectedIndex == navIndex ? AppColors.primaryColor : null,
    ),
    label: label,
  );
}
