import 'dart:ui';
import 'dart:math';
import 'package:application/assets/constants.dart';
import 'package:application/routes/home/controllers/pages_controller.dart';
import 'package:application/routes/home/view/pages/cards/widgets/category_boxes.dart';
import 'package:application/routes/home/view/pages/cards/widgets/discover_card.dart';
import 'package:application/routes/home/view/pages/cards/widgets/discover_small_card.dart';
import 'package:application/routes/home/view/widgets/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Background extends GetView<PagesController> {
  late Color color;
  late String image;
  late Random rnd;
  late double d1, d2, d3, d4;
  late bool white;
  Background({
    required this.color,
    required this.image,
    this.white = false,
  }) {
    rnd = Random();
    d1 = rnd.nextDouble();
    d2 = rnd.nextDouble();
    d3 = rnd.nextDouble();
    d4 = rnd.nextDouble();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(this.image),
                    fit: BoxFit.fitHeight,
                    colorFilter: white
                        ? ColorFilter.mode(color, BlendMode.dst)
                        : ColorFilter.mode(color, BlendMode.overlay),
                    alignment: Alignment.bottomCenter),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(white ? Constants.background : color,
                          Constants.black, 0.1)!,
                      white ? Constants.background : color,
                    ])),
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    child: GetBuilder<PagesController>(builder: (_) {
                      return Stack(children: [
                        AnimatedBuilder(
                            animation: controller.animation2,
                            builder: (context, child) {
                              return child!;
                            },
                            child: Positioned(
                              top: size.height * .9,
                              left: size.width * d1,
                              child: CustomPaint(
                                painter: MyPainter(
                                    radius: controller.animation4.value - 30,
                                    color: white
                                        ? Constants.green
                                        : Constants.background),
                              ),
                            )),
                        AnimatedBuilder(
                            animation: controller.animation2,
                            builder: (context, child) {
                              return child!;
                            },
                            child: Positioned(
                              top: size.height * .5,
                              left: size.width *
                                  (controller.animation2.value + d2),
                              child: CustomPaint(
                                painter: MyPainter(
                                    radius: 30,
                                    color: white
                                        ? Constants.turquoise
                                        : Constants.background),
                              ),
                            )),
                        AnimatedBuilder(
                            animation: controller.animation2,
                            builder: (context, child) {
                              return child!;
                            },
                            child: Positioned(
                              top: size.height * controller.animation3.value,
                              left: size.width *
                                  (controller.animation1.value + d3),
                              child: CustomPaint(
                                painter: MyPainter(
                                    radius: 60,
                                    color: white
                                        ? Constants.purple
                                        : Constants.background),
                              ),
                            )),
                        AnimatedBuilder(
                            animation: controller.animation2,
                            builder: (context, child) {
                              return child!;
                            },
                            child: Positioned(
                              top: size.height * .1,
                              left: size.width * d4,
                              child: CustomPaint(
                                painter: MyPainter(
                                    radius: controller.animation4.value,
                                    color: white
                                        ? Constants.orange
                                        : Constants.background),
                              ),
                            )),
                        AnimatedBuilder(
                            animation: controller.animation2,
                            builder: (context, child) {
                              return child!;
                            },
                            child: Positioned(
                              top: size.height *
                                  (controller.animation2.value + .58),
                              left: size.width * .21,
                              child: CustomPaint(
                                painter: MyPainter(
                                    radius: 50,
                                    color: white
                                        ? Constants.pink
                                        : Constants.background),
                              ),
                            )),
                      ]);
                    }),
                  ),
                ))));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// to control with shape circle ///
class MyPainter extends CustomPainter {
  final double radius;
  final Color color;

  MyPainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = LinearGradient(
              colors: [color.withAlpha(75), color.withAlpha(20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
