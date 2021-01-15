import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/screen/tv_channelView.dart';
import 'package:youTubeApp/util/keys.dart';


class TvChannel extends StatefulWidget {
  static const String routeName= '/tvchannel';
  TvChannel({Key key}) : super(key: key);

  @override
  _TvChannelState createState() => _TvChannelState();
}

class _TvChannelState extends State<TvChannel> {
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
       body: SingleChildScrollView(
         child: Column(
                    children: <Widget>[
                      Container(
                   child: ListView.builder(
                   shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                   scrollDirection: Axis.vertical,
                   itemCount: tvChannelsJson.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Container(
                       padding: EdgeInsets.all(10),
                       margin: EdgeInsets.only(top: 5),
                       child: GestureDetector(
                         onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> TvView(url:tvChannelsJson[index]['url'])),);
                         },
                        child: Container(
                           decoration: BoxDecoration(
                                    color: Color(0xff1e2747),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.symmetric(horizontal:10, vertical: 10),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Container(
                                child: CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage: AssetImage(tvChannelsJson[index]['image']),
                                  ),
                               ),
                                Container(
                                  child: Text(tvChannelsJson[index]['name'],
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                         ),),
                                ),
                                Icon(Icons.arrow_right, color: Colors.white,),
                             ],),
                        ),
                       )
                     );
                 },
                 ),
           ),
          ]
         )
       ),
       );
  }
}