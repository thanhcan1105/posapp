import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';

class PaymentDoneScreen extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    var agrs = Get.arguments;
    agrs = agrs ?? {'totalPrice': 0, 'amountReceive': 0, 'icon': (Icons.check)};
    print(agrs);
    return Scaffold(
      body: WillPopScope(
        onWillPop: AppUltils().onWillPop,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      agrs != null ? agrs['icon'] : Icons.check,
                      size: 200,
                      color: agrs['color'],
                    ),
                    Text(agrs['status_title'] ?? '', style: TextStyle(fontSize: 30)),
                    SizedBox(
                      height: 10,
                    ),
                    agrs != null
                        ? Text(
                            agrs != null ? 'label.order'.tr + ': ' + $Number.numberFormat(agrs['totalPrice']) + ' đ' : '',
                            style: TextStyle(fontSize: 20, color: Palette.primaryColor),
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    agrs['amountReceive'] != 0
                        ? Text(
                            'common.received'.tr + ': ' + $Number.numberFormat(agrs['amountReceive']) + ' đ',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    agrs['amountReceive'] != 0
                        ? Text(
                            'common.change'.tr + ': ' + $Number.numberFormat(agrs['amountReceive'] - agrs['totalPrice']) + ' đ',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: Colors.grey,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.offNamed('receipt', arguments: agrs['order_id']);
                    },
                    child: Text(
                      'common.see_the_bill'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      cartController.masterStore.cartItem.clear();
                      Get.offAllNamed('pos');
                    },
                    child: Text(
                      'common.create_a_new_bill'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Palette.textTitle1(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
