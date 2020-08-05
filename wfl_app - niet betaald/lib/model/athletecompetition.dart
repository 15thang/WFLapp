class AthleteComp {
  String athleteId,
      athleteFirstname,
      athleteLastname,
      athleteFullName,
      athleteMatches,
      athleteMatchesDone,
      athleteWins,
      athleteLosses,
      athleteDraws,
      athleteKO,
      athleteTKO,
      totalYellowcards,
      totalRedcards,
      totalPoints;

  AthleteComp(
      {this.athleteId,
      this.athleteFirstname,
      this.athleteLastname,
      this.athleteFullName,
      this.athleteMatches,
      this.athleteMatchesDone,
      this.athleteWins,
      this.athleteLosses,
      this.athleteDraws,
      this.athleteKO,
      this.athleteTKO,
      this.totalYellowcards,
      this.totalRedcards,
      this.totalPoints});

  AthleteComp.fromJson(Map<String, dynamic> json) {
    athleteId = json['athlete_id'];
    athleteFirstname = json['athlete_firstname'];
    athleteLastname = json['athlete_lastname'];
    athleteFullName = athleteFirstname + " " + athleteLastname;
    athleteMatches = json['athlete_matches'].toString();
    athleteMatchesDone = json['athlete_matches_done'].toString();
    athleteWins = json['athlete_wins'].toString();
    athleteLosses = json['athlete_losses'].toString();
    athleteDraws = json['athlete_draws'].toString();
    athleteKO = json['athlete_ko'].toString();
    athleteTKO = json['athlete_tko'].toString();
    totalYellowcards = json['athlete_yellowcards'].toString();
    totalRedcards = json['athlete_redcards'].toString();
    totalPoints = json['athlete_total_points'].toString();
  }
}
