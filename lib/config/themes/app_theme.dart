import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme(){
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    primarySwatch: Colors.purple,
    hintColor: AppColors.hint,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    brightness: Brightness.light,
    appBarTheme:  AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontFamily: 'Montserrat',
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.primaryColor,
      ),
    ),
    fontFamily: 'Montserrat',
    textTheme:   TextTheme(
      headline5: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 20.sp,
        shadows: [
          Shadow(
            color: Colors.black38,
            offset: const Offset(0, 4),
            blurRadius: 10.r,
          ),
        ],
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(
        color: AppColors.textBlack,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        color: AppColors.hint,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ));
}