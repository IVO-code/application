import 'package:application/Util.dart';
import 'package:application/assets/grid/widget_grid_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class WidgetGrid extends GetView<WidgetGridController> {
  WidgetGrid(
      {Key? key, required List<Widget> items, required Function placeholder})
      : super(key: key) {
    Get.put(WidgetGridController(items: items, placeholder: placeholder));
    controller.reload(items, placeholder);
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ScrollConfiguration(
        behavior: MyBehavior(),
        child: Expanded(
            child: PreloadPageView.builder(
                controller: PreloadPageController(
                    viewportFraction: 0.85, initialPage: 4),
                itemCount: 9,
                preloadPagesCount: 9,
                itemBuilder: (context, mainIndex) {
                  return PreloadPageView.builder(
                      itemCount: 3,
                      preloadPagesCount: 3,
                      controller: controller.controllers[mainIndex],
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      onPageChanged: (page) {
                        controller.animatePage(page, mainIndex);
                      },
                      itemBuilder: (context, index) {
                        return controller.sections[mainIndex][index];
                      });
                })),
      ),
      onLoading: const Center(
        child: CircularProgressIndicator(
          color: Constants.background,
        ),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      controller: PreloadPageController(viewportFraction: 0.5, initialPage: 3),
      itemCount: 5,
      preloadPagesCount: 5,
      itemBuilder: (context, mainIndex) {
        
        );
      },
    );
  }*/
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
