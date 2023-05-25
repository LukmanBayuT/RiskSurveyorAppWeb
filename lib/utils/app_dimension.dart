import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppDimension {
    static double screenWidth = Get.context!.width;
    static double screenHeight = Get.context!.height;
    static double blockSizeHorizontal = screenWidth / 100;
    static double blockSizeVertical = screenHeight / 100;

    static final double _safeAreaHorizontal = Get.context!.mediaQueryPadding.left + Get.context!.mediaQueryPadding.right;
    static final double _safeAreaVertical = Get.context!.mediaQueryPadding.top + Get.context!.mediaQueryPadding.bottom;
    static double safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    static double safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    static EdgeInsets mainPadding = EdgeInsets.only(top: 2.h, bottom: 8.h, left: 4.w, right: 4.w);
    static double fontSizeSmall = 8.sp;
}
