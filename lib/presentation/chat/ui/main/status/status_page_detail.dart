
import 'package:flutter/material.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/domain/chat/models/status_model.dart';
import 'package:health_management/presentation/chat/ui/main/status/components/custom_story_item.dart';
import 'package:health_management/presentation/chat/widgets/custom_loading.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';


class StatusDetailPage extends StatefulWidget {
  static const routeName = "status-detail";
  final StatusModel status;
  final bool isMyStatus;

  const StatusDetailPage(
      {super.key, required this.status, required this.isMyStatus});

  @override
  State<StatusDetailPage> createState() => _StatusDetailPageState();
}

class _StatusDetailPageState extends State<StatusDetailPage> {
  int currentIndex = 0;
  StoryController storyController = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItemPage(
          color: Colors.red,
          caption: widget.status.caption[i],
          photoUrl: widget.status.photoUrl[i],
          duration: const Duration(seconds: 5)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const CustomLoading(
              borderColor: Colors.green,
              backgroundColor: Colors.grey,
              size: 20,
              opacity: 0.5)
          : Stack(
              children: [
                StoryView(
                  storyItems: storyItems,
                  controller: storyController,
                  onComplete: () => Navigator.of(context).pop(),
                  onVerticalSwipeComplete: (direction) {
                    Navigator.pop(context);
                  },
                  onStoryShow: (s) {
                    int index = storyItems.indexOf(s);
                    if (index != currentIndex) {
                      currentIndex = index;
                      updateProfileView();
                    }
                  },
                ),
                _buildProfileView()
              ],
            ),
    );
  }

  void updateProfileView() {
    setState(() {});
  }

  Container _buildProfileView() {
    return Container(
        padding: const EdgeInsets.only(
          top: 48,
          left: 16,
          right: 16,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.status.profilePicture),
            radius: 25,
          ),
          title: Text(
            widget.isMyStatus ? "My Status" : widget.status.username,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.primaryColor),
          ),
          subtitle: Text(
            widget.status.createdAt[currentIndex].getStatusTime24HoursMode,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
        ));
  }
}
