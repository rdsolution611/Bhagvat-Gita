import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingnew/custom_widget/custom_widget.dart';

class BhagwadDetails extends StatefulWidget {
  static const String route = "/BhagwadDetails";
  const BhagwadDetails({super.key});

  @override
  State<BhagwadDetails> createState() => _BhagwadDetailsState();
}

class _BhagwadDetailsState extends State<BhagwadDetails> {
  final dataAll = Get.arguments;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final details = dataAll['Adhyay_shlok']['detais'];

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
        appBar: CustomAppBar(
          title: '${dataAll['Adhyay_shlok']['adhyay_name']}',
        ),
        body: details.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + kToolbarHeight,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/BhagwadFullDetails',
                          arguments: {
                            'index': details[index]['slok'],
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${index + 1}. ${details[index]['slok']}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  'No Data Found',
                  style: GoogleFonts.balooBhai2(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff257180),
                  ),
                ),
              ),
      ),
    );
  }
}
