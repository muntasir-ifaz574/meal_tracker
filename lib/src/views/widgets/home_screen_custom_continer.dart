import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/colors.dart';
import '../utils/custom_text_style.dart';

Widget homeScreenCustomContainer (String image,String title,onTap){
  return Container(
    height: 20.h,
    width: 40.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: kThemeColor.withOpacity(0.25))
        ]),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Lottie.asset(
                    image),
              ),
            ),
            const Divider(
              color: kThemeColor,
              thickness: 1,
              indent : 10,
              endIndent : 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
               title,
                style: kHSubTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}