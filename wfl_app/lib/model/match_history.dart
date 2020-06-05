class MatchH {
  String matchDate,
         matchResult, 
         matchOpponent, 
         matchMethod, 
         matchRound;

  MatchH({
    this.matchDate,
    this.matchResult, 
    this.matchOpponent, 
    this.matchMethod, 
    this.matchRound
  });

  MatchH.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'];
    matchResult = json['match_result'];
    matchOpponent = json['match_opponent'];
    matchMethod = json['match_method'];
    matchRound = json['match_round'];
  }
}

