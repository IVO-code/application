import 'package:application/model/attendance_model.dart';
import 'package:application/util.dart';
import 'package:application/ui/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key) {
    Get.put<ProfileController>(ProfileController());
  }
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
                      foregroundImage: NetworkImage(
                          "https://res.cloudinary.com/ivo-code/image/upload/v1658409408/perfil_olilf2.jpg"),
                    ),
                  )),
              Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
                  child: Text("Respostas cadastradas",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                          fontSize: 26,
                          color: Constants.background,
                          fontWeight: FontWeight.bold))),
              Obx(() => controller.attendances.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 400),
                      itemCount: controller.attendances.length,
                      itemBuilder: ((context, index) => ListTile(
                            tileColor: Constants.background,
                            title: Text(
                                controller.attendances[index].card!.title!.text,
                                style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    color: Constants.background,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Resposta: ${controller.attendances[index].option!.text}",
                                style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    color: Constants.background,
                                    fontWeight: FontWeight.bold)),
                          )))
                  : Container())
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
