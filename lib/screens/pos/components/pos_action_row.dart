import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/pos_controller.dart';
import 'package:pos_app/widgets/camera/qr_code_scan.dart';
import 'package:pos_app/widgets/common/row_search_input_pos.dart';
import 'package:pos_app/widgets/text_input.dart';

class PosActionRow extends StatefulWidget {
  const PosActionRow({
    Key? key,
  }) : super(key: key);

  @override
  _PosActionRowState createState() => _PosActionRowState();
}

class _PosActionRowState extends State<PosActionRow> {
  bool isSearch = false;
  PosController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return !isSearch
        ? Row(
            children: [
              Expanded(
                  child: RowSearchPos(
                controller: controller.searchPosController,
                hintText: 'common.search_product'.tr,
                iconRight: controller.searchPosController.text.isNotEmpty ? Icons.close : Icons.search,
                onPressIcon: () {
                  controller.searchPosController.clear();
                },
              )),
              // Spacer(),
              InkWell(
                onTap: () {
                  // Get.to(QrViewScreen());

                  controller.scanBarcodeNormal();
                },
                child: Icon(
                  FontAwesome.barcode,
                  size: 30,
                  color: Palette.iconActionColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Obx(() => InkWell(
                    onTap: () {
                      controller.isListItem.value = !controller.isListItem.value;
                    },
                    child: Icon(
                      controller.isListItem.value ? Icons.view_agenda_outlined : Icons.view_agenda,
                      size: 30,
                      color: Palette.iconActionColor,
                    ),
                  ))
            ],
          )
        : Row(children: [
            InkWell(
              onTap: () {
                isSearch = !isSearch;
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Palette.iconActionColor,
              ),
            ),
          ]);
  }
}
