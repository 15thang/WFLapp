class Competitions {
  String competitionName,
  competitionId;

  Competitions({
    this.competitionName,
    this.competitionId
  });

  Competitions.fromJson(Map<String, dynamic> json) {
    competitionName = json['competition_name'];
    competitionId = json['competition_id'];
  }
}

