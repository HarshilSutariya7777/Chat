import 'package:chatapp3/Model/UserModel.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMembers = <UserModel>[].obs;

//select Group Member and add into list.
  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }
}
