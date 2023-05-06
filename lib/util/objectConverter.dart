import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/model/video.dart';

convertMovieToVideo(Movie movie){
  Video newVideo = new Video();
  newVideo.id = movie.id.toString();
  newVideo.title = movie.title;
  newVideo.channelTitle = movie.category;
  newVideo.duration = movie.status +','+ movie.subtitle;
  newVideo.publishAt = movie.url.join(',');
  newVideo.viewCount = movie.description;
  newVideo.thumbnailUrl = movie.posterUrl;
  return newVideo;
}

convertVideoToMovie(Video video){
  Movie newMovie = new Movie();
  newMovie.id = int.parse(video.id);
  newMovie.title= video.title;
  newMovie.description= video.viewCount;
  newMovie.category = video.channelTitle;
  newMovie.status = video.duration.substring(0, video.duration.indexOf(','));
  newMovie.subtitle = video.duration.split(",").last;
  newMovie.posterUrl = video.thumbnailUrl;
  newMovie.url = video.publishAt.split(",").toList();
  return newMovie;
}