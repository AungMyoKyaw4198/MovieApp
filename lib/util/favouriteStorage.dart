import 'dart:convert';
import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:youTubeApp/model/video.dart';

class FavouriteStorage {
   Future get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
 
  Future get _localFile async {
    final path = await _localPath;
    return File('$path/favoriteVideo.dat');
  }
 
  Future writeFavorites(List favoritesList) async {
    try {
      final file = await _localFile;
 
      // Write the file
      String json =  jsonEncode(favoritesList);
      await file.writeAsString(json, mode: FileMode.write);
      return true;
 
    } catch (e) {
      print('error $e');
    }
 
    return false;
  }
 
  Future readFavorites() async {
    try {
      final file = await _localFile;
 
      // Read the file
      String jsonString = await file.readAsString();
      Iterable jsonMap = jsonDecode(jsonString);
      List favs = jsonMap.map((parsedJson) => Video.fromJson(parsedJson)).toList();
      return favs;
 
    } catch (e) {
      print('error');
    }
 
    return List();
  }
}