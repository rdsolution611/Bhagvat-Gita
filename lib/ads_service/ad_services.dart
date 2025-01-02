import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testingnew/main.dart';

import 'argument_const.dart';

class AdService {
  InterstitialAd? interstitialAds;
  RewardedAd? rewardAd;

  /// Interstitial and Reward  Ads Load
  loadInterstitialAd() {
    if (interstitial.isTrue) {
      print("Load Interstitial Ad");
      InterstitialAd.load(
        adUnitId: interstitialID.toString().trim(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => interstitialAds = ad,
          onAdFailedToLoad: (error) {
            interstitialAds!.dispose();
            print('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  loadRewardAd() {
    if (reward.isTrue) {
      RewardedAd.load(
        adUnitId: rewardID.toString().trim(),
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            rewardAd = ad;
            print("Load Reward Ad");
          },
          onAdFailedToLoad: (error) {
            rewardAd!.dispose();
            print('RewardedAd failed to load: $error');
          },
        ),
      );
    }
  }

  /// Interstitial and Reward  Ads Show
  showInterstitialAd({VoidCallback? onDismissed}) {
    print("Show Interstitial Ad");
    interstitialAds?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        box.write(ArgumentConstant.isInterstitialStartTime,
            DateTime.now().millisecondsSinceEpoch.toString());
        interstitialAds?.dispose();
        onDismissed?.call();
      },
      onAdShowedFullScreenContent: (ad) =>
          print('Interstitial ad showed in fullscreen.'),
      onAdFailedToShowFullScreenContent: (ad, error) =>
          print('Interstitial ad failed to show fullscreen: $error'),
    );
    interstitialAds?.show().then((value) =>
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []));
  }

  showRewardAd({VoidCallback? onDismissed}) {
    print("Show Reward Ad");
    rewardAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        box.write(ArgumentConstant.isRewardStartTime,
            DateTime.now().millisecondsSinceEpoch.toString());
        rewardAd?.dispose();
        onDismissed?.call();
      },
      onAdShowedFullScreenContent: (ad) =>
          print('Reward ad showed in fullscreen.'),
      onAdFailedToShowFullScreenContent: (ad, error) =>
          print('Reward ad failed to show fullscreen: $error'),
    );
    rewardAd?.show(onUserEarnedReward: (ad, reward) {}).then((value) =>
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []));
  }

  // Get Difference Time For Interstitial, Reward, AppOpen
  bool getDifferenceInterstitialTime() {
    if (interstitial.isTrue) {
      if (box.read(ArgumentConstant.isInterstitialStartTime) != null) {
        String startTime =
            box.read(ArgumentConstant.isInterstitialStartTime).toString();
        String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
        int difference = int.parse(currentTime) - int.parse(startTime);
        print("Difference := $difference");
        print("StartTime := $startTime");
        print("currentDate := $currentTime");
        int differenceTime = difference ~/ 1000;
        if (differenceTime > interShowTime.value) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getDifferenceRewardTime() {
    if (reward.isTrue) {
      if (box.read(ArgumentConstant.isRewardStartTime) != null) {
        String startTime =
            box.read(ArgumentConstant.isRewardStartTime).toString();
        String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
        int difference = int.parse(currentTime) - int.parse(startTime);
        print("Difference := $difference");
        print("StartTime := $startTime");
        print("currentDate := $currentTime");
        int differenceTime = difference ~/ 1000;
        if (differenceTime > rewardShowTime.value) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getDifferenceAppOpenTime() {
    if (appOpen.isTrue) {
      if (box.read(ArgumentConstant.isAppOpenStartTime) != null) {
        String startTime =
            box.read(ArgumentConstant.isAppOpenStartTime).toString();
        String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
        int difference = int.parse(currentTime) - int.parse(startTime);
        print("Difference := $difference");
        print("StartTime := $startTime");
        print("currentDate := $currentTime");
        int differenceTime = difference ~/ 1000;
        if (differenceTime > appOpenShowTime.value) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
