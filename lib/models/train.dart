class Train {
  final String id;
  final String name;
  final String departure;
  final String arrival;
  final List<Coach> coaches;

  Train({
    required this.id,
    required this.name,
    required this.departure,
    required this.arrival,
    required this.coaches,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      id: json['id'],
      name: json['name'],
      departure: json['departure'],
      arrival: json['arrival'],
      coaches: (json['coaches'] as List)
          .map((coachJson) => Coach.fromJson(coachJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departure': departure,
      'arrival': arrival,
      'coaches': coaches.map((coach) => coach.toJson()).toList(),
    };
  }
}

enum CoachType {
  executive,
  vip,
  regular,
} 

class Coach {
  final int id;
  final CoachType type;

  Coach({
    required this.id,
    required this.type,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      type: CoachType.values.firstWhere((e) => e.toString() == 'CoachType.${json['type']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
    };
  }
}