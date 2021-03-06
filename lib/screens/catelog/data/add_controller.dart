import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/contants.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';

class AddCatelogController extends GetxController {
  var box = GetStorage();

  add(body) async {
    var response = await http.post(
      Uri.parse('${CONTANTS.BASE_DOMAIN}/catelog/add'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ' + box.read('token')},
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['message'] == 'success') {
          AppUltils().getSnackBarSuccess(message: 'label.add_category_success'.tr);
        }
      }
    } else {
      AppUltils().getSnackBarError(message: 'label.add_category_failed'.tr);
    }
  }
}
