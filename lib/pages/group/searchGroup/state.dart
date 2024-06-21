import 'package:flutter_chat/common/entities/group.dart';
import 'package:get/get.dart';

class SearchGroupState {
  var count = 0.obs;
  RxList<Group> searchList = <Group>[].obs;
}
