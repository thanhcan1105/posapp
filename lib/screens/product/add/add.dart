// import 'dart:io';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pos_app/config/palette.dart';
// import 'package:pos_app/data/store/product_store.dart';
// import 'package:pos_app/models/catelog_model.dart';
// import 'package:pos_app/data/controllers/add_controller.dart';
// import 'package:pos_app/ultils/app_ultils.dart';
// import 'package:pos_app/ultils/number.dart';
// import 'package:pos_app/widgets/drawer/drawer.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   //final picker = ImagePicker();

//   AddProductController addProductController = Get.put(AddProductController(), permanent: false);
//   MasterStore masterStore = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppUltils.buildAppBar(title: 'label.add_product'.tr),
//       drawer: DrawerApp(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Obx(
//               () => buildContainer(context),
//             ),
//             buildNamePrice(),
//             Divider(
//               height: 5,
//               thickness: 5,
//             ),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text('label.detail_product'.tr, style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
//                     ),
//                     new DropdownSearch<CatelogModel>(
//                       // mode: Mode.BOTTOM_SHEET,
//                       // showSelectedItem: false,
//                       items: masterStore.catelogies,
//                       // dropdownSearchDecoration: InputDecoration(
//                       //   border: InputBorder.none,
//                       //   contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 5),
//                       // ),
//                       // label: "label.category".tr,
//                       itemAsString: (CatelogModel catelog) => catelog.name!,
//                       onChanged: (v) {
//                         addProductController.setCatelogId(v!.id);
//                       },
//                     ),
//                     Divider(
//                       color: Colors.black,
//                     ),
//                     TextFormField(
//                       controller: addProductController.stockController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'label.stock',
//                         labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: addProductController.promoPriceController,
//                       // onChanged: addProductController.onChangePriceProduct,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'label.price_sale_off'.tr,
//                         labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: addProductController.costController,
//                       onChanged: addProductController.onChangePriceProduct,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'label.historical_cost'.tr,
//                         labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: addProductController.barcodeController,
//                       decoration: InputDecoration(
//                           labelText: 'Code',
//                           labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
//                           suffixIcon: Icon(
//                             FontAwesome.barcode,
//                             size: 40,
//                           )),
//                     ),
//                     TextFormField(
//                       controller: addProductController.noteController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         labelText: 'common.description'.tr,
//                         labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
//                         // suffixIcon: Icon(
//                         //   FontAwesome.sticky_note,
//                         // ),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .2)
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FlatButton.icon(
//         //shape: ShapeBorder(),
//         onPressed: () {
//           addProductController.addProduct();
//         },
//         icon: Icon(
//           Icons.save,
//           color: Colors.white,
//         ),
//         label: Text(
//           'common.save'.tr,
//           style: TextStyle(color: Colors.white),
//         ),
//         color: Palette.primaryColor,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   Container buildNamePrice() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: [
//             TextFormField(
//                 controller: addProductController.nameProduct,
//                 onChanged: addProductController.onChangeNameProduct,
//                 decoration: InputDecoration(labelText: 'label.product_name'.tr, labelStyle: GoogleFonts.roboto(color: Colors.blueGrey))),
//             TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: addProductController.priceProduct,
//                 onChanged: addProductController.onChangePriceProduct,
//                 decoration: InputDecoration(labelText: 'label.sale_product'.tr, labelStyle: GoogleFonts.roboto(color: Colors.blueGrey)))
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildContainer(BuildContext context) {
//     return Container(
//       height: Get.height * .21,
//       color: Colors.grey[300],
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FlatButton.icon(
//             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
//             minWidth: 10,
//             padding: EdgeInsets.zero,
//             label: Text(''),
//             icon: Padding(
//               padding: const EdgeInsets.only(left: 5),
//               child: Icon(Icons.colorize_sharp),
//             ),
//             onPressed: () {
//               addProductController.showDialogPickerColor(context);
//             },
//             // child: const Text(''),
//             color: addProductController.currentColor.value,
//             textColor: useWhiteForeground(addProductController.currentColor.value) ? const Color(0xffffffff) : const Color(0xffffffff),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: addProductController.currentColor.value,
//             ),
//             height: Get.height * .19,
//             width: Get.height * .2,
//             child: Column(
//               children: [
//                 addProductController.imagePickerPath.value == ''
//                     ? Container(
//                         width: double.infinity,
//                         height: Get.height * .12,
//                         // decoration: BoxDecoration(border: Border(bottom: BorderSide.)),
//                         child: Center(
//                           child: Text(
//                             addProductController.labelName.value,
//                             style: TextStyle(color: useWhiteForeground(addProductController.currentColor.value) ? const Color(0xffffffff) : const Color(0xffffffff)),
//                           ),
//                         ),
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: Image.file(
//                           File(addProductController.imagePickerPath.value),
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: Get.height * .12,
//                         ),
//                       ),
//                 //  Divider(color: Colors.,),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   addProductController.labelName.value ?? 'label.product_name'.tr,
//                   style: TextStyle(color: useWhiteForeground(addProductController.currentColor.value) ? const Color(0xffffffff) : const Color(0xffffffff)),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   '${$Number.numberFormat(int.tryParse(addProductController.labelPrice.value) ?? 0)} ??',
//                   style: TextStyle(color: useWhiteForeground(addProductController.currentColor.value) ? const Color(0xffffffff) : const Color(0xffffffff)),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           InkWell(
//             onTap: () {
//               addProductController.addImageModalBottomSheet(context);
//             },
//             child: Image.asset('assets/icons/picture.png', height: 40),
//           )
//         ],
//       ),
//     );
//   }
// }
