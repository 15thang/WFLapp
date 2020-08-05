class Search {
  String type,
      noteTitle,
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
      eventId,
      eventCompetition,
      eventName,
      eventDescription,
      eventDate,
      eventYear,
      eventMonth,
      eventDay,
      eventPlace,
      eventPicture,
      eventPicture2,
      eventTicketLink,
      eventMaxComp,
      videoId,
      videoTitle,
      videoEvent,
      videoEventName,
      videoDescription,
      videoType,
      videoDateAdded,
      videoLink;

  Search({
      this.noteTitle,
      this.type,
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
      this.eventId,
      this.eventCompetition,
      this.eventName,
      this.eventDescription,
      this.eventDate,
      this.eventYear,
      this.eventMonth,
      this.eventDay,
      this.eventPlace,
      this.eventPicture,
      this.eventPicture2,
      this.eventTicketLink,
      this.eventMaxComp,
      this.videoId,
      this.videoTitle,
      this.videoEvent,
      this.videoEventName,
      this.videoDescription,
      this.videoType,
      this.videoDateAdded,
      this.videoLink
    });

  Search.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    noteTitle = json['note_title'];

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

    eventId = json['event_id'];
    eventCompetition = json['competition'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    eventDate = json['event_date'];
    eventYear = json['event_year'];
    eventMonth = json['event_month'];
    eventDay = json['eventDay'];
    eventPlace = json['event_place'];
    eventPicture = "http://superfighter.nl/" + json['event_picture'];
    eventPicture2 = "http://superfighter.nl/" + json['event_picture2'];
    eventTicketLink = json['event_link'];
    eventMaxComp = json['event_max_comp'];

    videoId = json['video_id'];
    videoTitle = json['video_title'];
    videoEvent = json['video_event'];
    videoEventName = json['video_event_name'];
    videoDescription = json['video_description'];
    videoType = json['video_type'];
    videoDateAdded = json['video_date_added'];
    videoLink = json['video_link'];
  }
}
