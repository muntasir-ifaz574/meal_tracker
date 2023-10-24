import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/custom_text_style.dart';

final customWidget = _CustomWidget();

class _CustomWidget {

  AppBar? appbar({String? title, actions, backgroundColor}) {
    return AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: kWhiteColor,
        titleTextStyle: TextStyle(color: backgroundColor ?? kThemeColor),
        toolbarTextStyle: TextStyle(color: backgroundColor ?? kThemeColor),
        iconTheme: IconThemeData(color: backgroundColor ?? kThemeColor),
        title: Text(title ?? "", style: kLargeTitleTextStyle),
        actions: actions
    );
  }

  showCustomSnackbar(context, String? errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(48.0)
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.red)
          ),
          const SizedBox(width: 8.0),
          Flexible(child: Text(errorMessage ?? "Something went wrong! Please try again.", style: const TextStyle(color: kWhiteColor))),
        ],
      ),
      duration: const Duration(seconds: 3),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }
}