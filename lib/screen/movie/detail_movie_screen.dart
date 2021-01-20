import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/movies_widgets.dart';
import 'package:youTubeApp/model/movie.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;
  DetailMovieScreen({this.movie});

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool hasMultiParts = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
       backgroundColor: Color(0xff141a32),
       appBar: AppBar(backgroundColor: Colors.transparent,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff141a32),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 100,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(widget.movie.category,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red[300],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: 100,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(widget.movie.subtitle,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),),
                      ),
                      ]
                  ),
                
            ),
       body: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Container(
           padding: EdgeInsets.only(bottom: 14),
           margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
                 child: CachedNetworkImage(imageUrl:widget.movie.posterUrl,height: 400,fit: BoxFit.fill,),
               ),
               Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.movie.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                ),
                
                 SizedBox(height: 5,),
                 hasMultiParts? Container(
                    height: 70,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.movie.url.length,
                      itemBuilder: (BuildContext context, int index){
                        return Center(
                          child: watchButton(context, 'Link ${index+1}',widget.movie.url[index].toString() ));
                    }),
                  ): watchButton(context, 'Watch', widget.movie.url[0].toString()),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                        alignment: Alignment.centerLeft,
                        child: Text('Review',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                      ),
                      IconButton(icon: Icon(Icons.favorite, color: Colors.red,), onPressed: (){}),
                  ] 
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    widget.movie.description,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
                  ),
                )
              ],
          ),
          
        ),
      )
    );
  }
}