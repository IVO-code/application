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
  late Color? color;
  late Random rnd;
  late double d1, d2, d3, d4;
  late int bubbles;
  late BoxFit fit;
  Background(
      {this.color = null, this.bubbles = 5, this.fit = BoxFit.fitHeight}) {
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
        backgroundColor: Colors.transparent,
        body: Container(
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    child: GetBuilder<PagesController>(builder: (_) {
                      return Stack(children: _getAnimations(context));
                    }),
                  ),
                ))));
  }

  _getAnimations(context) {
    Size size = MediaQuery.of(context).size;
    var list = [
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
                  color:
                      color == null ? Constants.orange : Constants.background),
            ),
          )),
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
                  color:
                      color == null ? Constants.green : Constants.background),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * .5,
            left: size.width * (controller.animation2.value + d2),
            child: CustomPaint(
              painter: MyPainter(
                  radius: 30,
                  color: color == null
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
            left: size.width * (controller.animation1.value + d3),
            child: CustomPaint(
              painter: MyPainter(
                  radius: 60,
                  color:
                      color == null ? Constants.purple : Constants.background),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * (controller.animation2.value + .58),
            left: size.width * .21,
            child: CustomPaint(
              painter: MyPainter(
                  radius: 50,
                  color: color == null ? Constants.pink : Constants.background),
            ),
          )),
    ];
    list.removeRange(bubbles, list.length);
    return list;
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
