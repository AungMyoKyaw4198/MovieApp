import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/movies_widgets.dart';
import 'package:youTubeApp/model/category.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/screen/movie/category_movie_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  static const String routeName= '/movies';
  AllMoviesScreen();

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  List<Category> categoryList = new List();
  List<Movie> allMovieList = new List();

  getMoviesData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/kyiyaaung.json");
    dynamic jsonResult = json.decode(data);
    jsonResult.forEach(
      (value){
        Movie newMovie = new Movie();
        newMovie = Movie.fromMap(value);
        setState(
          (){
            allMovieList.add(newMovie);
          }
        );
      }
    );
  }

  getCategoriesData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/categories.json");
    dynamic jsonResult = json.decode(data);
    jsonResult.forEach(
      (value){
        Category cat = new Category();
        cat = Category.fromMap(value);
        setState(
          (){
            categoryList.add(cat);
          }
        );
      }
    );
  }

  @override
  void initState() { 
    super.initState();
    getCategoriesData();
    getMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141a32),
      appBar: mainAppBar(),
      drawer: drawerWidget(context),
      body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                
            // Show movie categories
                Container(
                height: 70,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: movieCategories(categoryList[index].imageUrl,categoryList[index].name,allMovieList,context));
                }),
              ),

              // Show Recommended Movies
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text('Recommended Movies',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),)
                  ),
                Container(
                height: 210,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: recommendMovie(allMovieList[index],context));
                }),
              ),

              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text('All Movies',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffecba1a),
                          ),
                          child: OutlineButton(
                            color: Colors.yellow[700],
                            child: Text("See All"),
                            onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> CategoryMovieScreen(title: "All",movieList: allMovieList,)),);
                              },
                          ),
                        )
                    ],)
                  ),

              // Show videos container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 3,
                  children: List.generate(allMovieList.length, (index){
                    return gridMovie(allMovieList[index],context);
                  }
                  ),),
              ),

            ],
            ),
          ),
    );
  }
}