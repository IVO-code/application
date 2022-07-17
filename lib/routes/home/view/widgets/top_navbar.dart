import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/routes/home/controllers/home_controller.dart';
import 'package:application/routes/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TopNavbar extends GetView<HomeController> {
  final bool login = true;
  const TopNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = itemList(context, size);
    /////////////
    list.removeAt(5);

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(0, 5),
                color: Constants.black.withAlpha(30))
          ],
          color: controller.getColor(),
        ),
        padding: EdgeInsets.only(
            top: size.width < 850 ? 5 : 20,
            bottom: size.width < 850 ? 5 : 20,
            left: size.width < 1024 ? 20 : 50,
            right: size.width < 1024 ? 8 : 40),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: size.width > 850
                ? list
                : [
                    SvgPicture.asset(
                      'lib/assets/image/Logo_simple.svg',
                      semanticsLabel: 'IVO',
                      width: 50,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    loginButton(),
                  ]),
      ),
    );
  }

  List<Widget> itemList(BuildContext context, Size size) {
    return [
      SvgPicture.asset(
        'lib/assets/image/Logo_simple.svg',
        semanticsLabel: 'IVO',
        width: 50,
      ),
      const SizedBox(
        width: 64,
        height: 1,
      ),
      CustomTextButton(
        title: "Explorar",
        icon: Icons.language,
        selected: 1111111 == 0,
        detailed: size.width > 1200,
        press: () {},
      ),
      CustomTextButton(
        title: "Cards de comunicação",
        icon: Icons.table_view,
        selected: 1111 == 1,
        detailed: size.width > 1200,
        press: () {},
      ),
      CustomTextButton(
        title: "Roteiros de atendimento",
        icon: Icons.content_paste,
        selected: 1111 == 2,
        detailed: size.width > 1200,
        press: () {},
      ),
      CustomTextButton(
        title: "Pacientes",
        icon: Icons.supervised_user_circle,
        selected: 1111 == 3,
        detailed: size.width > 1200,
        press: () {},
      ),
      const Spacer(
        flex: 2,
      ),
      loginButton(),
    ];
  }

  Widget loginButton() {
    return controller.obx(
      (state) => CustomTextButton(
        title: "Perfil",
        icon: Icons.person,
        filled: true,
        selected: false,
        color: Constants.background,
        detailed: false,
        press: () async {
          controller.toProfile();
        },
      ),
      onLoading: Center(
        child: CircularProgressIndicator(
          color: Constants.background,
        ),
      ),
      onError: (error) => CustomTextButton(
        title: "Fazer login",
        filled: true,
        selected: true,
        color: controller.getColor(),
        detailed: true,
        press: () async {
          controller.toAuthentication();
        },
      ),
    );
  }
}
