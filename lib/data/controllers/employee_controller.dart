import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/models/employee.dart';
import 'package:pos_app/services/customer_service.dart';
import 'package:pos_app/services/employee_service.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  RxList<CustomerModel> customers = <CustomerModel>[].obs;

  RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  RxList<EmployeeModel> searchResults = <EmployeeModel>[].obs;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController searchKeyword = new TextEditingController();

  Timer? _debounce;
  RxBool isSearchActive = false.obs;
  RxBool isLoading = false.obs;

  int? roleId;
  @override
  onInit() async {
    super.onInit();
    await getAll();
    //print(customers);
    print('onInit agrument');
    searchKeyword.addListener(_onSearchChanged);
    print(isLoading.value);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady');
  }

  void submit() async {
    if (nameController.text.trim() == '') {
      return AppUltils().getSnackBarError(message: 'common.enter_name_employee'.tr);
    }
    Map<String, String> data = {
      'name': nameController.text.trim().toString(),
      'phone': phoneController.text.trim().toString(),
      'address': addressController.text.trim().toString(),
      'email': emailController.text.trim().toString(),
      'password': passwordController.text.trim().toString(),
      'role_id': roleId.toString(),
    };
    // ignore: unused_local_variable
    var res = await EmployeeService().addEmployee(data: data, file: null);
    if (res != null) {
      nameController.text = '';
      phoneController.text = '';
      addressController.text = '';

      await getAll();
      Get.back();
      Get.back();
      AppUltils().getSnackBarSuccess(message: 'common.add_employee_done'.tr);
    } else {
      AppUltils().getSnackBarError(message: 'common.add_employee_failed'.tr);
    }
  }

  Future getAll() async {
    isLoading.value = true;

    var response = (await EmployeeService().getAll());
    if (response != null && response.length != 0) {
      // customers.assignAll(
      employees.assignAll(response);
      // searchResults = employees;
      isLoading.value = false;
      //);
      // return customers;
    }
    isLoading.value = false;
  }

  deleteCustomer(int id) async {
    print(id);
    var response = (await CustomerService().delete(id));
    if (response != null && response.length != 0) {
      print('deleteOk');
      customers.removeAt(customers.indexWhere((e) => e.id == id));

      Get.back();
      Get.back();
      AppUltils().getSnackBarSuccess(message: 'common.delete_customer_done'.tr);
    } else {
      AppUltils().getSnackBarError(message: 'common.an_error_occurred'.tr);
    }
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with _searchQuery.text
      print(searchKeyword.text);
      if (searchKeyword.text != '') {
        searchResults.assignAll(
          employees.where(
            (element) => element.name!.toLowerCase().contains(searchKeyword.text.toLowerCase()),
          ),
        );
      } else {
        searchResults.clear();
      }
    });
  }

  List<Map> employeeListRole = [
    {'id': 1, 'role': 'Admin'},
    {'id': 2, 'role': 'common.cashier'.tr},
    {'id': 3, 'role': 'label.kitchen'.tr},
    {'id': 4, 'role': 'Menu'},
  ];
}
