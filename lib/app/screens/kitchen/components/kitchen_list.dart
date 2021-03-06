import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/app/controllers/kitchen_controller.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/kitchen_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:get/get.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/empty_data.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class KitchenList extends StatefulWidget {
  const KitchenList({Key? key, this.statusId}) : super(key: key);
  final int? statusId;
  @override
  _KitchenListState createState() => _KitchenListState();
}

class _KitchenListState extends State<KitchenList> with SingleTickerProviderStateMixin {
  late double scale;
  late AnimationController _controller;
  int count = 0;
  int total = 0;

  late List<ProductModel> products;
  // print(widget.areaId);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _controller.value;
    KitchenController controller = Get.find();
    //MasterStore posStore = Get.find();
    //  List<KitchenModel> listMenu = widget.statusId != 0 ? posStore.tables.where((element) => element.areaId == widget.areaId).toList() : posStore.tables;
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      Expanded(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: SmartRefresherSuccess(),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: PagedListView<int, KitchenModel>.separated(
            pagingController: controller.pagingController,
            separatorBuilder: (context, index) => Container(height: 6, color: Colors.grey.withOpacity(0.3)),
            builderDelegate: PagedChildBuilderDelegate<KitchenModel>(
              itemBuilder: (context, kitchen, index) => ExpandKitchenItem(
                kitchenItem: kitchen,
                callback: (status) {
                  controller.onUpdateStatus(id: kitchen.id, status: status);
                },
              ),
              noItemsFoundIndicatorBuilder: (context) => Container(
                height: Get.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmptyDataWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
    // InkWell(
    //   onTap: () {
    //     if (posStore.cartItem.length != 0) {
    //       Get.toNamed('cart');
    //     }
    //   },
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    //     child: Transform.scale(
    //       scale: _scale,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Palette.primaryColor,
    //         ),
    //         width: Get.size.width - 20,
    //         height: 50,
    //         padding: EdgeInsets.all(7),
    //         margin: EdgeInsets.all(0),
    //         child: Center(
    //             child: Obx(() => Text(
    //                   '${posStore.cartItem.length} ${'label.item'.tr} = ${$Number.numberFormat(posStore.cartItem.length != 0 ? posStore.cartItem?.map((element) => element.price)?.reduce((a, b) => a + b) : 0)} ??',
    //                   style: TextStyle(color: Colors.white, fontSize: 25),
    //                 ))),
    //       ),
    //     ),
    //   ),
    // )
    // SizedBox(
    //   height: size.height * .3,
    // )

    // ignore: unused_element
    // List<Widget> _buildCardItem({size, color, controller}) {
    //   return [
    //     CardFoodGridItem(
    //       size: size,
    //       color: Colors.orange,
    //       title: 'G?? r??n',
    //       price: 15000,
    //       imageUrl: 'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
    //       onPressed: () {
    //         setState(() {
    //           count += 1;
    //         });
    //         bounceButtonAction(controller);
    //         //print('hello');
    //       },
    //     ),
    //     AddNewCardItem()
    //   ];
    // }
  }
}

bounceButtonAction(controller) {
  controller.forward();
  Future.delayed(Duration(milliseconds: 100), () {
    controller.reverse();
  });
}

class ExpandKitchenItem extends StatelessWidget {
  const ExpandKitchenItem({required this.kitchenItem, required this.callback}) : super();
  final KitchenModel kitchenItem;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: new GlobalKey(),
      animateTrailing: true,
      initiallyExpanded: (kitchenItem.id != null) ? true : false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kitchenItem.products!.first.name ?? '',
            style: Palette.textStyle().copyWith(
              fontSize: 18,
            ),
          ),
          Spacer(),
          Text(
            'common.order_code'.tr + ': ${kitchenItem.order?.orderCode}',
            style: Palette.textStyle().copyWith(fontSize: 12),
          )
        ],
      ),
      subtitle: Text(
        kitchenItem.labelStatus.toString(),
        style: Palette.textStyle().copyWith(color: Colors.green),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 10),
          child: Row(
            children: [Expanded(child: Text('time.time'.tr + ': ${DateFormat('H:m dd-MM-yy').format(DateTime.parse(kitchenItem.createdAt!).toLocal())}'))],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 10),
          child: Row(
            children: [Expanded(child: Text('common.type'.tr + ': ${kitchenItem.order?.orderMethoLabel}'))],
          ),
        ),
        kitchenItem.order?.orderMethod == 1 && kitchenItem.order!.table != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 10),
                child: Row(
                  children: [Expanded(child: Text('label.table'.tr + ': ${kitchenItem.order!.table!.name}'))],
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 10),
          child: Row(
            children: [Expanded(child: Text('common.note'.tr + ': ${kitchenItem.note ?? ''}'))],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kitchenItem.status != 1
                      ? Container()
                      : MyButtonSubmit(
                          onPressed: kitchenItem.status! == 1
                              ? () {
                                  callback(2);
                                }
                              : null,
                          textColor: Palette.textColorLight,
                          label: 'common.confirm'.tr,
                          width: 50,
                          fontSize: 10,
                          height: 30,
                          radius: 5,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  MyButtonSubmit(
                    onPressed: kitchenItem.status != 1 && kitchenItem.status! <= 2
                        ? () {
                            callback(3);
                          }
                        : null,
                    textColor: Palette.textColorLight,
                    backgroundColor: kitchenItem.status == 2 ? Colors.green : Palette.primaryColor,
                    label: 'common.doing'.tr,
                    width: 50,
                    fontSize: 10,
                    height: 30,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MyButtonSubmit(
                    onPressed: kitchenItem.status != 1 && kitchenItem.status! <= 3
                        ? () {
                            callback(4);
                          }
                        : null,
                    textColor: Palette.textColorLight,
                    backgroundColor: kitchenItem.status == 3 ? Colors.green : Palette.primaryColor,
                    label: 'common.ready'.tr,
                    width: 50,
                    fontSize: 10,
                    height: 30,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MyButtonSubmit(
                    onPressed: kitchenItem.status != 1 && kitchenItem.status! <= 4
                        ? () {
                            callback(5);
                          }
                        : null,
                    textColor: Palette.textColorLight,
                    backgroundColor: kitchenItem.status == 4 ? Colors.green : Palette.primaryColor,
                    label: 'common.take_out'.tr,
                    width: 50,
                    fontSize: 10,
                    height: 30,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
