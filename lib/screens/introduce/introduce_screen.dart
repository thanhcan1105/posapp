import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pos_app/screens/auth/login_page.dart';

class Introduce extends StatelessWidget {
  const Introduce({
    Key? key,
  }) : super(key: key);

  void _onIntroEnd(context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => HomePage()),
    // );
    Get.offAllNamed('welcome');
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return LoginPage();
    //     },
    //   ),
    // );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19),
      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Container(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "common.welcome_to_popos".tr,
            body: "common.application_management".tr,
            image: _buildImage('img1'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "common.remote_manager".tr,
            body: "common.store_load_data_is_notified_and_updated_immediately".tr,
            image: _buildImage('img2'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "common.detailed_report".tr,
            body: "common.report_control_inventory_control_raw_materials".tr,
            image: _buildImage('img3'),
            decoration: pageDecoration,
          ),
          // PageViewModel(
          //   title: "Another title page",
          //   body: "Another beautiful body text for this example onboarding",
          //   image: _buildImage('img2'),
          //   footer: RaisedButton(
          //     onPressed: () {
          //       introKey.currentState?.animateScroll(0);
          //     },
          //     child: const Text(
          //       'FooButton',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     color: Colors.lightBlue,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //   ),
          //   decoration: pageDecoration,
          // ),
          // PageViewModel(
          //   title: "Title of last page",
          //   bodyWidget: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const [
          //       Text("Click on ", style: TextStyle(fontSize: 19.0)),
          //       Icon(Icons.edit),
          //       Text(" to edit a post", style: TextStyle(fontSize: 19.0))
          //     ],
          //   ),
          //   image: _buildImage('img1'),
          //   decoration: pageDecoration,
          // ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        // skipFlex: 0,
        nextFlex: 0,
        skip: Text('label.skip'.tr),
        next: const Icon(Icons.arrow_forward),
        done: Text('label.done'.tr, style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
