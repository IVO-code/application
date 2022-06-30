import 'package:application/assets/constants.dart';
import 'package:application/routes/authentication/controller/authentication_controller.dart';
import 'package:application/routes/home/view/pages/cards/cards_page.dart';
import 'package:application/routes/home/view/pages/explore/explore_page.dart';
import 'package:application/routes/home/view/widgets/bottom_navbar.dart';
import 'package:application/routes/home/view/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  var authenticationController = Get.put(AuthenticationController());

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Index index =
      Index(index: Get.arguments != null ? Get.arguments as int : 0);

  @override
  Widget build(BuildContext context) {
    widget.authenticationController.hasLogin();
    Size size = MediaQuery.of(context).size;

    index.notifyParent = () {
      setState(() {});
    };

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: index.colors[index.index],
        body: SafeArea(
            child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (size.width < 850) {
              if (details.primaryVelocity! > 0 && index.index != 0) {
                index.index--;
                index.notifyParent!();
              }
              if (details.primaryVelocity! < 0 && index.index != 3) {
                index.index++;
                index.notifyParent!();
              }
            }
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              bodyPage(context),
              widget.authenticationController.obx(
                  (state) => TopNavbar(
                        index: index,
                        login: false,
                      ),
                  onEmpty: TopNavbar(
                    index: index,
                    login: false,
                  ),
                  onError: (error) => TopNavbar(
                        index: index,
                        login: true,
                      ),
                  onLoading: TopNavbar(
                    index: index,
                    login: true,
                  )),
              size.width <= 850
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: widget.authenticationController.obx(
                          (state) => menuList(context, 4),
                          onEmpty: menuList(context, 4),
                          onError: (error) => menuList(context, 3),
                          onLoading: menuList(context, 3)))
                  : Container()
            ],
          ),
        )));
  }

  Widget menuList(BuildContext context, max) {
    List<BottomNavbarItem> items = [
      BottomNavbarItem(
        icon: Icon(Icons.language),
        title: Text('Explorar'),
        activeColor: index.colors[0],
        inactiveColor: Constants.inactive,
        textAlign: TextAlign.center,
      ),
      BottomNavbarItem(
        icon: Icon(Icons.table_view),
        title: Text('Cards'),
        activeColor: index.colors[1],
        inactiveColor: Constants.inactive,
        textAlign: TextAlign.center,
      ),
      BottomNavbarItem(
        icon: Icon(Icons.content_paste),
        title: Text('Roteiros'),
        activeColor: index.colors[2],
        inactiveColor: Constants.inactive,
        textAlign: TextAlign.center,
      ),
      BottomNavbarItem(
        icon: Icon(Icons.supervised_user_circle),
        title: Text('Pacientes'),
        activeColor: index.colors[3],
        inactiveColor: Constants.inactive,
        textAlign: TextAlign.center,
      ),
    ];

    return BottomNavbar(
      items: items.sublist(0, max),
      selectedIndex: index.index,
      onItemSelected: (i) => setState(() {
        index.index = i;
        index.notifyParent!();
      }),
    );
  }

  Widget bodyPage(BuildContext context) {
    List<Widget> pages = [
      ExplorePage(),
      CardsPage(),
      ExplorePage(),
      ExplorePage(),
    ];

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.topCenter,
      color: Constants.background,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: size.width < 1024 ? 20 : 200,
            right: size.width < 1024 ? 20 : 200,
            top: 110),
        child: IndexedStack(
          alignment: Alignment.topCenter,
          index: index.index,
          children: pages,
        ),
      ),
    );
  }
}

class Index {
  int index = 0;
  List<Color> colors = [
    Constants.green,
    Constants.purple,
    Constants.pink,
    Constants.turquoise,
  ];

  Index({this.index = 0});

  Function()? notifyParent;
}
