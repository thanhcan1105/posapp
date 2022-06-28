import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';
import 'package:get/get.dart';

class RowSearchPos extends StatelessWidget {
  const RowSearchPos({
    Key? key,
    this.iconRight,
    this.hintText,
    this.onPressIcon,
    this.controller,
  }) : super(key: key);

  final IconData? iconRight;
  final String? hintText;
  final Function? onPressIcon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onPressIcon ?? () {};
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              iconRight ?? Icons.add,
              size: 30,
              color: Palette.primaryColor,
            ),
          ),
        ),
        //SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(border: InputBorder.none, hintText: hintText ?? 'label.search_menu'.tr, hintStyle: Palette.textStyle().copyWith(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
