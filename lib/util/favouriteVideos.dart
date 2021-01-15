import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/util/favouriteStorage.dart';

class FavoriteVideos{
  FavouriteStorage storage = FavouriteStorage();
  List favorites = [];
 
  Future readAllFavorites() async {
    favorites = await storage.readFavorites();
    return favorites;
  }
 
  Future addFavorite(Video video) async {
    favorites = await readAllFavorites();
    if (!favorites.any((p) => p.id == video.id)) {
      favorites.add(video);
      await storage.writeFavorites(favorites);
    }
  }
 
  Future removeFavorite(Video video) async {
    favorites = await readAllFavorites();
    favorites.removeWhere((p) => p.id == video.id);
 
    await storage.writeFavorites(favorites);
  }
 
  bool isFavorite(Video video) {
    return favorites.any((p) => p.id == video.id);
  }
}