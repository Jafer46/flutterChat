import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/pages/group/widget/group_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  AppBar _biuldAppBar() {
    return AppBar(
      title: Text(
        "Group",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.SEARCHGROUP);
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _biuldAppBar(),
      body: const GroupList(),
    );
  }
}
