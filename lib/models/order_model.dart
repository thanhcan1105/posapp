import 'package:pos_app/models/cart_model.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/models/employee.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/models/user_model.dart';
import 'package:get/get.dart';

class OrderModel {
  int? id;
  String? orderCode;
  List<ProductModel>? products;
  List<CartModel>? items;
  List<OrderStatusModel>? status;
  String? timeStart;
  String? timeEnd;
  int? totalPrice;
  int? amountReceive;
  int? change;
  int? tableId;
  TableModel? table;
  EmployeeModel? employee;
  CustomerModel? customer;
  DateTime? createdAt;
  int? date;
  String? note;
  UserModel? client;
  int? paymentMethod;
  int? orderMethod;

  OrderModel(
      {this.id,
      this.orderCode,
      this.products,
      this.status,
      this.timeStart,
      this.timeEnd,
      this.totalPrice,
      this.amountReceive,
      this.change,
      this.employee,
      this.customer,
      this.tableId,
      this.table,
      this.createdAt,
      this.date,
      this.note,
      this.client,
      this.orderMethod,
      this.paymentMethod,
      this.items});

  // factory OrderModel.fromJson(json) {
  //   return new OrderModel(
  //     id: json['id'],
  //     orderCode: json['order_code'],
  //     products: (json['products']).map((e) => ProductModel.fromJson(e)).toList(),
  //     status: json['status'],
  //     totalPrice: json['total_price'],
  //     timeStart: json['time_start'],
  //     timeEnd: json['time_end'],
  //     amountReceive: json['amount_receive'],
  //     change: json['amount_change'],
  //   );
  // }

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    if (json['status'] != null) {
      status = <OrderStatusModel>[];
      json['status'].forEach((v) {
        status!.add(new OrderStatusModel.fromJson(v));
      });
    }
    tableId = json['table_id'];
    table = (json['table']) != null ? TableModel.fromJson(json['table']) : null;
    amountReceive = json['amount_receive'];
    change = json['amount_change'];
    totalPrice = json['total_price'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(new ProductModel.fromJson(v));
      });
      createdAt = DateTime.parse(json['created_at']).toLocal();
      date = DateTime.parse(json['created_at']).toLocal().day;
      note = json['note'];
    }
    if (json['items'] != null) {
      items = <CartModel>[];
      json['items'].forEach((v) {
        items!.add(new CartModel.fromJson(v));
      });
    }

    customer = CustomerModel.fromJson(json['customer']);
    employee = EmployeeModel.fromJson(json['user']);
    if (json['client'] != null) {
      client = UserModel.fromJson(json['client']);
    }
    paymentMethod = json['payment_method'];
    orderMethod = json['order_method'];
  }

  List<ProductModel> mapJsonProduct(json) {
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }

  String get orderMethoLabel {
    switch (orderMethod) {
      case 1:
        return 'common.use_in_place'.tr;
        break;
      case 2:
        return 'common.take_out'.tr;
        break;
      case 3:
        return 'common.ship'.tr;
        break;

      default:
        return '';
    }
  }

  String get paymentMethodLabel {
    switch (paymentMethod) {
      case 1:
        return 'common.cash'.tr;
        break;
      case 2:
        return 'ATM';
        break;
      case 3:
        return 'common.debit'.tr;
        break;

      default:
        return '';
    }
  }
}
