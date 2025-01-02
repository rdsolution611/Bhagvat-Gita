import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testingnew/ads_service/app_lifecycle_reactor.dart';
import 'package:testingnew/main.dart';

import 'app_open_ad_manager.dart';

class FirebaseDatabaseHelper {
  Future<void> adsVisible() async {
    await FirebaseDatabase.instance
        .ref("BhagavadGita/Ads")
        .onValue
        .listen((DatabaseEvent event) async {
      Object? data = event.snapshot.value;
      Map<String, dynamic> getDataList = jsonDecode(jsonEncode(data));
      Map<String, dynamic> showAds = getDataList['showAds'];
      Map<String, dynamic> androidLiveAds = getDataList['androidLiveAds'];
      Map<String, dynamic> androidTestAds = getDataList['androidTestAds'];

      print("androidLiveAds:-  " + androidLiveAds.toString());
      print("androidTestAds:-  " + androidTestAds.toString());
      print("showAds:-  " + showAds.toString());

      appOpen.value = showAds['appOpenShow'];
      banner.value = showAds['bannerShow'];
      interstitial.value = showAds['interShow'];
      reward.value = showAds['reward'];
      interShowTime.value = showAds['interShowTime'];
      rewardShowTime.value = showAds['rewardShowTime'];
      appOpenShowTime.value = showAds['appOpenShowTime'];
      adaptiveBannerSize.value = showAds['adaptiveBannerSize'];
      showTestAds.value = showAds['showTestAds'];

      androidAdsId.value = (showTestAds.isTrue)
          ? androidTestAds['app_id']
          : (kReleaseMode)
              ? androidLiveAds['app_id']
              : androidTestAds['app_id'];

      appOpenID.value =
          getAppOpen(androidTestAds['appOpen'], androidLiveAds['appOpen']);
      bannerID.value =
          getBanner(androidTestAds['banner'], androidLiveAds['banner']);
      interstitialID.value =
          getInterstitial(androidTestAds['inter'], androidLiveAds['inter']);
      rewardID.value =
          getInterstitial(androidTestAds['reward'], androidLiveAds['reward']);

      const platform = MethodChannel('samples.flutter.dev/firebase');

      try {
        await platform.invokeMethod('setId', {
          "googleAdsId": androidAdsId.value,
        }).then((value) async {
          if (value == "Success") {
            await MobileAds.instance.initialize();
            MobileAds.instance.updateRequestConfiguration(
              RequestConfiguration(
                tagForChildDirectedTreatment:
                    TagForChildDirectedTreatment.unspecified,
                testDeviceIds: kDebugMode ? [] : [],
              ),
            );
            if (banner.isTrue) {
              await GdprDialog.instance
                  .showDialog(isForTest: false, testDeviceId: '')
                  .then((onValue) {
                print('result === $onValue');
              });
            }
            AppLifecycleReactor? appLifecycleReactor;
            AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
            appLifecycleReactor =
                AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
            if (!isNullEmptyOrFalse(appLifecycleReactor)) {
              appLifecycleReactor.listenToAppStateChanges();
            }
          }
        });
      } on PlatformException catch (e) {
        print(e);
      }
    });
  }

  String getAppOpen(androidTestAd, androidLiveAd) {
    return (showTestAds.isTrue)
        ? androidTestAd
        : (kReleaseMode)
            ? androidLiveAd
            : androidTestAd;
  }

  String getBanner(androidTestAd, androidLiveAd) {
    return (showTestAds.isTrue)
        ? androidTestAd
        : (kReleaseMode)
            ? androidLiveAd
            : androidTestAd;
  }

  String getInterstitial(androidTestAd, androidLiveAd) {
    return (showTestAds.isTrue)
        ? androidTestAd
        : (kReleaseMode)
            ? androidLiveAd
            : androidTestAd;
  }

  String getReward(androidTestAd, androidLiveAd) {
    return (showTestAds.isTrue)
        ? androidTestAd
        : (kReleaseMode)
            ? androidLiveAd
            : androidTestAd;
  }
}
