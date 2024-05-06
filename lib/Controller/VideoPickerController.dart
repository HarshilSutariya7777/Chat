import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VideoPickerController extends GetxController {
  final ImagePicker picker = ImagePicker();

  Future<String> pickVideo() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return video.path;
    } else {
      return "";
    }
  }
}
