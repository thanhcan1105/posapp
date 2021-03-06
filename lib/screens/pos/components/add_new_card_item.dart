import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';

class AddNewCardItem extends StatelessWidget {
  const AddNewCardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('product/add');
      },
      child: Container(
        child: Center(
            child: Icon(
          Icons.add,
          color: Palette.textColorLight,
          size: 40,
        )),
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
