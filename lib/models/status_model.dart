import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';

class OrderStatusModel {
  int? id;
  String? title;
  IconData? icon;
  bool? isChecked;
  String? createdAt;

  OrderStatusModel({this.id, this.title, this.createdAt, this.icon});
  factory OrderStatusModel.fromJson(json) {
    return new OrderStatusModel(id: json['id'], title: json['title'], createdAt: json['created_at']);
  }
  //pending 0
  //confirm 2
  //payment 1
  //cooking 3
  //cooked 4
  //ready 5
  //cancel 6

  Color get statusColor {
    switch (title) {
      case 'pending':
        return Colors.black45;
        break;
      case 'confirm':
        return Colors.cyan;
        break;
      case 'payment':
        return Colors.green;
        break;
      case 'cooking':
        return Colors.orangeAccent;
        break;
      case 'cooked':
        return Colors.deepOrange;
        break;
      case 'ready':
        return Colors.greenAccent;
        break;
      case 'cancel':
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  String get statusLabel {
    switch (title) {
      case 'pending':
        return 'common.wait_for_confirmation'.tr;
        break;
      case 'confirm':
        return 'common.confirmed'.tr;
        break;
      case 'payment':
        return 'common.paid'.tr;
        break;
      case 'cooking':
        return 'label.cooking'.tr;
        break;
      case 'cooked':
        return 'label.cooked'.tr;
        break;
      case 'ready':
        return 'label.ready'.tr;
        break;
      case 'cancel':
        return 'label.cancel'.tr;
        break;
      default:
        return '';
    }
  }

  IconData get statusIcon {
    switch (title) {
      case 'pending':
        return MdiIcons.clock;
        break;
      case 'confirm':
        return MdiIcons.clock;
        break;
      case 'payment':
        return FontAwesome.check;
        break;
      case 'cooking':
        return MdiIcons.clock;
        break;
      case 'cooked':
        return MdiIcons.database;
        break;
      case 'ready':
        return MdiIcons.checkAll;
        break;
      case 'cancel':
        return MdiIcons.cancel;
        break;
      default:
        return MdiIcons.clock;
    }
  }
}
