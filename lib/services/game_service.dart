import 'dart:math';
import '../models/word_model.dart';
import '../data/words_data.dart';

enum GameMethod {
  draw,
  mime,
  playDough,
  oneWord,
}

class GameService {
  int _totalScore = 0;
  int _wordsCompleted = 0;
  int _wordsPassed = 0;
  final List<WordModel> _usedWords = [];
  final List<WordModel> _availableWords = List.from(WordsData.words);
  WordModel? _currentWord;

  int get totalScore => _totalScore;
  int get wordsCompleted => _wordsCompleted;
  int get wordsPassed => _wordsPassed;
  WordModel? get currentWord => _currentWord;

  // Scoring based on mockup
  int getScoreForMethod(GameMethod method) {
    if (_currentWord == null) return 0;
    
    switch (method) {
      case GameMethod.draw:
        return _currentWord!.drawScore;
      case GameMethod.mime:
        return _currentWord!.mimeScore;
      case GameMethod.playDough:
        return _currentWord!.playDoughScore;
      case GameMethod.oneWord:
        return _currentWord!.oneWordScore;
    }
  }

  void startNewGame() {
    _totalScore = 0;
    _wordsCompleted = 0;
    _wordsPassed = 0;
    _usedWords.clear();
    _availableWords.clear();
    _availableWords.addAll(WordsData.words);
    _currentWord = null;
    getNextWord();
  }

  WordModel? getNextWord() {
    if (_availableWords.isEmpty) {
      // If all words used, reset the pool
      _availableWords.addAll(WordsData.words);
      _usedWords.clear();
    }

    final random = Random();
    final index = random.nextInt(_availableWords.length);
    _currentWord = _availableWords[index];
    _availableWords.removeAt(index);
    _usedWords.add(_currentWord!);
    
    return _currentWord;
  }

  void selectMethod(GameMethod method) {
    _totalScore += getScoreForMethod(method);
    _wordsCompleted++;
    getNextWord();
  }

  void passWord() {
    _wordsPassed++;
    getNextWord();
  }

  void resetGame() {
    startNewGame();
  }
}
