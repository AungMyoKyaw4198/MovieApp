import 'package:youTubeApp/util/routes.dart';
import 'package:flutter/material.dart';

Widget mainAppBar(){
  return AppBar(
        centerTitle: true,
        elevation: 0, 
        backgroundColor: Colors.transparent,
        title: Image.asset('assets/logoapp.png', fit: BoxFit.contain,height: 60,)
      );
}

Widget drawerWidget(context){
  return Drawer(
          child: Container(
            color: Color(0xff1e2747),
                      child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                   DrawerHeader(
                     margin: EdgeInsets.symmetric(vertical:0),
                  child: Text(''),
                  decoration: BoxDecoration(
                    color: Color(0xff1e2747),
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                        fit: BoxFit.fitHeight)
                      ),
                  ),
                Divider(color: Colors.grey,),
                drawerListTile(icon: Icons.movie,name: 'Foreign Movies', context: context,routeName: Routes.movies),
                drawerListTile(icon: Icons.local_movies,name: 'MM Movies', context: context,routeName: Routes.movie),
                drawerListTile(icon: Icons.person,name: 'Favourite Movies',context: context, routeName: Routes.favVideo),
                Divider(color: Colors.grey,),
                drawerListTile(icon: Icons.live_tv,name: 'TV Channels', context: context, routeName: Routes.channel),
                Divider(color: Colors.grey,),
                drawerListTile(icon: Icons.radio,name: 'Radio Channels', context: context, routeName: Routes.radio),
                Divider(color: Colors.grey,),
                ListTile(
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text('version 1.1.0', style: TextStyle(color: Colors.white),))
                )
                ]
              ),
          ),
            );
}

Widget drawerListTile({IconData icon, String name,context,String routeName}){
  return InkWell(
    onTap: (){
       Navigator.pushReplacementNamed(context, routeName);
    },
    child:Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(left: 10),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 30,color: Colors.white,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(name , style: TextStyle(
                  color: Colors.white,
                ),)),
            ],
            ),
            Icon(Icons.arrow_right, color: Colors.white,),
        ],),
    )
  );
}