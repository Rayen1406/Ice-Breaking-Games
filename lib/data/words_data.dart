import '../models/word_model.dart';

class WordsData {
  static List<int> _shuffledScores() {
    final scores = [5, 10, 15, 20];
    scores.shuffle();
    return scores;
  }

  static WordModel _createWord(String english, String french, String arabic) {
    final scores = _shuffledScores();
    return WordModel(
      english: english,
      french: french,
      arabic: arabic,
      drawScore: scores[0],
      mimeScore: scores[1],
      playDoughScore: scores[2],
      oneWordScore: scores[3],
    );
  }

  static final List<WordModel> words = [
    // Animals
    _createWord('dog', 'chien', 'كلب'),
    _createWord('cat', 'chat', 'قطة'),
    _createWord('bird', 'oiseau', 'طائر'),
    _createWord('fish', 'poisson', 'سمكة'),
    _createWord('horse', 'cheval', 'حصان'),
    _createWord('cow', 'vache', 'بقرة'),
    _createWord('sheep', 'mouton', 'خروف'),
    _createWord('rabbit', 'lapin', 'أرنب'),
    _createWord('mouse', 'souris', 'فأر'),
    _createWord('lion', 'lion', 'أسد'),
    
    // Nature
    _createWord('tree', 'arbre', 'شجرة'),
    _createWord('flower', 'fleur', 'زهرة'),
    _createWord('sun', 'soleil', 'شمس'),
    _createWord('moon', 'lune', 'قمر'),
    _createWord('star', 'étoile', 'نجمة'),
    _createWord('water', 'eau', 'ماء'),
    _createWord('rain', 'pluie', 'مطر'),
    _createWord('snow', 'neige', 'ثلج'),
    _createWord('wind', 'vent', 'رياح'),
    _createWord('fire', 'feu', 'نار'),
    
    // Home & Objects
    _createWord('house', 'maison', 'منزل'),
    _createWord('door', 'porte', 'باب'),
    _createWord('window', 'fenêtre', 'نافذة'),
    _createWord('chair', 'chaise', 'كرسي'),
    _createWord('table', 'table', 'طاولة'),
    _createWord('bed', 'lit', 'سرير'),
    _createWord('lamp', 'lampe', 'مصباح'),
    _createWord('book', 'livre', 'كتاب'),
    _createWord('pen', 'stylo', 'قلم'),
    _createWord('phone', 'téléphone', 'هاتف'),
    
    // Transportation
    _createWord('car', 'voiture', 'سيارة'),
    _createWord('bus', 'bus', 'حافلة'),
    _createWord('train', 'train', 'قطار'),
    _createWord('plane', 'avion', 'طائرة'),
    _createWord('boat', 'bateau', 'قارب'),
    _createWord('bike', 'vélo', 'دراجة'),
    
    // Clothing
    _createWord('shirt', 'chemise', 'قميص'),
    _createWord('pants', 'pantalon', 'بنطلون'),
    _createWord('dress', 'robe', 'فستان'),
    _createWord('shoe', 'chaussure', 'حذاء'),
    _createWord('hat', 'chapeau', 'قبعة'),
    _createWord('coat', 'manteau', 'معطف'),
    
    // Food - Fruits
    _createWord('apple', 'pomme', 'تفاحة'),
    _createWord('banana', 'banane', 'موز'),
    _createWord('orange', 'orange', 'برتقالة'),
    _createWord('grape', 'raisin', 'عنب'),
    _createWord('strawberry', 'fraise', 'فراولة'),
    _createWord('watermelon', 'pastèque', 'بطيخ'),
    
    // Food - Vegetables
    _createWord('carrot', 'carotte', 'جزر'),
    _createWord('potato', 'pomme de terre', 'بطاطس'),
    _createWord('tomato', 'tomate', 'طماطم'),
    _createWord('onion', 'oignon', 'بصل'),
    
    // Food - Other
    _createWord('bread', 'pain', 'خبز'),
    _createWord('cheese', 'fromage', 'جبن'),
    _createWord('milk', 'lait', 'حليب'),
    _createWord('egg', 'œuf', 'بيضة'),
    _createWord('chicken', 'poulet', 'دجاج'),
    _createWord('rice', 'riz', 'أرز'),
    _createWord('pizza', 'pizza', 'بيتزا'),
    _createWord('cake', 'gâteau', 'كعكة'),
    _createWord('chocolate', 'chocolat', 'شوكولاتة'),
    _createWord('ice cream', 'glace', 'آيس كريم'),
    _createWord('coffee', 'café', 'قهوة'),
    _createWord('tea', 'thé', 'شاي'),
    
    // Body Parts
    _createWord('head', 'tête', 'رأس'),
    _createWord('eye', 'œil', 'عين'),
    _createWord('ear', 'oreille', 'أذن'),
    _createWord('nose', 'nez', 'أنف'),
    _createWord('mouth', 'bouche', 'فم'),
    _createWord('hand', 'main', 'يد'),
    _createWord('foot', 'pied', 'قدم'),
    
    // Actions & Emotions
    _createWord('happy', 'heureux', 'سعيد'),
    _createWord('sad', 'triste', 'حزين'),
    _createWord('angry', 'en colère', 'غاضب'),
    _createWord('sleep', 'dormir', 'نوم'),
    _createWord('eat', 'manger', 'أكل'),
    _createWord('drink', 'boire', 'شرب'),
    _createWord('run', 'courir', 'جري'),
    _createWord('jump', 'sauter', 'قفز'),
    _createWord('dance', 'danser', 'رقص'),
    _createWord('sing', 'chanter', 'غناء'),
    
    // Colors
    _createWord('red', 'rouge', 'أحمر'),
    _createWord('blue', 'bleu', 'أزرق'),
    _createWord('green', 'vert', 'أخضر'),
    _createWord('yellow', 'jaune', 'أصفر'),
    _createWord('black', 'noir', 'أسود'),
    _createWord('white', 'blanc', 'أبيض'),
    
    // Numbers
    _createWord('one', 'un', 'واحد'),
    _createWord('two', 'deux', 'اثنان'),
    _createWord('three', 'trois', 'ثلاثة'),
    _createWord('four', 'quatre', 'أربعة'),
    _createWord('five', 'cinq', 'خمسة'),
    
    // Misc Common Words
    _createWord('baby', 'bébé', 'طفل'),
    _createWord('family', 'famille', 'عائلة'),
    _createWord('friend', 'ami', 'صديق'),
    _createWord('school', 'école', 'مدرسة'),
    _createWord('ball', 'ballon', 'كرة'),
  ];
}
