import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../main.dart';

class BhagwadFullDetails extends StatefulWidget {
  static const String route = "/BhagwadFullDetails";
  const BhagwadFullDetails({super.key});

  @override
  State<BhagwadFullDetails> createState() => _BhagwadFullDetailsState();
}

class _BhagwadFullDetailsState extends State<BhagwadFullDetails> {
  final args = Get.arguments;
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    List favorites = box.read('favorites') ?? [];
    isFavorite = favorites.contains(args['index']);
  }

  void toggleFavorite() {
    List favorites = box.read('favorites') ?? [];
    setState(() {
      if (isFavorite) {
        favorites.remove(args['index']);
        isFavorite = false;
      } else {
        favorites.add(args['index']);
        isFavorite = true;
      }
      box.write('favorites', favorites);
    });
  }

  void copyToClipboard() {
    Clipboard.setData(
      ClipboardData(
        text: args['index'].toString(),
      ),
    );
    Get.snackbar(
      backgroundColor: Colors.white,
      'Copied to Clipboard',
      'The Bhagwad Geet has been copied to your clipboard.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void shareContent() {
    Share.share(args['index'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
          color: Colors.black12,
          image: DecorationImage(
            opacity: 0.2,
            image: AssetImage('assets/geet_bg.jpeg'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text(
            'Bhagwad Full Details',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '${args['index']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 25.sp,
                    ),
                    onPressed: toggleFavorite,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                    onPressed: copyToClipboard,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                    onPressed: shareContent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
