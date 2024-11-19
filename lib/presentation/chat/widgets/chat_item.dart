import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/managers/size_manager.dart';
import 'package:health_management/presentation/common/tag_chip.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subTitle;
  final String? time;
  final Widget? titleButton;
  final int numOfMessageNotSeen;
  final VoidCallback onTap;
  final VoidCallback? onLeadingTap;
  final String? roleTag;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.time,
    this.numOfMessageNotSeen = 0,
    this.titleButton,
    required this.onTap,
    this.onLeadingTap,
    this.roleTag,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading ??
          InkWell(
            onTap: onLeadingTap,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset("assets/user_default.png"),
            ),
          ),
      title: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  //style: context.headlineSmall,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (roleTag != null) ...[
                  5.horizontalSpace,
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 35.w,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AspectRatio(
                      aspectRatio: 35 / 15,
                      child: Center(
                        child: Text(
                          roleTag!,
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          5.horizontalSpace,
          if (time != null)
            Text(
              time!,
              style: numOfMessageNotSeen > 0
                  ? Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.blueAccent)
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          if (titleButton != null)
            SizedBox(
              height: 40,
              child: titleButton!,
            ),
        ],
      ),
      subtitle: subTitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                children: [
                  //Icon(Icons.done_all,size: 20,),
                  Expanded(
                    child: Text(
                      subTitle!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (numOfMessageNotSeen > 0)
                    CircleAvatar(
                      minRadius: 12,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          numOfMessageNotSeen.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }
}
