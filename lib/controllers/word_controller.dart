import 'dart:math';
import 'package:get/get.dart';

class WordController extends GetxController {
  final List<String> wordsToFind = ["flutter", "dart", "getx"];
  final RxString _currentWord =
      "".obs; // Foydalanuvchi tomonidan kiritilgan so'z
  final RxString _targetWord = "".obs; // Topilishi kerak bo'lgan so'z

  // Tasodifiy so'zni tanlash
  void generateTargetWord() {
    final random = Random();
    _targetWord.value = wordsToFind[random.nextInt(wordsToFind.length)];
  }

  // Harflarni tasodifiy aralashgan holda olish
  List<String> _generateRandomLetters(String word) {
    final random = Random();
    final allLetters =
        List<String>.generate(26, (index) => String.fromCharCode(index + 65));
    final selectedLetters = word.toUpperCase().split('');
    final additionalLetters = <String>{};

    while (additionalLetters.length < 14 - selectedLetters.length) {
      final letter = allLetters[random.nextInt(allLetters.length)];
      if (!selectedLetters.contains(letter) &&
          !additionalLetters.contains(letter)) {
        additionalLetters.add(letter);
      }
    }

    final combinedLetters = [...selectedLetters, ...additionalLetters]
      ..shuffle(random);
    return combinedLetters; //shuffle
  }

  @override
  void onInit() {
    super.onInit();
    generateTargetWord();
  }

  RxString get currentWord => _currentWord;
  RxString get targetWord => _targetWord;

  void addLetter(String letter) {
    _currentWord.value += letter;
  }

  void deleteLetter() {
    _currentWord.value =
        _currentWord.value.substring(0, _currentWord.value.length - 1);
  }

  void clearWord() {
    _currentWord.value = "";
  }

  bool checkWord() {
    return _currentWord.value.toLowerCase() == _targetWord.value.toLowerCase();
  }

  bool addNewWord(String word) {
    try {
      wordsToFind.add(word);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<String> getRandomLetters() {
    return _generateRandomLetters(_targetWord.value);
  }
}
