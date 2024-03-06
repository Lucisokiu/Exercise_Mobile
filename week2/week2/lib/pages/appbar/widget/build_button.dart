import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';



Widget buildActionHome(context, title, icon) {
  return InkWell(
      onTap: () async {
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
