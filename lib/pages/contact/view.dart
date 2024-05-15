import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/contact/controller.dart';
import 'package:flutter_chat/pages/contact/widgets/contact_list.dart';
import 'package:get/get.dart';

class ContactPage extends GetView {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    // AppBar _buildAppBar() {
    //   return AppBar(
    //     backgroundColor: primary.shade100,
    //   );
    // }

    return Scaffold(
        //appBar: _buildAppBar(),
        body: Container(
      color: Colors.redAccent,
      child: const ContactList(),
    ));
  }
}
