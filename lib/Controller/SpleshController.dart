import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SpleshController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    SplaceHandle();
  }

  void SplaceHandle() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (auth.currentUser == null) {
      Get.offAllNamed("/authPage");
    } else {
      Get.offAllNamed("/homePage");
      print(auth.currentUser!.email);
    }
  }
}
