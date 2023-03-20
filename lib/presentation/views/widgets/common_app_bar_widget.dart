import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/base_constants.dart';

class CommonAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const CommonAppBarWidget({Key? key, this.leading, this.trailing, this.title})
      : super(key: key);

  final Widget? leading;
  final List<Widget>? trailing;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? const SizedBox.shrink(),
      title: Center(child: Text(title ?? "Appbar")),
      actions: trailing,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(BaseConstants.appBarHeight);
}
