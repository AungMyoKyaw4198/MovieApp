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

class DrawerWidget extends StatelessWidget {
  final BuildContext context;
  const DrawerWidget(this.context);

  @override
  Widget build(BuildContext context) {
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
                DrawerListTile(icon: Icons.movie,name: 'Foreign Movies', context: context,routeName: Routes.movies),
                DrawerListTile(icon: Icons.local_movies,name: 'MM Movies', context: context,routeName: Routes.movie),
                DrawerListTile(icon: Icons.person,name: 'Favourite Movies',context: context, routeName: Routes.favVideo),
                Divider(color: Colors.grey,),
                DrawerListTile(icon: Icons.live_tv,name: 'TV Channels', context: context, routeName: Routes.channel),
                Divider(color: Colors.grey,),
                // DrawerListTile(icon: Icons.radio,name: 'Radio Channels', context: context, routeName: Routes.radio),
                // Divider(color: Colors.grey,),
                ListTile(
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text('version 1.2.0', style: TextStyle(color: Colors.white),))
                )
                ]
              ),
          ),
            );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final BuildContext context;
  final String routeName;
  const DrawerListTile({this.icon,this.name,this.context,this.routeName});

  @override
  Widget build(BuildContext context) {
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
}
