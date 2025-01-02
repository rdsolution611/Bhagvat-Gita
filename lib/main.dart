import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingnew/Routes/routes.dart' as r;
import 'package:testingnew/ads_service/app_module.dart';
import 'package:testingnew/screens/splash_screen/splash_screen.dart';

import 'ads_service/FirebaseService.dart';
import 'ads_service/argument_const.dart';

RxBool appOpen = false.obs;
RxBool banner = false.obs;
RxBool interstitial = false.obs;
RxBool native = false.obs;
RxBool reward = false.obs;
RxBool appOpenAdRunning = false.obs;
RxBool interstitialAdRunning = false.obs;
RxString appOpenID = "".obs;
RxString bannerID = "".obs;
RxString interstitialID = "".obs;
RxString rewardID = "".obs;
RxString nativeID = "".obs;
RxString androidAdsId = "".obs;
RxInt interShowTime = 0.obs;
RxInt rewardShowTime = 0.obs;
RxInt appOpenShowTime = 0.obs;
RxBool adaptiveBannerSize = false.obs;
RxBool showTestAds = false.obs;

bool isIpad = false;
bool isSmallDevice = false;

final box = GetStorage();
final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseDatabaseHelper().adsVisible();
  await GetStorage.init();
  if (isNullEmptyOrFalse(box.read(ArgumentConstant.isInterstitialStartTime))) {
    box.write(ArgumentConstant.isInterstitialStartTime, 0);
  }
  if (isNullEmptyOrFalse(box.read(ArgumentConstant.isRewardStartTime))) {
    box.write(ArgumentConstant.isRewardStartTime, 0);
  }
  if (isNullEmptyOrFalse(box.read(ArgumentConstant.isAppOpenStartTime))) {
    box.write(ArgumentConstant.isAppOpenStartTime, 0);
  }
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isIpad = true;
    } else if (MediaQuery.of(context).size.width < 420) {
      isSmallDevice = true;
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: r.Router.onRouteGenerator,
          home: SplashScreen(),
        );
      },
    );
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
