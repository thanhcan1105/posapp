import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/screens/auth/login_controller.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';


// ignore: must_be_immutable
class LoginPage extends GetView<LoginController> {
  // LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.multiply),
            image: AssetImage("assets/img/background_0.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Image.asset(
                      'assets/img/logo-1.png',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'auth.login'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextInput(
                    style: Colors.white,
                    controller: controller.emailController,
                    hintText: 'account.email'.tr,
                    iconData: null,
                    rules: {
                      'email': true,
                      'required': 'account.email'.tr + 'common.is_not_empty'.tr,
                    },
                    validateCallback: (value) {
                      controller.isValidateEmail.value = value;
                      controller.onValidate();
                    },
                    // background: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  MyTextInput(
                    style: Colors.white,
                    textInputType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                    hintText: 'auth.password'.tr,
                    iconData: null,
                    rules: {
                      'required': 'auth.password'.tr + 'common.is_not_empty'.tr,
                    },
                    validateCallback: (value) {
                      controller.isValidatePassword.value = value;
                      controller.onValidate();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'auth.forgot_password?'.tr,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => MyButtonSubmit(
                      submiting: controller.isSubmiting.value,
                      onPressed: controller.isDisableSubmit.value
                          ? null
                          : () {
                              controller.handleSubmitLogin();
                            },
                      label: 'auth.login'.tr,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('auth.dont_have_account?'.tr),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed('register');
                        },
                        child: Text(
                          'auth.register'.tr,
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
