import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/data/controllers/initData_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';

class LoginController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  MasterStore masterStore = Get.put<MasterStore>(MasterStore());
  RxList<ProductModel> products = <ProductModel>[].obs;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  RxBool isDisableSubmit = true.obs;
  RxBool isSubmiting = false.obs;

  RxBool isValidateEmail = false.obs;
  RxBool isValidatePassword = false.obs;

  @override
  onInit() {
    super.onInit();

    // emailController.addListener(onValidate);
    // passwordController.addListener(onValidate);
  }

  onValidate() {
    isDisableSubmit.value = true;
    if (isValidateEmail.value && isValidatePassword.value) {
      isDisableSubmit.value = false;
      return false;
    } else {
      isDisableSubmit.value = true;
      return false;
    }
  }

  Future login(body) async {
    var response = await http.post(Uri.parse('${CONTANTS.BASE_DOMAIN}/api/login'), body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    print(body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        print(result);
        if (result['token'].isNotEmpty) {
          var box = GetStorage();
          box.write('token', result['token']);
          box.write('user', result['user']);
          box.write('store_info', result['user']['restaurant']);

          await InitData().onInit();
          // if (catelogies.length != 0 && catelogies.length != 0)

          Get.offAllNamed('pos');
          AppUltils().getSnackBarSuccess(title: 'common.success'.tr, message: 'common.login_success'.tr);
          return;
        }
      }
    } else {
      AppUltils().getSnackBarError(title: 'common.failure', message: 'common.login_failed'.tr);
      return;
    }
    return;
  }

  handleSubmitLogin() async {
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, String> body = {'email': emailController.text.trim(), 'password': passwordController.text, 'device_name': 'test'};
    if (emailController.text.isEmpty || passwordController.text.isEmpty)
      AppUltils().getSnackBarError(message: 'enter_full_info'.tr);
    else
      await LoginController().login(body);
    isSubmiting.value = false;
    isDisableSubmit.value = false;
  }
}
