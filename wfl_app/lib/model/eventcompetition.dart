class Eventcompetition {
  String matchId, eventId, competitionId, redcornerId, bluecornerId;

  Eventcompetition({
    this.matchId,
    this.eventId,
    this.competitionId,
    this.redcornerId,
    this.bluecornerId,
  });

  Eventcompetition.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    eventId = json['event_id'];
    competitionId = json['competition_id'];
    redcornerId = json['redcorner'];
    bluecornerId = json['bluecorner'];
  }
}
