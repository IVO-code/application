import 'dart:ui';

import 'package:application/assets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends GetView {
  late Widget child;
  late bool glass;
  late double opacity;
  double circularity = 60;
  ItemCard({required this.child, this.glass = true, this.opacity = 0.50});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
      child: glass
          ? ClipRRect(
              borderRadius: BorderRadius.circular(circularity),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Constants.background.withAlpha(70))
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Constants.background.withOpacity(opacity + 0.25),
                        Constants.background.withOpacity(opacity),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(circularity),
                    border: Border.all(
                      width: 2,
                      color: Constants.background.withOpacity(opacity + 0.05),
                    ),
                  ),
                  child: child,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
              decoration: BoxDecoration(
                  color: Constants.background,
                  borderRadius: BorderRadius.circular(circularity),
                  border: Border.all(
                    width: 2,
                    color: Constants.background.withOpacity(0.20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        offset: Offset(-4, 4),
                        color: Constants.black.withAlpha(30))
                  ]),
              child: child,
            ),
    );
  }
}
