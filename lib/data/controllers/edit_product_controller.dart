import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/color.dart';
import 'package:pos_app/widgets/common/dialog.dart';

class EditProductController extends GetxController {
// final AddProductRepo repository;
// AddProductController({@required this.repository}) : assert(repository != null);

// Dio dio = new Dio();
// FormData formdata = new FormData(); // just like JS
// formdata.add("photos", new UploadFileInfo(_image, basename(_image.path)));
// dio.post(uploadURL, data: formdata, options: Options(
// method: 'POST',
// responseType: ResponseType.PLAIN // or ResponseType.JSON
// ))
// .then((response) => print(response))
// .catchError((error) => print(error));

  EditProductController() {
    oldProduct = (Get.arguments);
    productId = oldProduct.id!;
    nameProduct.text = oldProduct.name!;
    priceProduct.text = oldProduct.price.toString();
    stockController.text = oldProduct.stock.toString();
    noteController.text = oldProduct.note!;
    barcodeController.text = oldProduct.barCode!;
    promoPriceController.text = oldProduct.promoPrice?.toString() ?? '0';
    oldImageUrl = oldProduct.imageUrl!;
    labelName.value = oldProduct.name!;
    labelPrice.value = oldProduct.price.toString();
    catelogId.value = oldProduct.catelogId!;
    currentColor.value = oldProduct.color == '' ? Palette.primaryColor : ColorFormat.stringToColor(oldProduct.color!);
  }
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  MasterStore masterStore = Get.find<MasterStore>();
  RxList<ProductModel> products = <ProductModel>[].obs;
  late ProductModel oldProduct;
  late int productId;
  var pickerColor = Palette.primaryColor.obs;
  var currentColor = Palette.primaryColor.obs;
  var labelName = 'T??n m??n'.obs;
  var labelPrice = '0'.obs;
  var imagePickerPath = ''.obs;
  var oldImageUrl = '';
  late RxInt catelogId = 0.obs;
  final ImagePicker _picker = ImagePicker();
  late File selectedImage;

  TextEditingController nameProduct = new TextEditingController();
  TextEditingController priceProduct = new TextEditingController();
  TextEditingController stockController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  TextEditingController barcodeController = new TextEditingController();
  TextEditingController promoPriceController = new TextEditingController();

  onChangeNameProduct(value) {
    labelName.value = value;
  }

  onChangePriceProduct(value) {
    labelPrice.value = value;
  }

  void changeColor(Color color) {
    pickerColor.value = color;
    currentColor.value = color;
    Get.back();
  }

  setCatelogId(id) {
    print(catelogId.value);

    return catelogId.value = id;
  }

  void updateProduct() async {
    //print(MasterStore.products);
    // if (selectedImage.isNull) {
    //   Get.back();
    //   return AppUltils().getSnackBarError(message: 'Vui l??ng ch???n ???nh cho m??n');
    // }
    if (nameProduct.text == '') {
      Get.back();
      return AppUltils().getSnackBarError(message: 'Vui l??ng ch???n t??n cho m??n');
    }
    if (nameProduct.text == '') {
      Get.back();
      return AppUltils().getSnackBarError(message: 'Vui l??ng ch???n t??n cho m??n');
    }
    var data = {
      'id': productId.toString(),
      'name': nameProduct.text.toString(),
      'price': priceProduct.text.toString(),
      'promoprice': promoPriceController.text.toString(),
      'note': noteController.text.toString(),
      'barcode': barcodeController.text.toString(),
      'stock': stockController.text.toString(),
      'catelog_id': catelogId.toString(),
      'color': ColorFormat.colorToString(currentColor.value).toString()
    };
    print(data);
    print(selectedImage);
    var result = await ProductService().updateProduct(id: productId, file: selectedImage, data: data);
    // print(result.body);
    if (!result.isNull) AppUltils().getSnackBarSuccess(message: 'S???a s???n ph???m th??nh c??ng');
    await getProductAll();
    masterStore.products = products;
    Get.back();
    Get.back();
    Get.back();
    //Get.reset();
  }

  Future getProductAll() async {
    var response = (await ProductService().getProductAll());
    print(response);
    products.assignAll(response!.map((e) => ProductModel.fromJson(e)).toList());
    //return products;
    //print(catelogies[0].name);
  }

  Future deleteProduct() async {
    DialogConfirm()
        .info(
          context: Get.context,
          title: "B???n c?? ch???c ch???n?",
          desc: "Xo?? menu l?? kh??ng th??? ph???c h???i",
        )
        .onCancel(
          text: "????ng l???i",
        )
        .onConfirm(
          text: "?????ng ??",
          onPress: () async {
            // ignore: unused_local_variable
            var response = (await ProductService().deleteProduct(productId));
            // await getProductAll();
            var position = masterStore.products.indexWhere((element) => element.id == productId);
            masterStore.products = masterStore.products..removeAt(position);
            Get.back();
            Get.back();
          },
        )
        .show(hideIcon: false);

    // print(response);
    // products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    //return products;
    //print(catelogies[0].name);
  }

  showDialogPickerColor(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ch???n m??u cho s???n ph???m'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor.value,
              onColorChanged: changeColor,
            ),
          ),
        );
      },
    );
  }

  addImageModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Image.asset(
                  'assets/icons/camera.png',
                  height: 30,
                ),
                title: new Text('common.shoot'.tr),
                onTap: () {
                  //Get.to(AddPostScreen());
                  getImage(from: ImageSource.camera);
                },
              ),
              new ListTile(
                leading: Image.asset(
                  'assets/icons/picture.png',
                  height: 30,
                ),
                title: new Text('common.select_from_gallery'.tr),
                onTap: () {
                  getImage(from: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage({ImageSource? from}) async {
    final pickedFile = await ImagePicker().pickImage(source: from!, imageQuality: 100);
    if (pickedFile != null) {
      imagePickerPath.value = (pickedFile.path);
      selectedImage = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
