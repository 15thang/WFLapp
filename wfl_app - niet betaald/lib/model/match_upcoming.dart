class MatchU {
  String matchEvent,
      matchEventName,
      matchDate,
      matchBlok,
      matchOpponent,
      eventPicture,
      eventDescription,
      eventPlace,
      eventLink,
      eventMaxComp;

  MatchU(
      {this.matchEvent,
      this.matchEventName,
      this.matchDate,
      this.matchBlok,
      this.matchOpponent,
      this.eventPicture,
      this.eventDescription,
      this.eventPlace,
      this.eventLink,
      this.eventMaxComp});

  MatchU.fromJson(Map<String, dynamic> json) {
    matchEvent = json['match_event'];
    matchEventName = json['match_event_name'];
    matchDate = json['match_date'];
    matchBlok = json['match_blok'];
    matchOpponent = json['match_opponent'];
    eventPicture = "http://superfighter.nl/" + json['match_event_picture'];
    eventDescription = json['match_description'];
    eventPlace = json['match_event_place'];
    eventLink = json['match_event_link'];
    eventMaxComp = json['match_event_max_comp'];
  }
}
