import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class WidgetGridController extends GetxController with StateMixin {
  late List<PreloadPageController> controllers;
  List<List<Widget>> sections = [];

  WidgetGridController(
      {required List<Widget> items, required Function placeholder}) {
    controllers = [
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
      PreloadPageController(viewportFraction: 0.7, initialPage: 1),
    ];

    reload(items, placeholder);
  }

  reload(List<Widget> items, Function placeholder) {
    change(null, status: RxStatus.loading());

    if (items.length > 81) {
      items.removeRange(81, items.length);
    }

    var cards = _getCards(items, placeholder);

    for (var col = 0; col < 9; col++) {
      sections.add([]);
      for (var row = 0; row < 3; row++) {
        sections[col].add(Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            cards[col][row * 3],
            cards[col][row * 3 + 1],
            cards[col][row * 3 + 2]
          ],
        ));
      }
    }
    change(sections, status: RxStatus.success());
  }

  animatePage(int page, int index) {
    for (int i = 0; i < 9; i++) {
      if (i != index) {
        controllers[i].animateToPage(page,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }

  List<List<Widget>> _getCards(List<Widget> items, Function placeholder) {
    List<List<Widget>> cards = [];

    for (var col = 0; col < 9; col++) {
      cards.add([]);
      for (var row = 0; row < 9; row++) {
        cards[col].add(Expanded(
          flex: Random().nextInt(5) + 3,
          child: placeholder(),
        ));
      }
    }

    int step = 1;
    int state = 0;
    int numSteps = 1;
    int turnCounter = 1;
    int x = 4, y = 4;

    while (step <= items.length) {
      cards[x][y] = Expanded(
        flex: Random().nextInt(5) + 8,
        child: items[step - 1],
      );

      switch (state) {
        case 0:
          x++;
          break;
        case 1:
          y--;
          break;
        case 2:
          x--;
          break;
        case 3:
          y++;
          break;
      }

      if (step % numSteps == 0) {
        state = (state + 1) % 4;
        turnCounter++;
        if (turnCounter % 2 == 0) {
          numSteps++;
        }
      }
      step++;
    }

    return cards;
  }
}
