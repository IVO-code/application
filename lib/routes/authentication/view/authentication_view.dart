import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_field.dart';
import 'package:application/routes/authentication/controller/authentication_controller.dart';
import 'package:application/routes/authentication/view/pages/login_page.dart';
import 'package:application/routes/authentication/view/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  var size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: Constants.green,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 24, bottom: 24, left: 48, right: 48),
            child: size.width > 850
                ? Container() /*Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("IVO"),
                      Container(
                        width: 400,
                        child: form(context),
                      ),
                    ],
                  )*/
                : Center(
                    child: form(context),
                  ),
          ),
        ),
      ),
    );
  }

  Widget form(context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Obx(
            () => IndexedStack(
              index: controller.index.value,
              children: [
                LoginPage(index: controller.index),
                SignupPage(index: controller.index),
              ],
            ),
          ),
          Spacer(flex: 1),
          IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Get.back();
              },
              iconSize: size.width < 850 ? 60 : 80,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Constants.background,
              ))
        ]);
  }
}
