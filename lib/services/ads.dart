import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

class AdManager {
  BannerAd myBannerAd;

  static String appId() {
    return 'ca-app-pub-8107971978330636~8056578093';
  }

  static String bannerAdUnitId() {
    return 'ca-app-pub-8107971978330636/6213831627';
  }

   static String fullScreenAdUnitId() {
    return 'ca-app-pub-8107971978330636/7638467629';
  }

  static Future<void> loadFullScreenAd(AdmobInterstitial interstitialAd) async {
    if (await interstitialAd.isLoaded) {
           interstitialAd.show();
        } else {
          print('not okay');
        }     
  }

  static initFullScreenAd(AdmobInterstitial interstitialAd){
    return AdmobInterstitial(
      adUnitId: fullScreenAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
          handleEvent(event, args, 'Interstitial');
      },
    );
  }

  static void handleEvent(
    AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }

  static Widget largeBannerAdWidget(){
  return AdmobBanner(
            adUnitId: bannerAdUnitId(),
            adSize: AdmobBannerSize.LARGE_BANNER,
          );
    } 
  
  static Widget smallBannerAdWidget(){
  return AdmobBanner(
            adUnitId: bannerAdUnitId(),
            adSize: AdmobBannerSize.BANNER,
          );
    } 

}

