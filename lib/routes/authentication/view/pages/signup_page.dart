import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_field.dart';
import 'package:application/routes/authentication/controller/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends GetView<SignupController> {
  final RxInt index;
  SignupPage({Key? key, required this.index}) : super(key: key) {
    Get.put(SignupController(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          text_controller:
              controller.username, //controller.usernameEditingController,
          hint: "Nome de usuário",
          background: Constants.background,
          color: Constants.green,
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
        controller.obx(
            (state) => customButton("Cadastrar", true, onPressed: () {
                  controller.setUsername();
                }),
            onEmpty: customButton("Cadastrar", true, onPressed: () {
              controller.setUsername();
            }),
            onError: (error) => customButton("Cadastrar", true, onPressed: () {
                  controller.setUsername();
                }),
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
            "   Já possui um cadastro?   ",
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
        customButton("Faça login", false, onPressed: () {
          controller.login();
        }),
      ],
    );
  }

  Widget customButton(String title, bool scale,
      {required VoidCallback onPressed}) {
    return NeumorphicButton(
      onPressed: onPressed,
      margin: EdgeInsets.only(top: 16),
      padding: scale
          ? EdgeInsets.symmetric(horizontal: 12, vertical: 12)
          : EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          color: Constants.green,
          border: NeumorphicBorder(
              color: Constants.background.withAlpha(200), width: scale ? 3 : 1),
          shadowLightColor: Constants.green,
          shadowDarkColor: Colors.black.withAlpha(100)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title,
          textScaleFactor: 1.2,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Constants.background.withAlpha(scale ? 255 : 200)),
        ),
      ]),
    );
  }
}
