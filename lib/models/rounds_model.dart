class Rounds {
  List<Round> rounds;
  Rounds({required this.rounds});

  factory Rounds.fromJson(List<dynamic> json) {
    return Rounds(
      rounds: json.map((e) => Round.fromJson(e)).toList(),
    );
  }
}

class Round {
  HostPlayerRound hostPlayer;
  GuestPlayerRound guestPlayer;

  Round({required this.hostPlayer, required this.guestPlayer});

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      hostPlayer: HostPlayerRound.fromJson(json['hostPlayer']),
      guestPlayer: GuestPlayerRound.fromJson(json['guestPlayer']),
    );
  }
}

class HostPlayerRound {
  String word;
  String draw;

  HostPlayerRound({required this.word, required this.draw});

  factory HostPlayerRound.fromJson(Map<String, dynamic> json) {
    return HostPlayerRound(
      word: json.keys.first,
      draw: json.values.first,
    );
  }
}

class GuestPlayerRound {
  String word;
  String draw;

  GuestPlayerRound({required this.word, required this.draw});

  factory GuestPlayerRound.fromJson(Map<String, dynamic> json) {
    return GuestPlayerRound(
      word: json.keys.first,
      draw: json.values.first,
    );
  }
}
