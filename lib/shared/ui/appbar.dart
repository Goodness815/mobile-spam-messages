import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/shared/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        borderRadius: BorderRadius.circular(80),
        onTap: () => Navigator.of(context).pop(),
        child: SvgPicture.asset(
          'images/arrow-left.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
      centerTitle: false,
      title: Text(
        title,
        style: GoogleFonts.outfit(
          color: Color(0xff161616),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      actions: [
        // Add your icon widget here
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: SvgPicture.asset(
            'images/more.svg',
            fit: BoxFit.scaleDown,
            color: AppColors.primaryColor,
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
