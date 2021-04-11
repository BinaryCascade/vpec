import 'package:flutter/material.dart';

class JobQuizStorage extends ChangeNotifier {
  int questionNumber = 0;
  int greenCards = 0;
  int blueCards = 0;
  int yellowCards = 0;
  int purpleCards = 0;
  int selectedAnswer = 0;
  bool showResults = false;

  void setAnswer(int newAnswer) {
    selectedAnswer = newAnswer;
  }

  String get resultText {
    if (greenCards > blueCards &&
        greenCards > yellowCards &&
        greenCards > purpleCards) {
      return 'Вам нужно задуматься о профессии, связанной с '
          'компьютерными специальностями!';
    }
    if (blueCards > greenCards &&
        blueCards > yellowCards &&
        blueCards > purpleCards) {
      return 'Вам нужно задуматься о профессии, связанной с '
          'электрическими сетями, станциями, системами и электроснабжением!';
    }
    if (yellowCards > greenCards &&
        yellowCards > blueCards &&
        yellowCards > purpleCards) {
      return 'Вам нужно задуматься о профессии, связанной с '
          'гостиничным делом!';
    }

    if (purpleCards > greenCards &&
        purpleCards > blueCards &&
        purpleCards > yellowCards) {
      return 'Вам нужно задуматься о профессии, связанной с '
          'экономикой, финансами, бухгалтерским учётом!';
    }

    // check for duplicates numbers in variables
    List<int> list = [greenCards, blueCards, yellowCards, purpleCards];
    List duplicates = [];
    bool haveDuplicates = false;

    list.forEach((element) {
      if (duplicates.contains(element))
        haveDuplicates = true;
      else
        duplicates.add(element);
    });
    if (haveDuplicates) {
      return 'Похоже, Вы уникальный человек! У Вас есть предрасположенность к '
          'нескольким профессиям:\n'
          'Компьютерные специальности: $greenCards\n'
          'Электрические специальности: $blueCards\n'
          'Гостиничное дело: $yellowCards\n'
          'Бух. учёт: $purpleCards';
    } else {
      return 'Непредвиденная ошибка в обработке данных ответов\n'
          '$greenCards, $blueCards, $yellowCards, $purpleCards';
    }
  }

  String get firstAnswer {
    switch (questionNumber) {
      case 0:
        return 'Научные открытия';
      case 1:
        return 'Умение решать задачи, справляться с трудностями';
      case 2:
        return 'Внутренне устройство экспонатов';
      case 3:
        return 'Общаюсь в узком направлении, которое мне интересно';
      case 4:
        return 'В помещении, где много людей';
      case 5:
        return 'Знают больше, чем я';
      case 6:
        return 'Обслуживание техники';
      case 7:
        return 'Подберёте быстрый и комфортный маршрут';
      case 8:
        return 'Работать с техникой';
      default:
        return 'Неизвестный вопрос';
    }
  }

  String get secondAnswer {
    switch (questionNumber) {
      case 0:
        return 'Развитие производства';
      case 1:
        return 'Ответственность, надёжность';
      case 2:
        return 'Принцип работы экспонатов';
      case 3:
        return 'Охотно общаюсь по интересующей меня и людей теме';
      case 4:
        return 'В необычных условиях';
      case 5:
        return 'Всегда верны и надёжны';
      case 6:
        return 'Ремонт вещей, техники, жилища';
      case 7:
        return 'Подберёте самый безопасный маршрут';
      case 8:
        return 'Ремонтировать различные механизмы';
      default:
        return 'Неизвестный вопрос';
    }
  }

  String get thirdAnswer {
    switch (questionNumber) {
      case 0:
        return 'Взаимопонимание между людьми';
      case 1:
        return 'Доброту, отзывчивость';
      case 2:
        return 'Внешний вид экспонатов';
      case 3:
        return 'Веду диалоги на разные темы';
      case 4:
        return 'Во многоуровневом помещении, здании';
      case 5:
        return 'Помогают другим, когда для этого предоставляется случай';
      case 6:
        return 'Обустройство территории';
      case 7:
        return 'Найдёте и забронируете место жительства, интересные экскурсии';
      case 8:
        return 'Общаться с самыми разными людьми';
      default:
        return 'Неизвестный вопрос';
    }
  }

  String get fourthAnswer {
    switch (questionNumber) {
      case 0:
        return 'Стабильная экономика страны';
      case 1:
        return 'Честность, организованность, внимание к деталям';
      case 2:
        return 'Ценность экспонатов';
      case 3:
        return 'Предпочитаю точность в общении';
      case 4:
        return 'В обычном кабинете';
      case 5:
        return 'Всегда и везде следуют правилам';
      case 6:
        return 'Выполнение расчётов';
      case 7:
        return 'Рассчитаете возможности своих финансов';
      case 8:
        return 'Вести документацию, заниматься расчётами';
      default:
        return 'Неизвестный вопрос';
    }
  }

  void chooseAnswer() {
    questionNumber++;
    switch (selectedAnswer) {
      case 1:
        greenCards++;
        notifyListeners();
        break;
      case 2:
        blueCards++;
        notifyListeners();
        break;
      case 3:
        yellowCards++;
        notifyListeners();
        break;
      case 4:
        purpleCards++;
        notifyListeners();
        break;
    }

    if (questionNumber > 8) {
      showResults = true;
    }
    selectedAnswer = 0;
  }

  String get questionText {
    switch (questionNumber) {
      case 0:
        return 'По моему мнению, будущее людей определяет:';
      case 1:
        return 'Больше всего в человеке я ценю: ';
      case 2:
        return 'Представьте, что Вы на выставке. '
            'Что Вас больше привлекает в экспонатах?';
      case 3:
        return 'В общении с людьми обычно я: ';
      case 4:
        return 'Я предпочту работать: ';
      case 5:
        return 'Я рад(а), когда мои друзья: ';
      case 6:
        return 'Меня привлекает:  ';
      case 7:
        return 'Родители подарили Вам путёвку в другую страну. Незамедлительно Вы: ';
      case 8:
        return 'Мне хотелось бы в своей профессиональной деятельности: ';
      case 9:
        return 'Подведение итогов';
      default:
        return 'Неизвестный номер вопроса';
    }
  }
}
