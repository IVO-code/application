import 'dart:ui';
import 'dart:math';
import 'package:application/util.dart';
import 'package:application/ui/home/pages/pages_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Background extends GetView<PagesController> {
  Random rnd = Random();

  late int bubbles;
  late bool flat;
  late BoxFit fit;
  late Color? color;

  late double? w1, w2, w3, w4, w5;
  late double? h1, h2, h3, h4, h5;

  Background(
      {this.color = null,
      this.bubbles = 5,
      this.fit = BoxFit.fitHeight,
      this.flat = false,
      this.w1,
      this.w2,
      this.w3,
      this.w4,
      this.w5,
      this.h1,
      this.h2,
      this.h3,
      this.h4,
      this.h5}) {
    w1 ??= rnd.nextDouble();
    w2 ??= rnd.nextDouble();
    w3 ??= rnd.nextDouble();
    w4 ??= rnd.nextDouble();
    w5 ??= rnd.nextDouble();
    h1 ??= rnd.nextDouble();
    h2 ??= rnd.nextDouble();
    h3 ??= rnd.nextDouble();
    h4 ??= rnd.nextDouble();
    h5 ??= rnd.nextDouble();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: GetBuilder<PagesController>(builder: (_) {
                  return Stack(children: _getAnimations(context));
                }),
              ),
            )));
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
            top: size.height * h4!,
            left: size.width * w4!,
            child: CustomPaint(
              painter: MyPainter(
                  radius: controller.animation4.value,
                  flat: flat,
                  color: color == null ? Constants.orange : color!),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * h1!,
            left: size.width * w1!,
            child: CustomPaint(
              painter: MyPainter(
                  radius: controller.animation4.value - 30,
                  flat: flat,
                  color: color == null ? Constants.green : color!),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * h5!,
            left: size.width * (controller.animation2.value + w5!),
            child: CustomPaint(
              painter: MyPainter(
                  radius: 30,
                  flat: flat,
                  color: color == null ? Constants.turquoise : color!),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * controller.animation3.value,
            left: size.width * (controller.animation1.value + w3!),
            child: CustomPaint(
              painter: MyPainter(
                  radius: 60,
                  flat: flat,
                  color: color == null ? Constants.purple : color!),
            ),
          )),
      AnimatedBuilder(
          animation: controller.animation2,
          builder: (context, child) {
            return child!;
          },
          child: Positioned(
            top: size.height * (controller.animation2.value + h2!),
            left: size.width * w2!,
            child: CustomPaint(
              painter: MyPainter(
                  radius: 50,
                  flat: flat,
                  color: color == null ? Constants.pink : color!),
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
  final bool flat;
  final Color color;

  MyPainter({required this.radius, required this.color, this.flat = false});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = LinearGradient(colors: [
        color.withAlpha(flat ? 255 : 75),
        color.withAlpha(flat ? 255 : 20)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
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
