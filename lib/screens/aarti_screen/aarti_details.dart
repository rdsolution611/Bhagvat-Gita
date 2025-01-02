import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AartiDetails extends StatefulWidget {
  static const String route = "/AartiDetails";

  const AartiDetails({super.key});

  @override
  State<AartiDetails> createState() => _AartiDetailsState();
}

class _AartiDetailsState extends State<AartiDetails> {
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: .2,
          image: NetworkImage('${args['bc_image']}'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            args['Heading'] ?? 'Aarti Details',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 1.0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top:
                MediaQuery.of(context).viewPadding.top + kTextTabBarHeight + 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(12.0),
                //   child: CachedNetworkImage(
                //     imageUrl: '${args['bc_image']}',
                //     placeholder: (context, url) => const Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //     errorWidget: (context, url, error) => Container(
                //       height: 200,
                //       width: double.infinity,
                //       color: Colors.grey.shade300,
                //       child: const Icon(
                //         Icons.broken_image,
                //         size: 100,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     fit: BoxFit.cover,
                //     width: double.infinity,
                //     // height: 350,
                //   ),
                // ),

                const SizedBox(height: 12.0),
                Center(
                  child: Text(
                    (args['aarti'] ?? '').replaceAll('<br>', '\n'),
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.7,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
