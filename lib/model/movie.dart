import 'dart:convert';

class Movie{
  int id;
  String title;
  String description;
  String category;
  String status;
  String subtitle;
  String posterUrl;
  List<dynamic> url;

  Movie({this.id,this.title,this.description,this.category,this.status,this.subtitle,this.posterUrl,this.url});

  factory Movie.fromMap(Map<String, dynamic> jsonData){
    return Movie(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      category: jsonData['category'],
      status: jsonData['status'],
      subtitle: jsonData['subtitle'],
      posterUrl: jsonData['posterUrl'],
      url: jsonData['url'],
      );
  }
}
