class Event {
  String eventId,
         eventCompetition, 
         eventName, 
         eventDescription, 
         eventDate, 
         eventPlace, 
         eventPicture, 
         eventPicture2,
         eventTicketLink,
         eventMaxComp;

  Event({
    this.eventId,
    this.eventCompetition,
    this.eventName,
    this.eventDescription,
    this.eventDate,
    this.eventPlace,
    this.eventPicture,
    this.eventPicture2,
    this.eventTicketLink,
    this.eventMaxComp
  });

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventCompetition = json['competition'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    eventDate = json['event_date'];
    eventPlace = json['event_place'];
    eventPicture = "http://superfighter.nl/" + json['event_picture'];
    eventPicture2 = "http://superfighter.nl/" + json['event_picture2'];
    eventTicketLink = json['event_link'];
    eventMaxComp = json['event_max_comp'];
  }
}

