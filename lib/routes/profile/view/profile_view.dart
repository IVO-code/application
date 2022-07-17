import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_field.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/user_model.dart';
import 'package:application/routes/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  var size, arguments;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    loadColor();

    return controller.obx(
      (state) => Scaffold(
        backgroundColor: Constants.background,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: controller.color,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 230,
                      ),
                      Text(state.username,
                          style: GoogleFonts.raleway(
                              color: Constants.background,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        state.email,
                        style: GoogleFonts.raleway(
                          color: Constants.background,
                          fontSize: 12,
                        ),
                      ),
                    ]),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Constants.background, boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(0, 4),
                      color: Constants.black.withAlpha(70))
                ]),
                height: 170,
                alignment: Alignment.topCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                        color: controller.color,
                      ),
                      settingsMenu(
                        menuList: [
                          PopupMenuItem(
                              height: 24,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 14,
                                    color: controller.color,
                                  ),
                                  Text("Meus dados",
                                      style: GoogleFonts.raleway(
                                          fontSize: 12,
                                          color: controller.color,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                          PopupMenuItem(
                              height: 24,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.picture_as_pdf,
                                    size: 14,
                                    color: controller.color,
                                  ),
                                  Text("Relatório",
                                      style: GoogleFonts.raleway(
                                        fontSize: 12,
                                        color: controller.color,
                                      )),
                                ],
                              )),
                          PopupMenuDivider(),
                          PopupMenuItem(
                              height: 24,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    size: 14,
                                    Icons.logout,
                                    color: controller.color,
                                  ),
                                  Text("Sair",
                                      style: GoogleFonts.raleway(
                                        fontSize: 12,
                                        color: controller.color,
                                      )),
                                ],
                              ),
                              onTap: () {
                                controller.logout();
                              }),
                        ],
                        icon: Icon(Icons.settings),
                        color: controller.color,
                      ),
                    ]),
              ),
              Positioned(
                  top: 90,
                  child: Material(
                    borderRadius: BorderRadius.circular(100),
                    elevation: 6,
                    child: CircleAvatar(
                      radius: 64,
                      foregroundImage:
                          NetworkImage("https://i.imgur.com/rGlllm8.png"),
                    ),
                  ))
            ],
          ),
        ),
      ),
      onLoading: Scaffold(
          backgroundColor: controller.color,
          body: Center(
            child: CircularProgressIndicator(
              color: Constants.background,
            ),
          )),
      onError: (error) => Scaffold(
          backgroundColor: controller.color,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "OPS!",
                  style: GoogleFonts.raleway(
                      color: Constants.background,
                      fontWeight: FontWeight.bold,
                      fontSize: 70),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Constants.background,
                      size: 25,
                    ),
                    Text(
                      "    Houve um problema!",
                      style: GoogleFonts.raleway(
                          color: Constants.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
                Obx(() => Text(
                      "Redirecionando em ${controller.redirect.value}",
                      style: GoogleFonts.raleway(
                          color: Constants.background, fontSize: 22),
                    )),
              ],
            ),
          )),
    );
  }

  Widget settingsMenu(
      {required List<PopupMenuEntry> menuList,
      required Icon icon,
      required Color color}) {
    return PopupMenuButton(
      offset: Offset(0, 40),
      color: Constants.background.withAlpha(240),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      )),
      itemBuilder: ((context) => menuList),
      //color: color,
      icon: Icon(
        Icons.settings,
        color: color,
      ),
    );
  }

  void loadColor() {
    arguments = Get.arguments;
    String arg = (arguments != null && !(arguments is int))
        ? arguments[0] as String
        : "";

    controller.setColor(arg);
  }

  //Widget signup(context) {}
}
