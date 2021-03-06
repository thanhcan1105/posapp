import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/screens/cart/components/numpad_widget.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/common/vertical_divider.dart';

class RowTotalPrice extends StatelessWidget {
  const RowTotalPrice({
    Key? key,
    this.totalPrice,
  }) : super(key: key);
  final int? totalPrice;
  @override
  Widget build(BuildContext context) {
    // CartController cartController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: Row(
            //     children: [
            //       Text(
            //         'Mã giảm giá?',
            //         style: Palette.textStyle().copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    'common.total'.tr + ':',
                    style: Palette.textStyle().copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${$Number.numberFormat(totalPrice!)} đ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Palette.textStyle().copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class CartItem extends GetView {
  const CartItem({Key? key, this.quantity, this.productName, this.totalPriceItem, this.isExtend = false, this.productId, this.priceItem, this.totalItem}) : super(key: key);

  final int? quantity;
  final String? productName;
  final int? totalPriceItem;
  final int? priceItem;
  final bool? isExtend;
  final int? productId;
  final int? totalItem;
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$quantity' + 'x',
                  style: Palette.textStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '$productName',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Palette.textStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  '${$Number.numberFormat(totalPriceItem!)} đ',
                  style: Palette.textStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (cartController.extendRowId.value == productId)
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              //change quality item in cart
                              Get.dialog(
                                NumpadWidget(
                                  productName: productName!,
                                  quantity: quantity!,
                                  productId: productId!,
                                  callbackSubmit: (v) {
                                    if (v == 0) {
                                      cartController.remoteItemInCart(productId!);
                                      Get.back();
                                    } else if (v == null) {
                                      Get.back();
                                    } else {
                                      if (v - totalItem < 0) {
                                        cartController.decrementCartItem(
                                          cartController.cart.firstWhere((e) => e.id == productId),
                                          $Number.absVal(v - totalItem),
                                        );
                                      } else if (v - totalItem > 0) {
                                        cartController.incrementCartItem(
                                          cartController.cart.firstWhere((e) => e.id == productId),
                                          (v - totalItem),
                                        );
                                      }
                                      Get.back();
                                    }
                                  },
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Icon(MdiIcons.counter),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$totalItem',
                                ),
                              ],
                            ),
                          ),
                          $VerticalDivider(),
                          Column(
                            children: [
                              Icon(
                                MdiIcons.currencyUsd,
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${$Number.numberFormat(priceItem!)} đ',
                                style: Palette.textStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),
                              ),
                            ],
                          ),
                          $VerticalDivider(),
                          Column(
                            children: [
                              Icon(
                                MdiIcons.ticketPercent,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'common.discount'.tr,
                                style: Palette.textStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.orange),
                              ),
                            ],
                          ),
                          $VerticalDivider(),
                          InkWell(
                            onTap: () {
                              cartController.remoteItemInCart(productId!);
                              // cartController.newCart
                              //   ..assignAll(cartController.newCart
                              //       .where((e) => e['id'] != productId)
                              //       .toList());
                            },
                            child: Column(
                              children: [
                                Icon(
                                  MdiIcons.delete,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'common.delete'.tr,
                                  style: Palette.textStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
