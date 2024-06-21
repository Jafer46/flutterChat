import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/contact/controller.dart';
import 'package:flutter_chat/pages/contact/widgets/contact_list.dart';
import 'package:get/get.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    AppBar buildAppBar() {
      return AppBar(
        title: SearchBar(
          controller: controller.searchController,
        ),
        backgroundColor: primary.shade100,
      );
    }

    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 66, 69, 78),
              AppColor.primary,
            ],
          )),
          child: const ContactList(),
        ));
  }
}
