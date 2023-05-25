import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:risk_surveyor_app/utils/app_dimension.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(5.0 * AppDimension.blockSizeVertical);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 4.w,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.oonaPurple,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/MicrosoftTeams-image.png',
            height: 10.h,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: (kIsWeb) ? 6.sp : 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/images/oona logo-vertical-oona purple on Transparent.png',
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
