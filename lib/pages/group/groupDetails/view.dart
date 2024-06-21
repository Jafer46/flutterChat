import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/group/groupDetails/index.dart';
import 'package:flutter_chat/pages/group/groupDetails/widget/userList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupDetailsPage extends GetView<GroupDetailsController> {
  const GroupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Members"),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                TextButton(
                  onPressed: () {},
                  child: const Text("Add"),
                )
              ],
            ),
          ),
          Expanded(child: UserList())
        ],
      ),
    );
  }
}
