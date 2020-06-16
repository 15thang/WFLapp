class AthleteComp {
  String athleteId,
      athleteFirstname,
      athleteLastname,
      athleteFullName,
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
    athleteWins = json['athlete_wins'];
    athleteLosses = json['athlete_losses'];
    athleteDraws = json['athlete_draws'];
    athleteKO = json['athlete_ko'];
    athleteTKO = json['athlete_tko'];
    totalYellowcards = json['athlete_yellowcards'];
    totalRedcards = json['athlete_redcards'];
    totalPoints = json['athlete_total_points'];
  }
}
