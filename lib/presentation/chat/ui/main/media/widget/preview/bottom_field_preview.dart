import 'package:flutter/material.dart';
import 'package:health_management/app/utils/constants/app_color.dart';

class BottomFieldPreview extends StatelessWidget {
  final VoidCallback onSendButtonTaped;
  final TextEditingController captionController;

  const BottomFieldPreview(
      {super.key,
      required this.onSendButtonTaped,
      required this.captionController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              // onChanged: onTextFieldValueChanged,
              controller: captionController,
              // focusNode: focusNode,
              cursorColor: AppColor.grey,
              maxLines: null,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.newline,
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Add Caption...',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        GestureDetector(
            onTap: onSendButtonTaped,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColor.blue,
              child: Icon(
                Icons.send,
                color: AppColor.black,
              ),
            )),
      ]),
    );
  }
}
