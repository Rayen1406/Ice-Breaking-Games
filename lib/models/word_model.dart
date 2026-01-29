class WordModel {
  final String english;
  final String french;
  final String arabic;

  final int drawScore;
  final int mimeScore;
  final int playDoughScore;
  final int oneWordScore;

  WordModel({
    required this.english,
    required this.french,
    required this.arabic,
    this.drawScore = 10,
    this.mimeScore = 15,
    this.playDoughScore = 20,
    this.oneWordScore = 5,
  });

  String get displayText => '$english - $french - $arabic';
}
