import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testingnew/main.dart';

class BannerAdsShow extends StatefulWidget {
  @override
  BannerAdsShowState createState() => BannerAdsShowState();
}

class BannerAdsShowState extends State<BannerAdsShow> {
  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool isOneTimeLoading = false;

  @override
  void initState() {
    super.initState();
    if (banner.isTrue) {
      _consentManager.gatherConsent((consentGatheringError) {
        if (consentGatheringError != null) {
          debugPrint(
              "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
        }
      });
      _initializeMobileAdsSDK();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return (banner.isTrue)
            ? (_bannerAd != null && _isLoaded)
                ? SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  )
                : SizedBox()
            : SizedBox();
      },
    );
  }

  void _loadAd() async {
    if (!isOneTimeLoading) {
      setState(() {
        isOneTimeLoading = true;
      });
      var canRequestAds = await _consentManager.canRequestAds();
      if (!canRequestAds) {
        return;
      }

      if (!mounted) {
        return;
      }

      // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
      final size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
              MediaQuery.sizeOf(context).width.truncate());

      if (size == null) {
        // Unable to get width of anchored banner.
        return;
      }

      print("Ad Banner Load");
      BannerAd(
        adUnitId: bannerID.toString().trim(),
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
              _isLoaded = true;
            });
            print("Banner Ad loaded.");
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},
        ),
      ).load();
    }
  }

  void _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Load an ad.
      _loadAd();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}

typedef OnConsentGatheringCompleteListener = void Function(FormError? error);

class ConsentManager {
  Future<bool> canRequestAds() async {
    return await ConsentInformation.instance.canRequestAds();
  }

  Future<bool> isPrivacyOptionsRequired() async {
    return await ConsentInformation.instance
            .getPrivacyOptionsRequirementStatus() ==
        PrivacyOptionsRequirementStatus.required;
  }

  void gatherConsent(
      OnConsentGatheringCompleteListener onConsentGatheringCompleteListener) {
    ConsentDebugSettings debugSettings = ConsentDebugSettings();
    ConsentRequestParameters params =
        ConsentRequestParameters(consentDebugSettings: debugSettings);
    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      ConsentForm.loadAndShowConsentFormIfRequired((loadAndShowError) {
        onConsentGatheringCompleteListener(loadAndShowError);
      });
    }, (FormError formError) {
      onConsentGatheringCompleteListener(formError);
    });
  }

  void showPrivacyOptionsForm(
      OnConsentFormDismissedListener onConsentFormDismissedListener) {
    ConsentForm.showPrivacyOptionsForm(onConsentFormDismissedListener);
  }
}
