import 'package:flutter/material.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBack;
  const BasicAppBar({super.key, this.title, this.hideBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: title,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
