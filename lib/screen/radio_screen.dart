import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/services/ads.dart';

class RadioScreen extends StatefulWidget {
  static const String routeName= '/radio';
  RadioScreen({Key key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  InAppWebViewController webView;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Color(0xff141a32),
          appBar: mainAppBar(),
          drawer: drawerWidget(context),
          body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height-130,
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
                  onLoadStop: (InAppWebViewController controller, String url) {
                    webView.evaluateJavascript(source: "document.getElementsByClassName('navbar navbar-expand-lg navbar-dark fixed-top bg-primary')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('col-12 mb-5')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('col-lg-4 order-lg-1')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('col-12 mt-2 mb-4')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('page-footer bg-dark font-small blue mt-4 pt-4')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('plugin chrome webkit win x1 Locale_en_GB')[0].style.display='none';");
                    
                  },
                ),
              ),
              AdManager.smallBannerAdWidget(),
            ],
          ),
    );
  }
}