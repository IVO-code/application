import 'package:application/ui/auth/authentication_view.dart';
import 'package:application/ui/home/home_view.dart';
import 'package:application/ui/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const Routes());
}

initServices() async {
  print('starting services ...');
  await GetStorage.init();
  print('All services started...');
}

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (ctx, chd) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: "/",
              getPages: [
                GetPage(
                  name: '/',
                  page: () => HomeView(),
                  transition: Transition.downToUp,
                ),
                GetPage(
                  name: '/authentication/',
                  page: () => AuthenticationView(),
                  transition: Transition.upToDown,
                ),
                GetPage(
                    name: '/profile/',
                    page: () => ProfileView(),
                    transition: Transition.upToDown),
              ],
            ));
  }
}
