import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testingnew/custom_widget/custom_widget.dart';

class SettingsPage extends StatefulWidget {
  static const String route = "/SettingsPage";
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, dynamic>> settingsOptions = [
    {
      'title': 'Privacy Policy',
      'icon': Icons.privacy_tip,
    },
    {
      'title': 'Contact Us',
      'icon': Icons.email,
    },
    {
      'title': 'Rate Us',
      'icon': Icons.star_rate,
    },
    {
      'title': 'Exit',
      'icon': Icons.exit_to_app,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffF26B0F),
            Color(0xffFCC737),
          ],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: 'Settings'),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
            left: 16.w,
            right: 16.w,
          ),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: settingsOptions.length,
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemBuilder: (context, index) {
              final option = settingsOptions[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                  } else if (index == 1) {
                  } else if (index == 2) {
                  } else if (index == 3) {
                    exit(0);
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option['icon'],
                        size: 28.sp,
                        color: const Color(0xffF26B0F),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Text(
                          option['title'],
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff333333),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
