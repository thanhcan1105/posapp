import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/data/controllers/list_controller.dart';
import 'package:pos_app/widgets/popup/pop_menu.dart';

class ItemCatelog extends StatelessWidget {
  const ItemCatelog({Key? key, this.catelogItem}) : super(key: key);
  final CatelogModel? catelogItem;
  @override
  Widget build(BuildContext context) {
    ListProductController controller = Get.put(ListProductController());
    return Container(
      height: Get.height * .1,
      child: Row(
        children: [
          Expanded(
            child: Text(
              catelogItem!.name!,
              style: Palette.titleProduct(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PopMenuCustom(
            onSelected: (e) {
              if (e == 'edit') {}
              if (e == 'delete') {
                controller.deleteCatelog(catelogItem!.id);
              }
            },
            mapItems: [
              {'title': 'common.edit'.tr, 'icon': Icons.edit, 'value': 'edit'},
              {'title': 'common.delete'.tr, 'icon': Icons.delete, 'value': 'delete'},
            ],
          ),
        ],
      ),
    );
  }
}
