import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/movies_widgets.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/services/ads.dart';

class CategoryMovieScreen extends StatefulWidget {
  final List<Movie> movieList;
  final String title;
  CategoryMovieScreen({this.title,this.movieList});

  @override
  _CategoryMovieScreenState createState() => _CategoryMovieScreenState();
}

class _CategoryMovieScreenState extends State<CategoryMovieScreen> {
  List<Movie>randomMovieList = [];
  @override
  void initState() { 
    super.initState();
    setState(() {
          widget.movieList.shuffle();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141a32),
      appBar: mainAppBar(),
      body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("${widget.title} Movies",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: AdManager.largeBannerAdWidget(),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 3,
                      children: List.generate(widget.movieList.length, (index){
                        return GridMovieWidget(widget.movieList[index],context);
                      }
                    ),
                  ),
                ),
              ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() { 
    print('____________CategoryMovie Dispose');
    super.dispose();
  }
}