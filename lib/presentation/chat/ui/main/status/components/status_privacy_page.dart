import 'package:flutter/material.dart';

class StatusPrivacyPage extends StatelessWidget {
  static const String routeName = 'status-privacy';

  const StatusPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //default privacy
    return Scaffold(
        appBar: AppBar(
          title: const Text('Privacy',
              style: TextStyle(color: Colors.black, fontSize: 30)),
        ),
        body: const Center(
            child: Text(
          'Any changes you make will affect all of your status updates',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: true,
          textScaleFactor: 1.5,
          textWidthBasis: TextWidthBasis.longestLine,
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: true,
            applyHeightToLastDescent: false,
          ),
        )));
  }
}
