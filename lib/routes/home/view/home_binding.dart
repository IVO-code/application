import 'package:application/routes/home/controllers/home_controller.dart';
import 'package:application/routes/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
