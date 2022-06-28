import 'package:get/get.dart';
import 'package:pos_app/screens/auth/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
