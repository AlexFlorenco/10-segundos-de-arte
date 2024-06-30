class Responses {
  List<dynamic> hostPlayer;
  List<dynamic> guestPlayer;

  Responses({required this.hostPlayer, required this.guestPlayer});

  factory Responses.fromJson(Map<String, dynamic> json) {
    return Responses(
      hostPlayer: json['hostPlayer'].map((e) => e.toString()).toList(),
      guestPlayer: json['guestPlayer'].map((e) => e.toString()).toList(),
    );
  }
}
