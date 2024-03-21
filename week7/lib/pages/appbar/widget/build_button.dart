import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/token.dart';
import '../../feed/widget/CreatePost.dart';
import '../../search/controller/search_bar.dart';

Widget buildActionHome(context, title, icon) {
  return InkWell(
      onTap: () async {
        if (title == "Create") {
          // customCreatePostDialog(context);
        
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePost(),
            ),
          );
        }
        if (title == "Search") {
          showSearch(
            context: context,
            delegate: CustomSearch(),
          );
        }
      },
      child: Container(
        width: 8.w,
        margin: EdgeInsets.only(bottom: 2.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 23.sp,
          // color: Theme.of(context).buttonTheme.colorScheme!.primary,
        ),
      ));
}
