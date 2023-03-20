import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/base_color.dart';
import 'package:yaho_demo/common/styles/base_text_style.dart';
import 'package:yaho_demo/gen/assets.gen.dart';

enum UserContentType { empty, error }

class UserContentPlaceholderWidget extends StatelessWidget {
  const UserContentPlaceholderWidget({Key? key, required this.type})
      : super(key: key);

  final UserContentType type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: 300, height: 300, child: _getImageByContentType(type)),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              _getTextByContentType(type),
              textAlign: TextAlign.center,
              style: BaseTextStyle.heading2(color: BaseColor.blue800),
            ),
          )
        ],
      ),
    );
  }

  Widget _getImageByContentType(UserContentType type) {
    switch (type) {
      case UserContentType.empty:
        return Assets.images.emptyPlaceholder.image();
      case UserContentType.error:
        return Assets.images.errorPlaceholder.image();
    }
  }

  String _getTextByContentType(UserContentType type) {
    switch (type) {
      case UserContentType.empty:
        return "Oops. We did not find any users out there 🫣";
      case UserContentType.error:
        return "Oops. We got some connection problems 🥲\n Please try again later.";
    }
  }
}
