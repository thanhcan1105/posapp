import 'package:flutter/material.dart';

class CircleBorderAsset extends StatelessWidget {
  const CircleBorderAsset({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.circular,
  }) : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  final double circular;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        //border: Border.all(color: Colors.blue, width: 1),
        // boxShadow: [
        //   BoxShadow(
        //       color: Color(0x332222CC),
        //       blurRadius: 2,
        //       spreadRadius: 2,
        //       offset: Offset.fromDirection(0, 0)),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(circular),
        child: Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
