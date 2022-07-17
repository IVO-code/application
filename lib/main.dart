import 'package:application/routes/authentication/view/authentication_binding.dart';
import 'package:application/routes/authentication/view/authentication_view.dart';
import 'package:application/routes/home/view/home_binding.dart';
import 'package:application/routes/home/view/home_view.dart';
import 'package:application/routes/profile/controller/profile_controller.dart';
import 'package:application/routes/profile/view/profile_binding.dart';
import 'package:application/routes/profile/view/profile_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(Routes());
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
                  binding: HomeBinding(),
                ),
                GetPage(
                  name: '/authentication/',
                  page: () => AuthenticationView(),
                  binding: AuthenticationBinding(),
                  transition: Transition.upToDown,
                ),
                GetPage(
                    name: '/profile/',
                    page: () => ProfileView(),
                    binding: ProfileBinding(),
                    transition: Transition.upToDown),
              ],
            ));
  }
}
