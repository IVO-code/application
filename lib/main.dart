import 'package:application/routes/authentication/view/authentication_view.dart';
import 'package:application/routes/home/view/home_view.dart';
import 'package:application/routes/profile/view/profile_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  //await Get.putAsync(() => LocalStorageService().init());
  print('All services started...');
}

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => Home(), transition: Transition.downToUp),
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
    );
  }
}
