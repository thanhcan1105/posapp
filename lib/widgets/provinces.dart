// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos_app/models/province.dart';
// import 'package:pos_app/repositories/provinces_asset.dart';
// import 'package:pos_app/ultils/validation.dart';
// import 'package:pos_app/widgets/controllers/province_controller.dart';

// class BuildProvinceField extends StatefulWidget {
//   final bool validate;
//   final String validateErrorText;
//   final bool isFilter;
//   const BuildProvinceField({
//     Key? key,
//     this.validate = false,
//     required this.validateErrorText,
//     this.isFilter = false,
//   }) : super(key: key);
//   @override
//   _BuildProvinceFieldState createState() => _BuildProvinceFieldState();
// }

// class _BuildProvinceFieldState extends State<BuildProvinceField> {
//   List<Data>? listProvince;
//   List<Districts>? _districts;
//   // ignore: unused_field
//   List<String>? _subDistricts;
//   String? selectedDistrictString;
//   // ignore: unused_field
//   String? _selectedSubDistrictString;
//   Data? _city;
//   Districts? _district;
//   bool? _validate;
//   // @override
//   // void initState() {
//   //   _validate = widget.validate;
//   // }
//   @override
//   void initState() {
//     super.initState();
//     _validate = widget.validate;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provinceController = Get.put(ProvinceController());
//     return FutureBuilder(
//       future: parseJsonFromAssets('assets/province.json'),
//       // ignore: missing_return
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data != null) {
//             List<Data>? _listProvince = Province.fromJson(snapshot.data).data;
//             return Padding(
//                 padding: EdgeInsets.only(left: 0, right: 0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                                 //color: Colors.red,
//                                 border: Border.all(color: Colors.grey, width: 2),
//                                 borderRadius: BorderRadius.all(Radius.circular(20))),
//                             child: DropdownSearch<Data>(
//                               items: _listProvince,
//                               label: "T???nh/TP",
//                               //label: "T???nh/TP *",
//                               showClearButton: false,
//                               //popupItemBuilder: _cityPopup,
//                               onChanged: (value) {
//                                 // widget.province_bloc.eventController.sink.add(ChangeCityEvent(value.province));

//                                 setState(() {
//                                   _city = value;
//                                   selectedDistrictString = null;
//                                   _selectedSubDistrictString = null;
//                                   _districts = value.districts;
//                                   _district = null;
//                                 });
//                                 // print(cityState.city);
//                               },

//                               dropdownSearchDecoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
//                               ),
//                               itemAsString: (Data province) => province.province,
//                               searchBoxDecoration: InputDecoration(
//                                 // border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.all(0),
//                                 // contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                                 labelText: "Ch???n T???nh/TP",
//                               ),
//                               showSearchBox: true,
//                               //dropdownBuilder: _customDropDownExample,
//                               mode: Mode.BOTTOM_SHEET,
//                               showSelectedItem: false,
//                               selectedItem: _city,
//                               validator: (Data v) {
//                                 if (_validate! && v == null) return 'Vui l??ng ch???n t???nh/TP';
//                                 return null;
//                               },
//                               // popupItemDisabled: (String s) => s.startsWith('I'),
//                             ),
//                           ),
//                         ),
//                         // SizedBox(
//                         //   width: 5,
//                         // ),
//                         // Container(
//                         //   height: 40,
//                         //   child: VerticalDivider(
//                         //     color: Colors.grey,
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         StreamBuilder<bool>(
//                           stream: null,
//                           builder: (context, snapshot) {
//                             if (_districts != null) {
//                               // Handle sort districts
//                               _districts!.sort((l, r) {
//                                 String lastLeftCharacter = l.district!.split(' ').last;
//                                 String lastRightCharacter = r.district!.split(' ').last;

//                                 if (Validator.isNumber(lastLeftCharacter) && Validator.isNumber(lastRightCharacter)) {
//                                   return int.parse(lastRightCharacter) < int.parse(lastLeftCharacter) ? 1 : -1;
//                                 }

//                                 return (l.district)!.compareTo(r.district!);
//                               });
//                             }

//                             return Expanded(
//                               child: Container(
//                                 //padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                     //color: Colors.red,
//                                     border: Border.all(color: Colors.grey, width: 2),
//                                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                                 child: DropdownSearch<Districts>(
//                                   mode: Mode.BOTTOM_SHEET,
//                                   //showSelectedItem: true,
//                                   items: _districts, //..sort((a, b) => (a.district).compareTo(b.district)),
//                                   // label: cityState.district == null ? "Qu???n/Huy???n *" : cityState.district,
//                                   label: "Qu???n/Huy???n",
//                                   itemAsString: (Districts district) => district.district,
//                                   // popupItemDisabled: (String s) =>
//                                   //     s.startsWith('I'),
//                                   dropdownSearchDecoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.only(left: 15, right: 15),
//                                   ),
//                                   searchBoxDecoration: InputDecoration(
//                                     contentPadding: EdgeInsets.all(0),
//                                     // border: OutlineInputBorder(),
//                                     // contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                                     labelText: "Ch???n Qu???n/Huy???n",
//                                   ),
//                                   showSearchBox: true,
//                                   showClearButton: false,
//                                   selectedItem: _district,
//                                   onChanged: (value) {
//                                     print(value.district);
//                                     // widget.province_bloc.eventController.sink.add(ChangeDistrictEvent(value.district));

//                                     setState(
//                                       () {
//                                         _district = value;
//                                         selectedDistrictString = value.district;
//                                         _selectedSubDistrictString = null;
//                                         _subDistricts = value.subDistricts;
//                                       },
//                                     );
//                                   },
//                                   validator: (v) {
//                                     if (_validate! && v == null) return 'Vui l??ng ch???n qu???n/huy???n';
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     )
//                     //Divider(),
//                     // Row(
//                     //   children: [
//                     //     StreamBuilder<bool>(
//                     //       stream: null,
//                     //       builder: (context, snapshot) {
//                     //         if (_subDistricts != null) {
//                     //           // Handle sort
//                     //           _subDistricts.sort((l, r) {
//                     //             String lastLeftCharacter = l.split(' ').last;
//                     //             String lastRightCharacter = r.split(' ').last;

//                     //             if (Validator.isNumber(lastLeftCharacter) &&
//                     //                 Validator.isNumber(lastRightCharacter)) {
//                     //               return int.parse(lastRightCharacter) <
//                     //                       int.parse(lastLeftCharacter)
//                     //                   ? 1
//                     //                   : -1;
//                     //             }

//                     //             return (l).compareTo(r);
//                     //           });
//                     //         }

//                     //         return Expanded(
//                     //           child: DropdownSearch<String>(
//                     //             items: _subDistricts,
//                     //             label: "X??/Ph?????ng",
//                     //             // label: "X??/Ph?????ng *",
//                     //             showClearButton: false,
//                     //             //popupItemBuilder: _cityPopup,
//                     //             onChanged: (value) {
//                     //               // widget.province_bloc.eventController.sink.add(ChangeWardEvent(value));
//                     //               if (widget.isFilter)
//                     //                 setState(() {
//                     //                   _selectedSubDistrictString = value;
//                     //                 });
//                     //               print(value);
//                     //               // _getListDisctrict(value['id']);
//                     //             },
//                     //             dropdownSearchDecoration: InputDecoration(
//                     //               border: InputBorder.none,
//                     //               contentPadding:
//                     //                   EdgeInsets.only(left: 15, right: 15),
//                     //             ),
//                     //             itemAsString: (subDistrict) => subDistrict,
//                     //             searchBoxDecoration: InputDecoration(
//                     //               // border: OutlineInputBorder(),
//                     //               contentPadding:
//                     //                   EdgeInsets.fromLTRB(12, 12, 8, 0),
//                     //               labelText: "Ch???n X??/Ph?????ng",
//                     //             ),
//                     //             showSearchBox: true,
//                     //             //dropdownBuilder: _customDropDownExample,
//                     //             mode: Mode.BOTTOM_SHEET,
//                     //             // showSelectedItem: true,
//                     //             // popupItemDisabled: (String s) => s.startsWith('I'),
//                     //             selectedItem: _selectedSubDistrictString,
//                     //             validator: (v) {
//                     //               if (_validate && v == null)
//                     //                 return 'Vui l??ng ch???n x??/ph?????ng';
//                     //               return null;
//                     //             },
//                     //           ),
//                     //         );
//                     //       },
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ));
//           } else if (snapshot.hasError) {
//             return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)));
//           }
//         } else {
//           return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)));
//         }
//       },
//     );
//   }

//   // ignore: unused_element
//   Widget _cityPopup(BuildContext context, _provinces, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: !isSelected
//           ? null
//           : BoxDecoration(
//               //border: Border.all(color: Theme.of(context).primaryColor),
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.white,
//             ),
//       child: ListTile(
//           // selected: isSelected,
//           title: Text("")
//           //subtitle: Text(provinces['city_name'].toString()),
//           ),
//     );
//   }
// }
