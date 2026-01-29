class WordModel {
  final String english;
  final String french;
  final String arabic;

  WordModel({
    required this.english,
    required this.french,
    required this.arabic,
  });

  String get displayText => '$english - $french - $arabic';
}
