import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/kitchen_model.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/screens/order/components/timeline.dart';
import 'package:pos_app/services/order_service.dart';
import 'package:pos_app/ultils/number.dart';

import 'package:intl/intl.dart';

class OrderDetailController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;
  Rx<OrderModel> order = OrderModel().obs;
  RxBool isLoading = true.obs;
  int orderId = 0;
  RxList<KitchenModel> listKitchen = RxList<KitchenModel>();

  TextEditingController noteController = new TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    orderId = Get.arguments.id;

    await getOrderById(orderId);
    await getListKitchen(orderId);

    print(order.value.customer);
    // ignore: invalid_use_of_protected_member
    if (listKitchen.value.length > 0) {
      tabItem.add(Tab(
        child: Text('Bếp'),
      ));
    }

    if (order.value.customer != null) {
      tabItem.add(Tab(
        child: Text('Khách hàng'),
      ));
    }
    if (order.value.client != null) {
      tabItem.add(Tab(
        child: Text('Đơn App'),
      ));
    }

    tabController = TabController(length: tabItem.length, vsync: this);
    //  print(order.value.client.name);
  }

  getListKitchen(int orderId) async {
    isLoading.value = true;
    var res = await OrderService().getListKitchen(orderId);
    if (res != null) {
      listKitchen.assignAll(res);
    }
    isLoading.value = false;
  }

  updateStatusOrder() {}
  confirmStatusOrder({statusTitle, status}) async {
    isLoading.value = true;
    Map<String, String> data = {
      'order_id': order.value.id.toString(),
      'status_title': statusTitle,
      'status': status,
    };
    var _result = await OrderService().updatePayment(data: data);
    await getOrderById(orderId);
  }

  updateNoteOrder({statusTitle, status}) async {
    isLoading.value = true;
    Map<String, String> data = {
      'order_id': order.value.id.toString(),
      'note': noteController.text,
    };
    var _result = await OrderService().updateNote(data: data);
    print(_result);
    await getOrderById(orderId);
  }

  Future<OrderModel?> getOrderById(id) async {
    var result = await OrderService().getOrder(id);
    if (result != null) {
      order.value = OrderModel.fromJson(result);
      isLoading.value = false;
      return OrderModel.fromJson(result);
    }
    return null;
  }

  cancelOrder() async {
    isLoading.value = true;
    Map<String, String> data = {
      'order_id': order.value.id.toString(),
    };
    var _result = await OrderService().removeOrder(data: data);
    print(_result);

    //await orderController.getAll();
    //Get.back();

    Get.offAllNamed('pos');
  }

  List<Widget> buildItemName(List<ProductModel> products) {
    List<Widget> lists = [];
    var groupProductById = groupBy(products, (dynamic obj) => obj.id);
    groupProductById.forEach((k, v) {
      lists
        ..add(Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${v.length} x ${v.first.name} (${$Number.numberFormat(v.first.price!)})',
              ),
              Text(
                '${$Number.numberFormat(v.length * v.first.price!)} đ',
              ),
            ],
          ),
        ));
    });
    return lists;
  }

  List<Widget> buildTimeLineStatus(List<OrderStatusModel> status, OrderModel order) {
    List<Widget> results = [];
    status = status.reversed.toList();
    List.generate(
        status.length,
        (index) => {
              results.add(TimeLineStatus(
                iconData: status[index].statusIcon,
                iconColor: status[index].statusColor,
                isFirst: index == 0 ? true : false,
                isLast: false,
                hour: '',
                title: status[index].statusLabel,
                content: DateFormat('dd/MM/yyyy - hh:mm').format(DateTime.parse(status[index].createdAt!).toLocal()),
              ))
            });
    results.add(TimeLineStatus(
      iconData: FontAwesome.money,
      iconColor: Colors.green,
      isLast: true,
      hour: '',
      title: 'Tổng:',
      content: $Number.numberFormat(order.totalPrice!) + ' đ',
    ));
    return results;
  }

  List<Widget> buildTimeLineKitchen(List<KitchenModel> status) {
    List<Widget> results = [];
    status = status.reversed.toList();
    List.generate(
        status.length,
        (index) => {
              results.add(TimeLineStatus(
                iconData: MdiIcons.noodles,
                iconColor: Palette.primaryColor,
                isFirst: index == 0 ? true : false,
                isLast: index + 1 == status.length ? true : false,
                hour: '',
                subTitle: status[index].labelStatus.toString(),
                title: status[index].products!.first.name,
                content: "Cập nhật: " + DateFormat('hh:mm dd/MM/yyyy').format(DateTime.parse(status[index].updatedAt.toString()).toLocal()),
              ))
            });

    return results;
  }

  List<Widget> tabItem = [
    Tab(
      child: Text(
        "common.item".tr,
        style: Palette.textStyle(),
      ),
    ),
    Tab(
      child: Text("Chi tiết", style: Palette.textStyle()),
    ),
  ];
}
