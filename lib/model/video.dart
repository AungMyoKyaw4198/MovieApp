class Video {
  String id;
  String title;
  String thumbnailUrl; //poster url
  String channelTitle; // category
  String viewCount; //description
  String duration; // status and subtitle
  String publishAt; // url

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