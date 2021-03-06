import 'package:pos_app/screens/auth/register_page.dart';
import 'package:pos_app/screens/auth/welcome_page.dart';

import './../app/bindings/register_binding.dart';
import 'package:pos_app/app/screens/confirm_table/kitchen_screen.dart';
import './../app/bindings/confirm_table_binding.dart';
import './../app/screens/kitchen/kitchen_screen.dart';
import './../app/bindings/kitchen_binding.dart';
import './../app/screens/table/table_screen.dart';
import './../app/bindings/table_binding.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/binding/analytic_binding.dart';
import 'package:pos_app/data/binding/cart_binding.dart';
import 'package:pos_app/data/binding/customer_binding.dart';
import 'package:pos_app/data/binding/employee_binding.dart';
import 'package:pos_app/data/binding/home_binding.dart';
import 'package:pos_app/data/binding/login_binding.dart';
import 'package:pos_app/data/binding/order_binding.dart';
import 'package:pos_app/data/binding/order_detail_binding.dart';
import 'package:pos_app/data/binding/payment_binding.dart';
import 'package:pos_app/data/binding/receipt_binding.dart';
import 'package:pos_app/data/binding/transaction_binding.dart';
import 'package:pos_app/screens/analytics/analytic.dart';
import 'package:pos_app/screens/auth/login_page.dart';
import 'package:pos_app/screens/cart/index.dart';
import 'package:pos_app/screens/catelog/add/add.dart';
import 'package:pos_app/screens/customer/add/add.dart';
import 'package:pos_app/screens/customer/detail/detail.dart';
import 'package:pos_app/screens/customer/list/list.dart';
import 'package:pos_app/screens/employee/add/add.dart';
import 'package:pos_app/screens/employee/list/list.dart';
import 'package:pos_app/screens/order/detail/detail.dart';
import 'package:pos_app/screens/order/list/list.dart';
import 'package:pos_app/screens/payment/payment.dart';
import 'package:pos_app/screens/pos/pos.dart';
import 'package:pos_app/data/binding/pos_binding.dart';
import 'package:pos_app/screens/product/add/add.dart';
import 'package:pos_app/screens/product/edit/edit.dart';
import 'package:pos_app/data/binding/list_binding.dart';
import 'package:pos_app/screens/product/list/list.dart';
import 'package:pos_app/screens/receipt/receipt.dart';
import 'package:pos_app/screens/setting/list.dart';
import 'package:pos_app/screens/splashscreen/splash_screen.dart';
import 'package:pos_app/screens/transaction/list/list.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => SplashScreen(), binding: HomeBinding()),
    GetPage(
      name: Routes.WELCOME,
      page: () {
        return WelcomePage();
      },
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => PosScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.POS,
      page: () => PosScreen(),
      binding: PosBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => ListProductScreen(),
      transition: Transition.cupertino,
      binding: ListProductBinding(),
      // children: [
      //   GetPage(
      //     name: 'add',
      //     page: () => AddProductScreen(),
      //   ),
      //   GetPage(
      //     name: 'edit',
      //     page: () => EditProductScreen(),
      //   ),
      // ],
    ),
    // GetPage(
    //   name: Routes.ADD_PRODUCT,
    //   page: () => AddProductScreen(),
    // ),
    GetPage(
      name: Routes.EDIT_PRODUCT,
      page: () => EditProductScreen(),
    ),
    // GetPage(
    //   name: Routes.CATELOG,
    //   page: () => AddProductScreen(),
    // ),
    GetPage(
      name: Routes.ADD_CATELOG,
      page: () => AddCatelogScreen(),
    ),
    GetPage(
      name: Routes.CUSTOMER,
      page: () => CustomerScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMER_DETAIL,
      page: () => CustomerDetailScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.ADD_CUSTOMER,
      page: () => AddCustomerScreen(),
    ),
    GetPage(
      name: Routes.EMPLOYEE,
      page: () => EmployeeScreen(),
      binding: EmployeeBinding(),
    ),
    GetPage(
      name: Routes.EMPLOYEE_DETAIL,
      page: () => CustomerDetailScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.ADD_EMPLOYEE,
      page: () => AddEmployeeScreen(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => ListOrderScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAIL,
      page: () => OrderDetailScreen(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => PaymentScreen(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.RECEIPT,
      page: () => ReceiptScreen(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => TransactionScreen(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.ANALYTIC,
      page: () => AnalyticScreen(),
      binding: AnalyticBinding(),
    ),
    GetPage(
      name: Routes.TABLE,
      page: () => TableScreen(),
      transition: Transition.cupertino,
      binding: TableBinding(),
    ),
    GetPage(
      name: Routes.KITCHEN,
      page: () => KitchenScreen(),
      transition: Transition.cupertino,
      binding: KitchenBinding(),
    ),
    GetPage(
      name: Routes.CONFIRM_TABLE,
      page: () => ConfirmTableScreen(),
      transition: Transition.cupertino,
      binding: ConfirmTableBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      transition: Transition.cupertino,
      binding: RegisterBinding(),
    ),
  ];
}
