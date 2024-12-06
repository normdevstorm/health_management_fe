
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryItemPage extends StoryItem {
  final Color color;
  final String caption;
  final String photoUrl;

  StoryItemPage({
    required this.color,
    required this.caption,
    required this.photoUrl,
    required Duration duration,
    bool shown = false,
  }) : super(
    _buildPageView(color, caption, photoUrl),
    duration: duration,
    shown: shown,
  );

  static Widget _buildPageView(Color color, String caption, String photoUrl) {
    return CustomStoryView(color: color, caption: caption, photoUrl: photoUrl);
  }
}



class CustomStoryView extends StatelessWidget {
  final Color color;
  final String caption;
  final String photoUrl;

  const CustomStoryView({
    Key? key,
    required this.color,
    required this.caption,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String shortenedCaption = caption.length > 20 ? "${caption.substring(0, 20)}" : caption;
    final String seeMoreText = caption.length > 20 ? "...see more" : "";
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.network(
            photoUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: shortenedCaption,
                  style: TextStyle(
                    fontSize: 30,
                    color: color,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: seeMoreText,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

