class UserData {
  final String pairUID;
  final String displayName;
  final Map<String, dynamic> isJuzDone;

  UserData({
    required this.pairUID,
    required this.displayName,
    required this.isJuzDone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      pairUID: json['pairs'][0] as String,
      displayName: json['name'] as String,
      isJuzDone: json['juz'] as Map<String, dynamic>,
    );
  }
}
