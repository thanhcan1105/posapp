import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/employee_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AddEmployeeScreen extends GetView<EmployeeController> {
  //CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        title: 'common.add_employee'.tr,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.nameController,
                                decoration: InputDecoration(labelText: 'common.name_employee'.tr + ' *'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.phoneController,
                                decoration: InputDecoration(labelText: 'common.phone'.tr),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.emailController,
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.passwordController,
                                decoration: InputDecoration(labelText: 'common.password'.tr),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.addressController,
                                decoration: InputDecoration(
                                    labelText: 'common.address'.tr,
                                    suffixIcon: Icon(
                                      FontAwesome.chevron_right,
                                      size: 20,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new DropdownSearch<Map>(
                          // mode: Mode.BOTTOM_SHEET,
                          // showSelectedItem: false,
                          items: controller.employeeListRole,
                          // dropdownSearchDecoration: InputDecoration(
                            // border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 5),
                          // ),
                          // label: "common.role".tr,
                          itemAsString: (e) => e['role'],
                          onChanged: (v) {
                            //addProductController.setCatelogId(v.id);
                            print(v!['id']);
                            controller.roleId = v['id'];
                          },
                        ),
                        Divider(
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // ignore: unnecessary_statements
                controller.submit();
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Palette.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'common.add'.tr.toUpperCase(),
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
