import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/controllers/initData_controller.dart';
import 'package:pos_app/repositories/notification_service.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';

class RegisterController extends GetxController {
  GetStorage box = GetStorage();
  @override
  void onInit() async {
    super.onInit();
  }
}
