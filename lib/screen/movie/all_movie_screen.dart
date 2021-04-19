import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/movies_widgets.dart';
import 'package:youTubeApp/model/category.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/screen/movie/category_movie_screen.dart';
import 'package:http/http.dart' as http;
import 'package:youTubeApp/services/ads.dart';
import 'package:youTubeApp/util/keys.dart';

class AllMoviesScreen extends StatefulWidget {
  static const String routeName= '/movies';
  AllMoviesScreen();

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  bool isLoadingCategory = true;
  bool isLoadingMovie = true;
  bool isLoading = true;
  bool hasError = false;
  List<Category> categoryList = [];
  List<Movie> allMovieList = [];
  List<Movie> recomdMovieList = [];
  List<Movie> newMovieList = [];

  getMoviesData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await http.get('https://aungmyokyaw4198.github.io/KyiyaaungData/kyiyaaung.json').then(
        (value){
          dynamic jsonData = jsonDecode(value.body);
          jsonData.forEach(
          (value){
            Movie newMovie = new Movie();
            newMovie = Movie.fromMap(value);
            setState(
              (){
                allMovieList.add(newMovie);
                moviesCache.add(newMovie);
                if(newMovie.status == 'main'){
                  recomdMovieList.add(newMovie);
                  // recomdMovieListCache.add(newMovie);
                }
                }
              );
            }
          );
        }
      ).catchError((error){
        setState(() {
              hasError = true;
            });
        print(error);
      });

      // Set loading
      setState(() {
        isLoadingMovie = false;
        hasError = false;
        newMovieList = new List.from(allMovieList.reversed);
        newMovieListCache = newMovieList;
        recomdMovieList.shuffle();
        recomdMovieListCache = recomdMovieList;
      });
    } else{
      setState(() {
        hasError = true;
      });
    }
  }

  getCategoriesData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await http.get('https://aungmyokyaw4198.github.io/KyiyaaungData/categories.json').then(
        (value){
          dynamic jsonData = jsonDecode(value.body);
          jsonData.forEach(
            (value){
              Category cat = new Category();
              cat = Category.fromMap(value);
              setState(
                (){
                  categoryList.add(cat);
                  categoryCache.add(cat);
                }
              );
            }
          );
        }
      ).catchError((error){
        setState(() {
              hasError = true;
            });
        print(error);
      });

      // Set loading
      setState(() {
        isLoadingCategory = false;
        hasError = false;
      });
    } else{
      setState(() {
        hasError = true;
      });
    }
  }

  getAdUnitIds() async {
    await Firebase.initializeApp();
    if(appUnitId == ''){
      await FirebaseFirestore.instance.collection('AdUnitIDs').doc('doSzg6aET525FH6V3dn6').get().then(
        (doc){
        appUnitId = doc.data()['appId'].toString();
        bannerAdId = doc.data()['bannerAdUnitId'].toString();
        fullScreenAdId = doc.data()['fullScreenAdUnitId'].toString();
        }
      );
    }
  }

  @override
  void initState() { 
    super.initState();
    getAdUnitIds();

    if(moviesCache.length == 0){
      getCategoriesData();
      getMoviesData();
    } else { 
      setState(() {
        allMovieList = moviesCache;
        categoryList = categoryCache;
        recomdMovieList = recomdMovieListCache;
        newMovieList = newMovieListCache;
        isLoadingMovie = false;
        isLoadingCategory = false;
        hasError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141a32),
      appBar: mainAppBar(),
      drawer: drawerWidget(context),
      body: hasError ? 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/error.png',
                     colorBlendMode: BlendMode.hardLight,
                  width: 300.0,
                  height: 200,
                  fit: BoxFit.cover,
                ),
            ),
            SizedBox(height: 20,),
              Text('Failed to load videos. Please try again!',
                   style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffecba1a),
                  ),
                  // ignore: deprecated_member_use
                  child: OutlineButton(
                    color: Colors.yellow[700],
                    child: Text("Tap to Retry"),
                    onPressed: (){
                      getCategoriesData();
                      getMoviesData();
                    },
                ),
              ),
            ],)
          ):
      
        isLoadingMovie ? Center( child: CircularProgressIndicator(),) 
          :SingleChildScrollView(
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
                  child: Text('Recommended Movies',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),)
                  ),
                Container(
                height: 210,
                margin: EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: recomdMovieList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: recommendMovie(recomdMovieList[index],context));
                }),
              ),

              // Show New Movies
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text('New Arrivals',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),)
                  ),
                Container(
                height: 210,
                margin: EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: recommendMovie(newMovieList[index],context));
                }),
              ),

              Align(
                alignment: Alignment.center,
                child: AdManager.largeBannerAdWidget(),
              ),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text('All Movies',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffecba1a),
                          ),
                          // ignore: deprecated_member_use
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
              Align(
                child: AdManager.smallBannerAdWidget(),
              ),
            ],
            ),
          ),
    );
  }

  @override
    void dispose() {
      print('__________________________________Dispose allMovies Screen');
      super.dispose();
    }

}