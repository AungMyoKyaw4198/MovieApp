import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/screen/tv_channelView.dart';
import 'package:youTubeApp/services/ads.dart';
import 'package:youTubeApp/util/keys.dart';


class TvChannel extends StatefulWidget {
  static const String routeName= '/tvchannel';
  TvChannel({Key key}) : super(key: key);

  @override
  _TvChannelState createState() => _TvChannelState();
}

class _TvChannelState extends State<TvChannel> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xff141a32),
       appBar: mainAppBar(),
       drawer: DrawerWidget(context),
       body: SingleChildScrollView(
         child: Column(
                    children: <Widget>[
                      Container(
                   child: ListView.separated(
                   shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                   scrollDirection: Axis.vertical,
                   itemCount: tvChannelsJson.length,
                   separatorBuilder: (BuildContext context, int index){
                    // return (index != 0 && index % 5 == 0) ? AdManager.largeBannerAdWidget(): SizedBox.shrink();
                    return (index != 0 && index % 5 == 0) ? SizedBox.shrink(): SizedBox.shrink();
                  },
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