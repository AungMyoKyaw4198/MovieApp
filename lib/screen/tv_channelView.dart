import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/services/ads.dart';

class TvView extends StatefulWidget {
  final String url;
  TvView({this.url});

  @override
  _TvViewState createState() => _TvViewState();
}

class _TvViewState extends State<TvView> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff141a32),
          appBar: mainAppBar(),
          body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height-130,
                child: InAppWebView(
                  initialUrl: widget.url,
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
                    webView.evaluateJavascript(source: "document.getElementsByClassName('bg-skyblue')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container-fluid bg-blue')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container-fluid py-5')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container py-4')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('row text-center')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container-fluid py-4 bg-blue text-light')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('container-fluid bg-black py-5')[0].style.display='none';");
                    webView.evaluateJavascript(source: "document.getElementsByClassName('py-2')[0].style.display='none';");
                  },
                ),
              ),
              AdManager.smallBannerAdWidget(),
            ],
          ),
    );
  }
}
