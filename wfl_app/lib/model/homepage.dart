class Homepage {
  String event1Id,
      event1Name,
      event1Picture,
      event1Description,
      event1Date,
      event1Year,
      event1Month,
      event1Day,
      event1Hour,
      event1Minute,
      event1TicketLink,
      event1LiveLink,
      event1Place,
      event1MaxComp,
      event2Id,
      event2Name,
      event2Picture,
      event2Description,
      event2Date,
      event2TicketLink,
      event2Place,
      event2MaxComp,
      athleteId,
      athleteFirstname,
      athleteLastname,
      athleteFullName,
      athleteNickname,
      athletePicture,
      athleteWeightclass,
      athleteGrade,
      athleteWins,
      athleteLosses,
      athleteDraws,
      totalYellowcards,
      totalRedcards,
      count;

  Homepage(
      {this.event1Id,
      this.event1Name,
      this.event1Picture,
      this.event1Description,
      this.event1Date,
      this.event1Year,
      this.event1Month,
      this.event1Day,
      this.event1Hour,
      this.event1Minute,
      this.event1TicketLink,
      this.event1LiveLink,
      this.event1Place,
      this.event1MaxComp,
      this.event2Id,
      this.event2Name,
      this.event2Picture,
      this.event2Description,
      this.event2Date,
      this.event2TicketLink,
      this.event2Place,
      this.event2MaxComp,
      this.athleteId,
      this.athleteFirstname,
      this.athleteLastname,
      this.athleteFullName,
      this.athleteNickname,
      this.athletePicture,
      this.athleteWeightclass,
      this.athleteGrade,
      this.athleteWins,
      this.athleteLosses,
      this.athleteDraws,
      this.totalYellowcards,
      this.totalRedcards,
      this.count});

  Homepage.fromJson(Map<String, dynamic> json) {
    event1Id = json['event1_id'];
    event1Name = json['event1_name'];
    event1Picture = "http://superfighter.nl/" + json['event1_picture'];
    event1Description = json['event1_description'];
    event1Date = json['event1_date'];
    event1Year = json['event1_year'];
    event1Month = json['event1_month'];
    event1Day = json['event1_day'];
    event1Hour = json['event1_hour'];
    event1Minute = json['event1_minute'];
    event1TicketLink = json['event1_ticketlink'];
    event1LiveLink = json['event1_live_link'];
    event1Place = json['event1_place'];
    event1MaxComp = json['event1_max_comp'];

    event2Id = json['event2_id'];
    event2Name = json['event2_name'];
    event2Picture = "http://superfighter.nl/" + json['event2_picture'];
    event2Description = json['event2_description'];
    event2Date = json['event2_date'];
    event2TicketLink = json['event2_ticketlink'];
    event2Place = json['event2_place'];
    event2MaxComp = json['event2_max_comp'];

    athleteId = json['athlete_id'];
    athleteFirstname = json['athlete_firstname'];
    athleteLastname = json['athlete_lastname'];
    athleteNickname = json['athlete_nickname'];
    athletePicture = "http://superfighter.nl/" + json['athlete_picture'];
    athleteFullName = athleteFirstname + " " + athleteLastname;
    athleteWeightclass = json['athlete_weightclass'];
    athleteGrade = json['athlete_grade'];
    athleteWins = json['athlete_wins'];
    athleteLosses = json['athlete_losses'];
    athleteDraws = json['athlete_draws'];
    totalYellowcards = json['total_yellowcards'];
    totalRedcards = json['total_redcards'];

    count = json['count'];
  }
}
