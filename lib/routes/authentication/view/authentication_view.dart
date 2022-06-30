import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_field.dart';
import 'package:application/routes/authentication/controller/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationView extends StatefulWidget {
  final controller = Get.put(AuthenticationController());

  AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  Color c = Constants.green;
  var size, arguments;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    arguments = Get.arguments;
    String color = (arguments != null && !(arguments is int))
        ? arguments[0] as String
        : "";
    c = color != "" ? Color(int.parse(color, radix: 16)) : Constants.green;
    return Container(
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: c,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 24, bottom: 24, left: 48, right: 48),
            child: size.width > 850
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("IVO"),
                      Container(
                        width: 400,
                        child: form(context),
                      ),
                    ],
                  )
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
          tabs(context),
          Spacer(),
          login(context),
          Spacer(flex: 1),
          IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                widget.controller.reset();
                Get.toNamed("/",
                    arguments: (arguments != null) ? arguments[1] : 0);
              },
              iconSize: size.width < 850 ? 60 : 80,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Constants.background,
              ))
        ]);
  }

  Widget tabs(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          press: () {},
          detailed: true,
          selected: true,
          filled: false,
          title: "Entrar no sistema",
          icon: Icons.login,
        ),
        CustomTextButton(
          press: () {},
          detailed: false,
          selected: false,
          color: Constants.background,
          title: "Registrar-se",
          icon: Icons.person_add_alt_rounded,
        ),
      ],
    );
  }

  Widget login(context) {
    return Column(
      children: [
        widget.controller.obx(
          (state) => Container(),
          onError: ((error) => error == "login"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: Constants.background,
                    ),
                    Text("  Usuário ou senha inválidos!",
                        style: GoogleFonts.raleway(
                            color: Constants.background, fontSize: 18))
                  ],
                )
              : Container()),
          onEmpty: Container(),
          onLoading: Container(),
        ),
        CustomTextField(
          text_controller: widget.controller
              .usernameEditingController, //controller.usernameEditingController,
          hint: "Usuário",
          background: Constants.background,
          color: c,
        ),
        CustomTextField(
          text_controller: widget.controller
              .passwordEditingController, //controller.passwordEditingController,
          hint: "Senha",
          background: Constants.background,
          color: c,
          password: true,
        ),
        widget.controller.obx((state) => loginButton(context),
            onEmpty: loginButton(context),
            onError: (error) => loginButton(context),
            onLoading: Padding(
                padding: EdgeInsets.all(14),
                child: CircularProgressIndicator(
                  color: Constants.background,
                ))),
      ],
    );
  }

  Widget loginButton(BuildContext context) {
    if (widget.controller.status.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed("/", arguments: (arguments != null) ? arguments[1] : 0);
        // Add Your Code here.
      });
    }
    return NeumorphicButton(
      onPressed: () {
        widget.controller.login();
        //Get.toNamed("/", arguments: (arguments != null) ? arguments[1] : 0);
      },
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          color: c,
          border: NeumorphicBorder(color: Constants.background, width: 3),
          shadowLightColor: c),
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

  //Widget signup(context) {}
}
