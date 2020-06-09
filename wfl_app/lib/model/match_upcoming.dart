class MatchU {
  String matchEvent,
      matchEventName,
      matchDate,
      matchBlok,
      matchOpponent,
      eventPicture;

  MatchU(
      {this.matchEvent,
      this.matchEventName,
      this.matchDate,
      this.matchBlok,
      this.matchOpponent,
      this.eventPicture});

  MatchU.fromJson(Map<String, dynamic> json) {
    matchEvent = json['match_event'];
    matchEventName = json['match_event_name'];
    matchDate = json['match_date'];
    matchBlok = json['match_blok'];
    matchOpponent = json['match_opponent'];
    eventPicture = "http://superfighter.nl/" + json['match_event_picture'];
  }
}
