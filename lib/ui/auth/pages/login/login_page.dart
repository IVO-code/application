import 'package:application/assets/widgets/custom_text_field.dart';
import 'package:application/util.dart';
import 'package:application/ui/auth/pages/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends GetView<LoginController> {
  final RxInt index;
  LoginPage({Key? key, required this.index}) : super(key: key) {
    Get.put(LoginController(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          controller.greeting(),
          style: GoogleFonts.raleway(
              color: Constants.background,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Vamos começar?",
          style: GoogleFonts.raleway(
              color: Constants.background,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12,
        ),
        CustomTextField(
          text_controller: controller.username,
          hint: "Usuário",
          background: Constants.background,
          color: Constants.green,
        ),
        CustomTextField(
          text_controller: controller.password,
          hint: "Senha",
          background: Constants.background,
          color: Constants.green,
          password: true,
        ),
        SizedBox(
          height: 5,
        ),
        controller.obx(
          (state) => Container(),
          onError: ((error) => error == "login"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: Constants.background,
                      size: 15,
                    ),
                    Text("  Usuário ou senha inválido!",
                        style: GoogleFonts.raleway(
                            color: Constants.background,
                            fontSize: 15,
                            fontWeight: FontWeight.bold))
                  ],
                )
              : Container()),
          onEmpty: Container(),
          onLoading: Container(),
        ),
        controller.obx((state) => loginButton(context),
            onEmpty: loginButton(context),
            onError: (error) => loginButton(context),
            onLoading: Padding(
                padding: EdgeInsets.all(14),
                child: CircularProgressIndicator(
                  color: Constants.background,
                ))),
        SizedBox(
          height: 24,
        ),
        Row(children: <Widget>[
          Expanded(
              child: Divider(
            color: Constants.background.withAlpha(200),
          )),
          Text(
            "   Ou   ",
            style: GoogleFonts.raleway(
                color: Constants.background.withAlpha(200),
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Divider(
            color: Constants.background.withAlpha(200),
          )),
        ]),
        signUpButton(context),
      ],
    );
  }

  Widget loginButton(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        controller.login();
      },
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          color: Constants.green,
          border: NeumorphicBorder(color: Constants.background, width: 3),
          shadowLightColor: Constants.green),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "Entrar",
          textScaleFactor: 1.2,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFF6F6F7)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.login,
            size: 20,
            color: Color(0xFFF6F6F7),
          ),
        )
      ]),
    );
  }

  Widget signUpButton(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        controller.signup();
      },
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          color: Constants.green,
          border: NeumorphicBorder(
              color: Constants.background.withAlpha(200), width: 1),
          shadowLightColor: Constants.green.withAlpha(100),
          shadowDarkColor: Colors.black.withAlpha(100)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Registre-se",
          textScaleFactor: 1.2,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Constants.background.withAlpha(200)),
        ),
      ]),
    );
  }
}
