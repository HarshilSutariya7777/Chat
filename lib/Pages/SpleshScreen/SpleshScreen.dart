import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/SpleshController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SpleshScreenPage extends StatelessWidget {
  const SpleshScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    SpleshController spleshController = Get.put(SpleshController());
    return Scaffold(
      body: Center(child: SvgPicture.asset(Assetimage.appIconSVG)),
    );
  }
}
