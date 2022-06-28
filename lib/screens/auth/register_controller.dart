import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/contants.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/get_tool/get_tool.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController with GetTool {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController conformPasswordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  RxBool isDisableSubmit = true.obs;
  RxBool isSubmitting = false.obs;

  RxBool isValidateName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePhone = false.obs;
  RxBool isValidatePassword = false.obs;
  RxBool isValidatePConformPassword = false.obs;

  RxString password = ''.obs;

  var box = GetStorage();

  // onPasswordChange() {
  //   password.value = passwordController.value;
  // }

  onValidate() {
    if (isValidateName.value && isValidateEmail.value && isValidatePhone.value && isValidatePassword.value && isValidatePConformPassword.value) {
      isDisableSubmit.value = false;
    } else {
      isDisableSubmit.value = true;
    }
  }

  handleSubmit() async {
    isSubmitting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'name': nameController.text.trim(),
      'password': passwordController.text.trim(),
    };
    await RegisterController().register(body);
    isSubmitting.value = false;
    isDisableSubmit.value = false;
  }

  Future register(body) async {
    var response = await http.post(Uri.parse('${CONTANTS.BASE_DOMAIN}/api/register'), body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        print(response.body);
        var result = jsonDecode(response.body);
        if (result['message'] == 'success' && result['code'] == 200) {
          Get.toNamed('welcome');
          AppUltils().getSnackBarSuccess(message: 'common.register_success'.tr);
          notify.success(title: 'common.success'.tr, message: 'common.register_success'.tr);
        }
      }
    } else {
      // AppUltils().getSnackBarError(message: 'Đăng ký tài khoản thất bại, vui lòng thử lại');
      notify.error(title: 'common', message: 'common.register_failed'.tr);
    }
  }
}
