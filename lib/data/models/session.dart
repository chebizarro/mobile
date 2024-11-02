class Session {
  final String sessionId;
  final DateTime startTime;
  final String privateKey;

  Session({
    required this.sessionId,
    required this.startTime,
    required this.privateKey,
  });

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'startTime': startTime.toIso8601String(),
        'privateKey': privateKey,
      };

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      startTime: DateTime.parse(json['startTime']),
      privateKey: json['privateKey'],
    );
  }
}
