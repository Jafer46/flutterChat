import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/common/entities/message.dart';
import 'package:get/get.dart';

class MessageState {
  RxList<QueryDocumentSnapshot<Msg>> msgList =
      <QueryDocumentSnapshot<Msg>>[].obs;
}
