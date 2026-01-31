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
  // Dynamic scores for each round
  final Map<GameMethod, int> _currentScores = {};

  Map<GameMethod, int> get currentScores => Map.unmodifiable(_currentScores);

  int getScoreForMethod(GameMethod method) {
    if (_currentScores.isEmpty) {
      _randomizeScores();
    }
    return _currentScores[method] ?? 0;
  }

  void _randomizeScores() {
    final random = Random();
    
    // Draw always gets maximum points (20)
    _currentScores[GameMethod.draw] = 20;
    
    // Others get random points between 5 and 15
    _currentScores[GameMethod.mime] = 5 + random.nextInt(11); // 5 to 15
    _currentScores[GameMethod.playDough] = 5 + random.nextInt(11); // 5 to 15
    _currentScores[GameMethod.oneWord] = 5 + random.nextInt(11); // 5 to 15
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
    // Randomize scores for the new round
    _randomizeScores();

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
