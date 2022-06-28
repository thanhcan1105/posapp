import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/screens/auth/login_controller.dart';

// ignore: must_be_immutable
class WelcomePage extends GetView<LoginController> {
  // LoginController controller = Get.put(LoginController());
  final size = Get.height;
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
        child: Center(
          child: Container(
            height: Get.height * .75,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: Get.height * 0.2),
                  Align(
                    child: Image.asset(
                      'assets/img/logo-1.png',
                      height: 80,
                    ),
                  ),
                  const Spacer(flex: 5),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('login');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              // color: Colors.white,
                            ),
                            child: Text(
                              'auth.login'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('register');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              // color: Colors.white,
                            ),
                            child: Text(
                              'auth.register'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
