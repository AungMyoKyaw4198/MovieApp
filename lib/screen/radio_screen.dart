import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youTubeApp/components/appbar_widget.dart';

class RadioScreen extends StatefulWidget {
  static const String routeName= '/radio';
  RadioScreen({Key key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  InAppWebViewController webView;
  BannerAd myBannerAd;
  
  BannerAd biuldBannerAd(){
    return BannerAd(
      adUnitId: 'ca-app-pub-8107971978330636/6213831627',
      size: AdSize.banner,
      listener: (MobileAdEvent event){
        if (event == MobileAdEvent.loaded){
          myBannerAd..show();
        }
        print("BannerAd $event");
      },
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-8107971978330636~8056578093');
    // myBannerAd = biuldBannerAd()..load();
    super.initState();
  }

  @override
  void dispose() { 
    // myBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Color(0xff141a32),
          appBar: mainAppBar(),
          drawer: drawerWidget(context),
          body: Container(
         child: InAppWebView(
              initialUrl: 'https://www.myanmartvchannels.com/radio.html',
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                  mediaPlaybackRequiresUserGesture : false,
                  preferredContentMode : UserPreferredContentMode.MOBILE,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {},
              onLoadStop: (InAppWebViewController controller, String url) {},
            ),
      ),
    );
  }
}