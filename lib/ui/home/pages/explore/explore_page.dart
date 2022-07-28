import 'dart:math';
import 'dart:ui';

import 'package:application/assets/grid/item_card.dart';
import 'package:application/assets/grid/widget_grid.dart';
import 'package:application/ui/home/pages/api_controller.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/util.dart';
import 'package:application/ui/sections/section_script.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends GetView<ApiController> {
  late Color color;

  ExplorePage({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: controller.obx(
            (state) => Stack(
                  fit: StackFit.expand,
                  children: [
                    Obx(() => WidgetGrid(
                        items: controller.explore.toList(),
                        placeholder: () => Opacity(
                            opacity: 0.02 + (Random().nextInt(15) / 100),
                            child: ItemCard(
                              child: Container(),
                            )))),
                  ],
                ),
            onLoading: Center(
              child: CircularProgressIndicator(
                color: Constants.background,
              ),
            )));
  }
}
