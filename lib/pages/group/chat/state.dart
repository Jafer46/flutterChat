import 'package:flutter_chat/common/entities/msgcontent.dart';
import 'package:get/get.dart';

class GroupChatState {
  RxList<Msgcontent?> msgcontentList = <Msgcontent>[].obs;
  var groupName = "".obs;
  var groupAdmin = "".obs;
  var groupAvatar = "".obs;
}
