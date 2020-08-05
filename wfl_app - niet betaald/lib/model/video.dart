class Video {
  String videoId,
         videoTitle, 
         videoEvent, 
         videoEventName, 
         videoDescription, 
         videoType,
         videoDateAdded,
         videoLink;

  Video({
    this.videoId,
    this.videoTitle,
    this.videoEvent,
    this.videoEventName,
    this.videoDescription,
    this.videoType,
    this.videoDateAdded,
    this.videoLink
  });

  Video.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoTitle = json['video_title'];
    videoEvent = json['video_event'];
    videoEventName = json['video_event_name'];
    videoDescription = json['video_description'];
    videoType = json['video_type'];
    videoDateAdded = json['video_date_added'];
    videoLink = json['video_link'];
  }
}

