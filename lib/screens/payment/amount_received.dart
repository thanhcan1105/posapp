import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';
import 'package:pos_app/screens/payment/amount_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/common.dart';
import 'package:pos_app/widgets/numpad/numpad_widget.dart';

// ignore: must_be_immutable
class AmountNumpadWidget extends GetView<AmountController> {
//Instantiate a NumpadController
  AmountNumpadWidget({
    this.totalPrice,
    this.productId,
    this.callbackSubmit,
    this.orderId,
  });

  final int? totalPrice;
  final int? productId;
  final Function? callbackSubmit;
  final int? orderId;

  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    AmountController amountController = Get.put(AmountController());
    PaymentController paymentController = Get.put(
      PaymentController(),
    );

    final _controller = NumpadController(
      format: NumpadFormat.AMOUNT,
      hintText: $Number.numberFormat(amountController.amountReceive.value== 0 ? totalPrice! : amountController.amountReceive.value).toString() + ' đ',
      onInputValidChange: (bool) {},
    );

    //CartController cartController = Get.find();
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: "common.payment".tr + ": " "common.cash".tr,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: Get.height * .05),
              child: Text(
                'common.amount_received'.tr + ':',
                style: Palette.titleProduct(),
              ),
            ),
            SizedBox(height: 5),
            NumpadText(
              controller: _controller,
              style: TextStyle(
                fontSize: 40,
                color: Colors.cyan,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Obx(() {
                // ignore: unrelated_type_equality_checks
                if (amountController.amountReceive.value - totalPrice! > 0) {
                  return Text(
                    'common.refound'.tr + ': ${$Number.numberFormat(amountController.amountReceive.value - totalPrice!)} đ',
                    style: Palette.titleProduct(),
                  );
                } else {
                  return Text(
                    'common.remainder'.tr + ': ${$Number.numberFormat(-(amountController.amountReceive.value - totalPrice!))} đ',
                    style: Palette.titleProduct(),
                  );
                }
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              width: double.infinity,
              color: Colors.grey[300],
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'common.total'.tr + ': ' + $Number.numberFormat(totalPrice!).toString() + ' đ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                ),
              ),
            ),
            Expanded(
              child: Numpad(
                controller: _controller,
                buttonTextSize: 40,
                submitInput: (e) {
                  if (e == null) {
                    amountController.amountReceive.value = totalPrice!;
                  } else {
                    amountController.amountReceive.value = e;
                  }
                },
                buttonColor: Palette.primaryColor,
                textColor: Colors.white,
              ),
            ),
            Obx(() => Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: amountController.amountReceive.value - totalPrice! >= 0 ? Palette.colorCyan : Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: amountController.amountReceive.value - totalPrice! >= 0
                            ? () {
                                CommonWidget.progressIndicator();
                                if (orderId == null) {
                                  paymentController.paymentOrder(
                                    totalPrice,
                                    amountController.amountReceive.value,
                                  );
                                } else {
                                  paymentController.updatePaymentOrder(
                                    orderId,
                                    totalPrice,
                                    amountController.amountReceive.value,
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          'common.payment'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Palette.textTitle1(),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
