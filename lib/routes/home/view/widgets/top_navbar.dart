import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/routes/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TopNavbar extends StatefulWidget {
  final Index index;
  final bool login;
  const TopNavbar({Key? key, required this.index, required this.login})
      : super(key: key);

  @override
  State<TopNavbar> createState() => _TopNavbarState();
}

class _TopNavbarState extends State<TopNavbar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = itemList(context, size);
    if (widget.login) {
      list.removeAt(5);
    }
    return Container(
      color: widget.index.colors[widget.index.index],
      padding: EdgeInsets.only(
          top: size.width < 850 ? 12 : 20,
          bottom: size.width < 850 ? 12 : 20,
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
                  mainButton(context),
                ]),
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
        selected: widget.index.index == 0,
        detailed: size.width > 1200,
        press: () {
          setState(() {
            widget.index.index = 0;
            widget.index.notifyParent!();
          });
        },
      ),
      CustomTextButton(
        title: "Cards de comunicação",
        icon: Icons.table_view,
        selected: widget.index.index == 1,
        detailed: size.width > 1200,
        press: () {
          widget.index.index = 1;
          widget.index.notifyParent!();
        },
      ),
      CustomTextButton(
        title: "Roteiros de atendimento",
        icon: Icons.content_paste,
        selected: widget.index.index == 2,
        detailed: size.width > 1200,
        press: () {
          widget.index.index = 2;
          widget.index.notifyParent!();
        },
      ),
      CustomTextButton(
        title: "Pacientes",
        icon: Icons.supervised_user_circle,
        selected: widget.index.index == 3,
        detailed: size.width > 1200,
        press: () {
          widget.index.index = 3;
          widget.index.notifyParent!();
        },
      ),
      const Spacer(
        flex: 2,
      ),
      mainButton(context),
    ];
  }

  Widget mainButton(BuildContext context) {
    return CustomTextButton(
      title: widget.login ? "Fazer login" : "Perfil",
      icon: widget.login ? null : Icons.person,
      filled: true,
      selected: widget.login,
      color: widget.login
          ? widget.index.colors[widget.index.index]
          : Constants.background,
      detailed: widget.login,
      press: () {
        Color color = widget.index.colors[widget.index.index];
        String colorString = color.toString(); // Color(0x12345678)
        String valueString = colorString.split('(0x')[1].split(')')[0];
        if (widget.login) {
          Get.toNamed("/authentication",
              arguments: [valueString, widget.index.index]);
        } else {
          Get.toNamed("/profile", arguments: [valueString, widget.index.index]);
        }
      },
    );
  }
}
