class Corners {
  String redcornerPicture,
      redcornerId,
      redcornerFirstname,
      redcornerLastname,
      redcornerNickname,
      redcornerDayOfBirth,
      redcornerNationality,
      redcornerDescription,
      redcornerFullName,
      redcornerWeightclass,
      redcornerGrade,
      redcornerComp,
      bluecornerPicture,
      bluecornerId,
      bluecornerFirstname,
      bluecornerLastname,
      bluecornerNickname,
      bluecornerDayOfBirth,
      bluecornerNationality,
      bluecornerDescription,
      bluecornerFullName,
      bluecornerWeightclass,
      bluecornerGrade,
      bluecornerCompName,
      bluecornerCompId;

  Corners(
      {this.redcornerPicture,
      this.redcornerId,
      this.redcornerFirstname,
      this.redcornerLastname,
      this.redcornerDayOfBirth,
      this.redcornerNationality,
      this.redcornerDescription,
      this.redcornerFullName,
      this.redcornerWeightclass,
      this.redcornerGrade,
      this.redcornerComp,
      this.bluecornerPicture,
      this.bluecornerId,
      this.bluecornerFirstname,
      this.bluecornerLastname,
      this.bluecornerDayOfBirth,
      this.bluecornerNationality,
      this.bluecornerDescription,
      this.bluecornerFullName,
      this.bluecornerWeightclass,
      this.bluecornerGrade,
      this.bluecornerCompName,
      this.bluecornerCompId});

  Corners.fromJson(Map<String, dynamic> json) {
    redcornerPicture = "http://superfighter.nl/" + json['redcorner_picture'];
    redcornerId = json['redcorner_id'];
    redcornerFirstname = json['redcorner_firstname'];
    redcornerLastname = json['redcorner_lastname'];
    redcornerNickname = json['redcorner_nickname'];
    redcornerDayOfBirth = json['redcorner_day_of_birth'];
    redcornerNationality = json['redcorner_nationality'];
    redcornerDescription = json['redcorner_description'];
    redcornerFullName = redcornerFirstname + " " + redcornerLastname;
    redcornerWeightclass = json['redcorner_weightclass'];
    redcornerGrade = json['redcorner_grade'];
    redcornerComp = json['redcorner_comp'];
    bluecornerPicture = "http://superfighter.nl/" + json['bluecorner_picture'];
    bluecornerId = json['bluecorner_id'];
    bluecornerFirstname = json['bluecorner_firstname'];
    bluecornerLastname = json['bluecorner_lastname'];
    bluecornerNickname = json['bluecorner_nickname'];
    bluecornerDayOfBirth = json['bluecorner_day_of_birth'];
    bluecornerNationality = json['bluecorner_nationality'];
    bluecornerDescription = json['bluecorner_description'];
    bluecornerFullName = bluecornerFirstname + " " + bluecornerLastname;
    bluecornerWeightclass = json['bluecorner_weightclass'];
    bluecornerGrade = json['bluecorner_grade'];
    bluecornerCompName = json['bluecorner_comp_name'];
    bluecornerCompId = json['bluecorner_comp_id'];
  }
}
