import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youTubeApp/components/appbar_widget.dart';

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
          body: Container(
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
              onLoadStop: (InAppWebViewController controller, String url) {},
            ),
      ),
    );
  }
}
