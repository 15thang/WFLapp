class MatchU {
  String matchEvent,
         matchDate,
         matchBlok,
         matchOpponent;

  MatchU({
    this.matchEvent,
    this.matchDate,
    this.matchBlok,
    this.matchOpponent
  });

  MatchU.fromJson(Map<String, dynamic> json) {
    matchEvent = json['match_event'];
    matchDate = json['match_date'];
    matchBlok = json['match_blok'];
    matchOpponent = json['match_opponent'];
  }
}

