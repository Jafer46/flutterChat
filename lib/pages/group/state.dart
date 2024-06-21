import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/common/entities/group.dart';
import 'package:get/get.dart';

class GroupState {
  RxList<Group> msgList = <Group>[].obs;
}
