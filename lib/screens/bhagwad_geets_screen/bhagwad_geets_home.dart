import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testingnew/controller/controller.dart';
import 'package:testingnew/custom_widget/custom_widget.dart';

class BhagavadGeetaHome extends StatelessWidget {
  static const String route = "/BhagavadGeetaHome";
  const BhagavadGeetaHome({super.key});

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
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(title: 'Shri Bhagavad Gita'),
        body: GetBuilder<Api>(
          init: Api(),
          builder: (controller) {
            return controller.bhagwad.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top +
                          kTextTabBarHeight +
                          20,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.bhagwad.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/BhagwadDetails', arguments: {
                                  'Adhyay_shlok': controller.bhagwad[index]
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  '${controller.bhagwad[index]['adhyay_name']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            if (index < controller.bhagwad.length - 1)
                              Divider(
                                color: Colors.black.withOpacity(0.2),
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                          ],
                        );
                      },
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
