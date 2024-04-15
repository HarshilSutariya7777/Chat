import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Config/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.offAllNamed("/authPage");
      },
      sliderButtonIcon: Container(
        width: 25,
        height: 25,
        child: SvgPicture.asset(
          Assetimage.plugSVG,
          width: 25,
        ),
      ),
      submittedIcon: SvgPicture.asset(
        Assetimage.connectSVG,
        width: 25,
      ),
      text: WelcomePageString.slidetoStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
