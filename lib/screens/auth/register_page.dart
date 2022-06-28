import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/screens/auth/register_controller.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';

// ignore: must_be_immutable
class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.multiply),
            image: AssetImage("assets/img/background_0.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
                  const SizedBox(height: 80),
                  Text(
                    'auth.register'.tr,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextInput(
                    style: Colors.white,
                    hintText: 'account.full_name'.tr,
                    iconData: null,
                    controller: controller.nameController,
                    rules: {
                      'required': 'your_name'.tr + 'is_not_empty'.tr,
                    },
                    validateCallback: (value) {
                      controller.isValidateName.value = value;
                      controller.onValidate();
                    },
                  ),
                  const SizedBox(height: 20),
                  MyTextInput(
                    style: Colors.white,
                    hintText: 'Email',
                    iconData: null,
                    controller: controller.emailController,
                    rules: {
                      'email': true,
                      'required': 'account.email'.tr + 'is_not_empty'.tr,
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
                    textInputType: TextInputType.number,
                    hintText: 'common.phone'.tr,
                    iconData: null,
                    controller: controller.phoneController,
                    validateCallback: (value) {
                      controller.isValidatePhone.value = value;
                      controller.onValidate();
                    },
                    rules: {
                      'phone': true,
                      'required': 'common.phone'.tr + 'is_not_empty'.tr,
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextInput(
                    style: Colors.white,
                    textInputType: TextInputType.visiblePassword,
                    hintText: 'auth.password'.tr,
                    iconData: null,
                    controller: controller.passwordController,
                    rules: {
                      'minLength': 6,
                      'required': 'auth.password'.tr + 'is_not_empty'.tr,
                    },
                    validateCallback: (value) {
                      controller.isValidatePassword.value = value;
                      controller.password.value = controller.passwordController.text;
                      controller.onValidate();
                    },
                  ),
                  const SizedBox(height: 10),
                  Obx(() => MyTextInput(
                        style: Colors.white,
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'auth.confirm_password'.tr,
                        iconData: null,
                        controller: controller.conformPasswordController,
                        rules: {
                          'minLength': 6,
                          'required': 'auth.confirm_password'.tr + 'is_not_empty'.tr,
                          'conform_password': controller.password.value,
                        },
                        validateCallback: (value) {
                          controller.isValidatePConformPassword.value = value;
                          controller.onValidate();
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => MyButtonSubmit(
                      submiting: controller.isSubmitting.value,
                      onPressed: controller.isDisableSubmit.value
                          ? null
                          : () {
                              controller.handleSubmit();
                            },
                      label: 'auth.register'.tr,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('auth.have_account?'.tr),
                      InkWell(
                          onTap: () {
                            Get.offAllNamed('login');
                          },
                          child: Text(
                            'auth.login'.tr,
                            style: TextStyle(color: Colors.blue),
                          ))
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
