class Athlete {
  String athletePicture,
      athleteId,
      athleteFirstname,
      athleteLastname,
      athleteNickname,
      athleteDayOfBirth,
      athleteNationality,
      athleteDescription,
      athleteFullName,
      athleteWeightclass;

  Athlete(
      {this.athletePicture,
      this.athleteId,
      this.athleteFirstname,
      this.athleteLastname,
      this.athleteDayOfBirth,
      this.athleteNationality,
      this.athleteDescription,
      this.athleteFullName,
      this.athleteWeightclass});

  Athlete.fromJson(Map<String, dynamic> json) {
    athletePicture = "http://superfighter.nl/" + json['athlete_picture'];
    athleteId = json['athlete_id'];
    athleteFirstname = json['athlete_firstname'];
    athleteLastname = json['athlete_lastname'];
    athleteNickname = json['athlete_nickname'];
    athleteDayOfBirth = json['athlete_day_of_birth'];
    athleteNationality = json['athlete_nationality'];
    athleteDescription = json['athlete_description'];
    athleteFullName = athleteFirstname + " " + athleteLastname;
    athleteWeightclass = json['athlete_weightclass'];
  }
}
