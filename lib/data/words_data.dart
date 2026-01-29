import '../models/word_model.dart';

class WordsData {
  static final List<WordModel> words = [
    // Animals
    WordModel(english: 'dog', french: 'chien', arabic: 'كلب'),
    WordModel(english: 'cat', french: 'chat', arabic: 'قطة'),
    WordModel(english: 'bird', french: 'oiseau', arabic: 'طائر'),
    WordModel(english: 'fish', french: 'poisson', arabic: 'سمكة'),
    WordModel(english: 'horse', french: 'cheval', arabic: 'حصان'),
    WordModel(english: 'cow', french: 'vache', arabic: 'بقرة'),
    WordModel(english: 'sheep', french: 'mouton', arabic: 'خروف'),
    WordModel(english: 'rabbit', french: 'lapin', arabic: 'أرنب'),
    WordModel(english: 'mouse', french: 'souris', arabic: 'فأر'),
    WordModel(english: 'lion', french: 'lion', arabic: 'أسد'),
    
    // Nature
    WordModel(english: 'tree', french: 'arbre', arabic: 'شجرة'),
    WordModel(english: 'flower', french: 'fleur', arabic: 'زهرة'),
    WordModel(english: 'sun', french: 'soleil', arabic: 'شمس'),
    WordModel(english: 'moon', french: 'lune', arabic: 'قمر'),
    WordModel(english: 'star', french: 'étoile', arabic: 'نجمة'),
    WordModel(english: 'water', french: 'eau', arabic: 'ماء'),
    WordModel(english: 'rain', french: 'pluie', arabic: 'مطر'),
    WordModel(english: 'snow', french: 'neige', arabic: 'ثلج'),
    WordModel(english: 'wind', french: 'vent', arabic: 'رياح'),
    WordModel(english: 'fire', french: 'feu', arabic: 'نار'),
    
    // Home & Objects
    WordModel(english: 'house', french: 'maison', arabic: 'منزل'),
    WordModel(english: 'door', french: 'porte', arabic: 'باب'),
    WordModel(english: 'window', french: 'fenêtre', arabic: 'نافذة'),
    WordModel(english: 'chair', french: 'chaise', arabic: 'كرسي'),
    WordModel(english: 'table', french: 'table', arabic: 'طاولة'),
    WordModel(english: 'bed', french: 'lit', arabic: 'سرير'),
    WordModel(english: 'lamp', french: 'lampe', arabic: 'مصباح'),
    WordModel(english: 'book', french: 'livre', arabic: 'كتاب'),
    WordModel(english: 'pen', french: 'stylo', arabic: 'قلم'),
    WordModel(english: 'phone', french: 'téléphone', arabic: 'هاتف'),
    
    // Transportation
    WordModel(english: 'car', french: 'voiture', arabic: 'سيارة'),
    WordModel(english: 'bus', french: 'bus', arabic: 'حافلة'),
    WordModel(english: 'train', french: 'train', arabic: 'قطار'),
    WordModel(english: 'plane', french: 'avion', arabic: 'طائرة'),
    WordModel(english: 'boat', french: 'bateau', arabic: 'قارب'),
    WordModel(english: 'bike', french: 'vélo', arabic: 'دراجة'),
    
    // Clothing
    WordModel(english: 'shirt', french: 'chemise', arabic: 'قميص'),
    WordModel(english: 'pants', french: 'pantalon', arabic: 'بنطلون'),
    WordModel(english: 'dress', french: 'robe', arabic: 'فستان'),
    WordModel(english: 'shoe', french: 'chaussure', arabic: 'حذاء'),
    WordModel(english: 'hat', french: 'chapeau', arabic: 'قبعة'),
    WordModel(english: 'coat', french: 'manteau', arabic: 'معطف'),
    
    // Food - Fruits
    WordModel(english: 'apple', french: 'pomme', arabic: 'تفاحة'),
    WordModel(english: 'banana', french: 'banane', arabic: 'موز'),
    WordModel(english: 'orange', french: 'orange', arabic: 'برتقالة'),
    WordModel(english: 'grape', french: 'raisin', arabic: 'عنب'),
    WordModel(english: 'strawberry', french: 'fraise', arabic: 'فراولة'),
    WordModel(english: 'watermelon', french: 'pastèque', arabic: 'بطيخ'),
    
    // Food - Vegetables
    WordModel(english: 'carrot', french: 'carotte', arabic: 'جزر'),
    WordModel(english: 'potato', french: 'pomme de terre', arabic: 'بطاطس'),
    WordModel(english: 'tomato', french: 'tomate', arabic: 'طماطم'),
    WordModel(english: 'onion', french: 'oignon', arabic: 'بصل'),
    
    // Food - Other
    WordModel(english: 'bread', french: 'pain', arabic: 'خبز'),
    WordModel(english: 'cheese', french: 'fromage', arabic: 'جبن'),
    WordModel(english: 'milk', french: 'lait', arabic: 'حليب'),
    WordModel(english: 'egg', french: 'œuf', arabic: 'بيضة'),
    WordModel(english: 'chicken', french: 'poulet', arabic: 'دجاج'),
    WordModel(english: 'rice', french: 'riz', arabic: 'أرز'),
    WordModel(english: 'pizza', french: 'pizza', arabic: 'بيتزا'),
    WordModel(english: 'cake', french: 'gâteau', arabic: 'كعكة'),
    WordModel(english: 'chocolate', french: 'chocolat', arabic: 'شوكولاتة'),
    WordModel(english: 'ice cream', french: 'glace', arabic: 'آيس كريم'),
    WordModel(english: 'coffee', french: 'café', arabic: 'قهوة'),
    WordModel(english: 'tea', french: 'thé', arabic: 'شاي'),
    
    // Body Parts
    WordModel(english: 'head', french: 'tête', arabic: 'رأس'),
    WordModel(english: 'eye', french: 'œil', arabic: 'عين'),
    WordModel(english: 'ear', french: 'oreille', arabic: 'أذن'),
    WordModel(english: 'nose', french: 'nez', arabic: 'أنف'),
    WordModel(english: 'mouth', french: 'bouche', arabic: 'فم'),
    WordModel(english: 'hand', french: 'main', arabic: 'يد'),
    WordModel(english: 'foot', french: 'pied', arabic: 'قدم'),
    
    // Actions & Emotions
    WordModel(english: 'happy', french: 'heureux', arabic: 'سعيد'),
    WordModel(english: 'sad', french: 'triste', arabic: 'حزين'),
    WordModel(english: 'angry', french: 'en colère', arabic: 'غاضب'),
    WordModel(english: 'sleep', french: 'dormir', arabic: 'نوم'),
    WordModel(english: 'eat', french: 'manger', arabic: 'أكل'),
    WordModel(english: 'drink', french: 'boire', arabic: 'شرب'),
    WordModel(english: 'run', french: 'courir', arabic: 'جري'),
    WordModel(english: 'jump', french: 'sauter', arabic: 'قفز'),
    WordModel(english: 'dance', french: 'danser', arabic: 'رقص'),
    WordModel(english: 'sing', french: 'chanter', arabic: 'غناء'),
    
    // Colors
    WordModel(english: 'red', french: 'rouge', arabic: 'أحمر'),
    WordModel(english: 'blue', french: 'bleu', arabic: 'أزرق'),
    WordModel(english: 'green', french: 'vert', arabic: 'أخضر'),
    WordModel(english: 'yellow', french: 'jaune', arabic: 'أصفر'),
    WordModel(english: 'black', french: 'noir', arabic: 'أسود'),
    WordModel(english: 'white', french: 'blanc', arabic: 'أبيض'),
    
    // Numbers
    WordModel(english: 'one', french: 'un', arabic: 'واحد'),
    WordModel(english: 'two', french: 'deux', arabic: 'اثنان'),
    WordModel(english: 'three', french: 'trois', arabic: 'ثلاثة'),
    WordModel(english: 'four', french: 'quatre', arabic: 'أربعة'),
    WordModel(english: 'five', french: 'cinq', arabic: 'خمسة'),
    
    // Misc Common Words
    WordModel(english: 'baby', french: 'bébé', arabic: 'طفل'),
    WordModel(english: 'family', french: 'famille', arabic: 'عائلة'),
    WordModel(english: 'friend', french: 'ami', arabic: 'صديق'),
    WordModel(english: 'school', french: 'école', arabic: 'مدرسة'),
    WordModel(english: 'ball', french: 'ballon', arabic: 'كرة'),
  ];
}
