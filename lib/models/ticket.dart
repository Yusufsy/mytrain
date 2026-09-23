class Ticket {
  final int id;
  final String trainId;
  final int coachId;
  final String passengerName;

  Ticket({
    required this.id,
    required this.trainId,
    required this.coachId,
    required this.passengerName,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      trainId: json['trainId'],
      coachId: json['coachId'],
      passengerName: json['passengerName'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainId': trainId,
      'coachId': coachId,
      'passengerName': passengerName,
    };
  }
}