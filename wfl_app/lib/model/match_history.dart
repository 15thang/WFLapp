class MatchH {
  String matchDate,
         matchPoints,
         matchResult, 
         matchOpponent, 
         matchMethod;

  MatchH({
    this.matchDate,
    this.matchPoints,
    this.matchResult, 
    this.matchOpponent, 
    this.matchMethod, 
  });

  MatchH.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'];
    matchPoints = json['match_points'];
    matchResult = json['match_result'];
    matchOpponent = json['match_opponent'];
    matchMethod = json['match_method'];
  }
}

