class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String viewCount;
  final String duration;
  final String publishAt;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.viewCount,
    this.duration,
    this.publishAt
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      viewCount: snippet['viewCount'],
      duration: snippet['durationMs'],
    );
  }

  factory Video.fromJson(Map<String, dynamic> parsedJson){
    return Video(
        id: parsedJson['id'],
        title: parsedJson['title'],
        thumbnailUrl: parsedJson['thumbnailUrl'],
        channelTitle: parsedJson['channelTitle'],
        viewCount: parsedJson['viewCount'],
        duration: parsedJson['duration'],
        publishAt: parsedJson['publishAt'],
    );
  }

  Map<String,dynamic> toJson() => <String,dynamic>{
    'id':this.id,
    'title':this.title,
    'thumbnailUrl':this.thumbnailUrl,
    'channelTitle':this.channelTitle,
    'viewCount':this.viewCount,
    'duration':this.duration,
    'publishAt':this.publishAt
  };
}