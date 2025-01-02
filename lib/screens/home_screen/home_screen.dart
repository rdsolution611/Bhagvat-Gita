import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testingnew/ads_service/ad_services.dart';
import 'package:testingnew/ads_service/banner_ads_show.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  static const String route = "/HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {"name": "આરતી", "image": 'assets/aarti.jpeg'},
    {"name": "શ્રીમદ ભગવદગીતા", "image": 'assets/geet_bg.jpeg'},
    {"name": "ભજન", "image": 'assets/bhajan.jpg'},
    {"name": "મહાભારત વાર્તા", "image": 'assets/mahabharat.jpg'},
    {"name": "સુવિચાર", "image": 'assets/suvichar.jpg'},
    {"name": "મનપસંદ", "image": 'assets/favourite.jpg'},
    {"name": "સેટિંગ્સ", "image": 'assets/setting.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
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
        appBar: AppBar(
          title: Text(
            "શ્રીમદ ભગવદગીતા",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
          ),
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 350,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3 / 2,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  getIt<AdService>().loadInterstitialAd();
                  try {
                    getIt<AdService>().showInterstitialAd();
                  } catch (e) {
                    print("not loaded");
                  } finally {
                    if (index == 0) {
                      Get.toNamed('/AartiHome', arguments: 'Aarti');
                    } else if (index == 1) {
                      Get.toNamed('/BhagavadGeetaHome');
                    } else if (index == 2) {
                      Get.toNamed('/AartiHome', arguments: 'Bhajan');
                    } else if (index == 3) {
                      Get.toNamed('/AartiHome', arguments: 'Mahabharat');
                    } else if (index == 4) {
                      Get.toNamed('/SuvicharPage');
                    } else if (index == 5) {
                      Get.toNamed('/FavoritePage');
                    } else if (index == 6) {
                      Get.toNamed('/SettingsPage');
                    }
                  }
                  // });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            items[index]['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        items[index]["name"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BannerAdsShow(),
      ),
    );
  }
}
