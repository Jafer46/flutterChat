import 'package:flutter/material.dart';
import 'package:flutter_chat/common/value/appColor.dart';
import 'package:flutter_chat/pages/group/searchGroup/index.dart';
import 'package:flutter_chat/pages/group/searchGroup/widgets/groupList.dart';
import 'package:get/get.dart';

class SearchGroupPage extends GetView<SearchGroupController> {
  const SearchGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: const SearchGroupList(),
        ));
  }
}
