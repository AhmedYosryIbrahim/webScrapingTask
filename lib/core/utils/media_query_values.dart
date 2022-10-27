import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  double get topPadding => MediaQuery.of(this).padding.top;

  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  double get leftPadding => MediaQuery.of(this).padding.left;

  double get rightPadding => MediaQuery.of(this).padding.right;

  double get horizontalPadding => leftPadding + rightPadding;

  double get verticalPadding => topPadding + bottomPadding;

  double get safeAreaHorizontalPadding =>
      MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;

  double get safeAreaVerticalPadding =>
      MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;

  double get safeAreaLeftPadding => MediaQuery.of(this).padding.left;

  double get safeAreaRightPadding => MediaQuery.of(this).padding.right;

  double get safeAreaTopPadding => MediaQuery.of(this).padding.top;

  double get safeAreaBottomPadding => MediaQuery.of(this).padding.bottom;

  double get safeAreaWidth =>
      width -
      MediaQuery.of(this).padding.left -
      MediaQuery.of(this).padding.right;

  double get safeAreaHeight =>
      height -
      MediaQuery.of(this).padding.top -
      MediaQuery.of(this).padding.bottom;
}
