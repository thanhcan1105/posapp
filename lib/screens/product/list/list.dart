import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/product/list/components/item_catelog.dart';
import 'package:pos_app/screens/product/list/components/item_product.dart';
import 'package:pos_app/screens/product/list/components/item_product_stock.dart';
import 'package:pos_app/data/controllers/list_controller.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/common/row_search_input.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> with SingleTickerProviderStateMixin {
  TabController? _controller;
  // ignore: unused_field
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: listCatelogies.length, vsync: this);
    _controller?.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MasterStore masterStore = Get.put(MasterStore());
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 80,
        title: 'Menu (${masterStore.products.length})',
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: Icon(Mdi.plus),
          // )
        ],
        tabBar: TabBar(
          isScrollable: false,
          onTap: (index) {},
          controller: _controller,
          tabs: listCatelogies,
          labelColor: Palette.colorTextOnPink,
          unselectedLabelColor: Palette.unselectedItemColor,
        ),
      ),
      drawer: DrawerApp(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: TabBarView(
          controller: _controller,
          children: _buildItemPost(),
        ),
      ),
    );
  }
}

//get catelo
List<Widget> listCatelogies = [
  Tab(icon: Text('Menu')),
  Tab(icon: Text('label.stock'.tr)),
  Tab(icon: Text('common.description'.tr)),
];

//get list item
_buildItemPost() {
  return [
    ColumnListProduct(),
    ColumnListProductStock(),
    ColumnListCatelog(),
  ];
}

class ColumnListCatelog extends StatefulWidget {
  const ColumnListCatelog({
    Key? key,
  }) : super(key: key);

  @override
  _ColumnListCatelogState createState() => _ColumnListCatelogState();
}

class _ColumnListCatelogState extends State<ColumnListCatelog> {
  TextEditingController _catelogNameController = new TextEditingController();
  ListProductController controller = Get.put(ListProductController(), permanent: true);

  bool isOpenAddCat = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(
              controller: controller.searchCatelogyController,
              hintText: 'label.search_description'.tr,
              iconRight: isOpenAddCat ? Icons.close : Icons.add,
              onPressIcon: () {
                //Get.toNamed('catelog/add');
                setState(() {
                  isOpenAddCat = !isOpenAddCat;
                });
              },
            ),
          ),
        ),
        //TweenAnimationBuilder(tween: null, duration: null, builder: null),
        if (isOpenAddCat)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _catelogNameController,
                        decoration: InputDecoration(
                          labelText: 'label.add_discription'.tr,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          Map<String, String> data = {'name': _catelogNameController.text};
                          // ignore: await_only_futures
                          _catelogNameController.text = '';
                          controller.addCatelog(data);
                        },
                        child: Icon(Icons.save)),
                  ],
                ),
              ],
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => controller.searchCatelogies.length == 0
                  ? ListView.builder(
                      itemCount: controller.catelogies.length,
                      itemBuilder: (bc, index) {
                        return ItemCatelog(
                          catelogItem: controller.catelogies[index],
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.searchCatelogies.length,
                      itemBuilder: (bc, index) {
                        return ItemCatelog(
                          catelogItem: controller.searchCatelogies[index],
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColumnListProductStock extends StatelessWidget {
  const ColumnListProductStock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListProductController listProductController = Get.put(ListProductController());
    MasterStore posStore = Get.find<MasterStore>();
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(
              controller: listProductController.searchController,
              iconRight: FontAwesome.filter,
            ),
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10, right: 10),
        //     child: ListView.builder(
        //       itemCount: 10,
        //       itemBuilder: (BuildContext context, index) {
        //         return ItemProductStock();
        //       },
        //     ),
        //   ),
        // ),
        Obx(
          () => posStore.searchProducts.length == 0
              ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: posStore.products.length,
                            itemBuilder: (bc, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ItemProductStock(product: posStore.products[index]),
                                  ),
                                ),
                              );
                            }),
                      )),
                )
              : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: posStore.searchProducts.length,
                            itemBuilder: (bc, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ItemProductStock(product: posStore.searchProducts[index]),
                                  ),
                                ),
                              );
                            }),
                      )),
                ),
        ),
        Container(
          height: Get.height * .13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              // backgroundBlendMode: BlendMode.color,
              color: Colors.blueGrey),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'common.total'.tr + ': ${$Number.numberFormat(listProductController.totalPrice.value)} ??',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      listProductController.totalStock.value.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'label.total_value_warehouse'.tr + ': ${$Number.numberFormat(listProductController.totalPrice.value)} ??',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'label.stocking'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ColumnListProduct extends GetView<ListProductController> {
  const ColumnListProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MasterStore posStore = Get.find<MasterStore>();
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(
                controller: controller.searchController,
                onPressIcon: () {
                  Get.toNamed('product/add');
                }),
          ),
        ),
        Obx(
          () => posStore.searchProducts.length == 0
              ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: posStore.products.length,
                            itemBuilder: (bc, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ItemProduct(product: posStore.products[index]),
                                  ),
                                ),
                              );
                            }),
                      )),
                )
              : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: posStore.searchProducts.length,
                            itemBuilder: (bc, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ItemProduct(product: posStore.searchProducts[index]),
                                  ),
                                ),
                              );
                            }),
                      )),
                ),
        ),
      ],
    );
  }
}
