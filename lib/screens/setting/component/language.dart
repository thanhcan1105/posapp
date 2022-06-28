import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class LanguageScreen extends GetView {
  GetStorage box = GetStorage();
  changeLanguage(String languageCode, String countryCode) {
    Get.updateLocale(Locale(languageCode, countryCode));
    box.write('_language_code', languageCode);
    box.write('_country_code', countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        title: 'common.language'.tr,
      ),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  changeLanguage('en', 'US');
                },
                child: RowSettingItem(
                  title: 'English'.tr,
                  image: 'assets/flag_icon/us.png',
                ),
              ),
              InkWell(
                onTap: () {
                  changeLanguage('vi', 'VN');
                },
                child: RowSettingItem(
                  title: 'Tiếng việt'.tr,
                  image: 'assets/flag_icon/vi.png',
                ),
              ),
              // RowSettingItem(
              //   title: 'Hoá đơn',
              //   icon: Icons.receipt,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class RowSettingItem extends StatelessWidget {
  const RowSettingItem({Key? key, this.title, this.image}) : super(key: key);

  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset(image!),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title!,
              style: Palette.titleProduct(),
            ),
          ),
          // Icon(
          //   FontAwesome.chevron_right,
          //   color: Colors.blueGrey,
          //   size: 20,
          // )
        ],
      ),
    );
  }
}
