import 'package:application/routes/authentication/controller/authentication_controller.dart';
import 'package:application/routes/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class AuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationController>(AuthenticationController());
  }
}
