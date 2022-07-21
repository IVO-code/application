import 'package:application/assets/constants.dart';
import 'package:application/routes/authentication/controller/authentication_controller.dart';
import 'package:application/routes/authentication/controller/login_controller.dart';
import 'package:application/routes/home/controllers/home_controller.dart';
import 'package:application/routes/home/controllers/pages_controller.dart';
import 'package:application/routes/home/view/pages/cards/cards_page.dart';
import 'package:application/routes/home/view/pages/explore/explore_page.dart';
import 'package:application/routes/home/view/pages/patients/patients_page.dart';
import 'package:application/routes/home/view/pages/script/script_page.dart';
import 'package:application/routes/home/view/widgets/background.dart';
import 'package:application/routes/home/view/widgets/bottom_navbar.dart';
import 'package:application/routes/home/view/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.put(PagesController());

    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: controller.getColorx(controller.index.value),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.lerp(
                          controller.index.value == 0
                              ? Constants.background
                              : controller.getColor(),
                          Constants.black,
                          0.1)!,
                      controller.index.value == 0
                          ? Constants.background
                          : controller.getColor(),
                    ])),
              ),
              AnimatedPositioned(
                bottom: 0,
                top: 0,
                curve: Curves.easeOutCubic,
                left: -1 * (controller.index.value * 400) - 40,
                child: Image.asset(
                  "lib/assets/image/background.png",
                  colorBlendMode: BlendMode.overlay,
                ),
                duration: Duration(seconds: 1),
              ),
              Background(
                color:
                    controller.index.value == 0 ? null : controller.getColor(),
              ),
              Container(
                width: size.width,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 60),
                child: Theme(
                  data: ThemeData(
                    accentColor: controller.getColorx(controller.index.value),
                  ),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      allowImplicitScrolling: false,
                      controller: controller.pageController,
                      children: <Widget>[
                        Obx(() => ExplorePage(
                            color:
                                controller.getColorx(controller.index.value))),
                        Obx(() => CardsPage(
                            color:
                                controller.getColorx(controller.index.value))),
                        Obx(() => ScriptPage(
                            color:
                                controller.getColorx(controller.index.value))),
                        Obx(() => PatientsPage(
                            color:
                                controller.getColorx(controller.index.value))),
                      ],
                    ),
                  ),
                ),
              ),
              TopNavbar(),
              size.width <= 850
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: controller.obx((state) => menuList(),
                          onEmpty: menuList(),
                          onError: (error) => Container(),
                          onLoading: Container()),
                    )
                  : Container()
            ],
          ),
        )));
  }

  Widget menuList() {
    return Obx(() => BottomNavbar(
          items: [
            BottomNavbarItem(
              icon: Icon(Icons.language),
              title: Text('Explorar'),
              activeColor: controller.colors[0],
              inactiveColor: Constants.inactive,
              textAlign: TextAlign.center,
            ),
            BottomNavbarItem(
              icon: Icon(Icons.table_view),
              title: Text('Cards'),
              activeColor: controller.colors[1],
              inactiveColor: Constants.inactive,
              textAlign: TextAlign.center,
            ),
            BottomNavbarItem(
              icon: Icon(Icons.content_paste),
              title: Text('Roteiros'),
              activeColor: controller.colors[2],
              inactiveColor: Constants.inactive,
              textAlign: TextAlign.center,
            ),
            BottomNavbarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text('Pacientes'),
              activeColor: controller.colors[3],
              inactiveColor: Constants.inactive,
              textAlign: TextAlign.center,
            ),
          ],
          selectedIndex: controller.index.value,
          onItemSelected: (i) => controller.setIndex(i),
        ));
  }
}
