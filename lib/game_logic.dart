import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void playGmae(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWiner() {
    String winner = '';
    if (Player.playerX.containAll(0, 1, 2) ||
        Player.playerX.containAll(3, 4, 5) ||
        Player.playerX.containAll(6, 7, 8) ||
        Player.playerX.containAll(0, 3, 6) ||
        Player.playerX.containAll(1, 4, 7) ||
        Player.playerX.containAll(2, 5, 8) ||
        Player.playerX.containAll(0, 4, 8) ||
        Player.playerX.containAll(2, 4, 6)) {
      return winner = 'X';
    } else if (Player.playerO.containAll(0, 1, 2) ||
        Player.playerO.containAll(3, 4, 5) ||
        Player.playerO.containAll(6, 7, 8) ||
        Player.playerO.containAll(0, 3, 6) ||
        Player.playerO.containAll(1, 4, 7) ||
        Player.playerO.containAll(2, 5, 8) ||
        Player.playerO.containAll(0, 4, 8) ||
        Player.playerO.containAll(2, 4, 6)) {
      return winner = 'O';
    } else
      winner = '';
    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCell = [];
    Random random = Random();
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCell.add(i);
      }
    }

    //defa3
    //start_center
    if (Player.playerX.containAll(0, 1) && emptyCell.contains(2)) {
      index = 2;
    } else if (Player.playerX.containAll(3, 4) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerX.containAll(6, 7) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerX.containAll(0, 3) && emptyCell.contains(6)) {
      index = 6;
    } else if (Player.playerX.containAll(1, 4) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerX.containAll(2, 5) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerX.containAll(2, 4) && emptyCell.contains(6)) {
      index = 6;
    } else if (Player.playerX.containAll(0, 4) && emptyCell.contains(8)) {
      index = 8;
    }
    //defa3
    //start_end
    else if (Player.playerX.containAll(0, 2) && emptyCell.contains(1)) {
      index = 1;
    } else if (Player.playerX.containAll(3, 5) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containAll(6, 8) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerX.containAll(0, 6) && emptyCell.contains(3)) {
      index = 3;
    } else if (Player.playerX.containAll(1, 7) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containAll(2, 8) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerX.containAll(0, 8) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containAll(2, 6) && emptyCell.contains(4)) {
      index = 4;
    } else {
      int randomindex = random.nextInt(emptyCell.length);
      index = emptyCell[randomindex];
    }

    playGmae(index, activePlayer);
  }
}
