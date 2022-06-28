import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/order_controller.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class ListOrderScreen extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppUltils.buildAppBar(
          height: 50,
          centerTitle: false,
          title: 'label.order'.tr,
          actions: [
            InkWell(
              onTap: () {
                controller.loadData();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.refresh),
              ),
            )
          ],
        ),
        drawer: DrawerApp(),
        body: Column(
          children: [
            // Container(
            //   color: Colors.grey[200],
            //   child: Padding(
            //     padding: const EdgeInsets.all(5),
            //     child: TextFormField(
            //       controller: controller.searchController,
            //       focusNode: FocusNode(),
            //       // controller: controller.searchKeyword,
            //       decoration: InputDecoration(prefixIcon: Icon(Icons.search, size: 35), border: InputBorder.none, hintText: 'Sản phẩm, khách hàng, giá.'),
            //     ),
            //   ),
            // ),
            // RowFilterStatus(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.loadData();
                },
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () => !controller.isLoading.value
                            ? controller.mapOrders.length != 0
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ...controller.buildOrderItem(controller.mapOrders),
                                    ],
                                  )
                                : Center(
                                    child: Image.asset(
                                      'assets/img/empty.png',
                                      height: Get.height * .15,
                                    ),
                                  )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'common.total_order'.tr,
                      style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Text(
                        '${$Number.numberFormat(controller.totalOrderPrice.value)}đ ' + 'common.from'.tr.toLowerCase() + ' ${controller.totalOrderItem.value} ' + 'label.order'.tr.toLowerCase(),
                        style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RowFilterStatus extends StatelessWidget {
  RowFilterStatus({
    Key? key,
  }) : super(key: key);

  List<Widget> buildRowCheckbox() {
    return List.generate(
      status.length,
      (index) => Row(
        children: [
          Checkbox(
            value: status[index].isChecked ?? false,
            onChanged: (e) {},
          ),
          Text(status[index].title!),
          Spacer(),
          Icon(
            MdiIcons.clock,
          )
        ],
      ),
    );
  }

  List<OrderStatusModel> status = [
    new OrderStatusModel(
      title: 'common.wait_for_confirmation'.tr,
      //icon: (Icons.close),
    ),
    new OrderStatusModel(
      title: 'common.confirmed'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.all(15),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'common.select_one_or_more'.tr + '...',
                                style: TextStyle(fontSize: 18),
                              ),
                              // Icon(Icons.close)
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [...buildRowCheckbox()],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: false,
                  enableDrag: false);
            },
            child: Row(
              children: [
                Icon(
                  MdiIcons.clock,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('common.all_status'.tr),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.chevronDown,
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  FontAwesome.user,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('common.employee'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.chevronDown,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
