import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaho_demo/gen/assets.gen.dart';

class UserTrailingViewSwitchButton extends StatelessWidget {
  const UserTrailingViewSwitchButton({
    super.key,
    required this.isListView,
    required this.onTap,
  });

  final bool isListView;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SvgPicture.asset(
            isListView ? Assets.icons.gridViewIcon : Assets.icons.listViewIcon,
            width: 24,
            height: 24,
            alignment: Alignment.centerRight,
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor, BlendMode.srcIn),
          ),
        ));
  }
}
