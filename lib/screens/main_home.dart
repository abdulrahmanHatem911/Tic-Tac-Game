import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictac_game/game_logic.dart';
import 'package:flutter_launcher_icons/android.dart';

class MainHome extends StatefulWidget {
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String activePlayer = 'X';
  String result = '';
  bool gameOver = false;
  bool isSwitch = false;
  int turne = 0;
  Game game = Game();
  _onTapFunctine(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGmae(index, activePlayer);
      updatState();
      if (!isSwitch && !gameOver) {
        await game.autoPlay(activePlayer);
        updatState();
      }
    }
  }

  void updatState() {
    setState(() {
      activePlayer = (activePlayer == "X" ? "O" : "X");
      turne++;
    });
    String winnerPlayer = game.checkWiner();
    if (winnerPlayer != '') {
      gameOver = true;
      result = '$winnerPlayer is the winner!';
    } else if (!gameOver && turne == 9) {
      result = 'It\'s Draw!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ..._firstBlock(),
                    _expandedWidget(context),
                    ...lastBlock(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ..._firstBlock(),
                          const SizedBox(
                            height: 20,
                          ),
                          ...lastBlock(),
                        ],
                      ),
                    ),
                    _expandedWidget(context),
                  ],
                )),
    );
  }

  List<Widget> _firstBlock() {
    return [
      SwitchListTile.adaptive(
        title: const Text(
          'Turn on/off two player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        value: isSwitch,
        onChanged: (bool newValue) {
          setState(() {
            isSwitch = newValue;
          });
        },
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "It\'s $activePlayer turn".toUpperCase(),
        style: const TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  Expanded _expandedWidget(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        crossAxisCount: 3,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: gameOver == true ? null : () => _onTapFunctine(index),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Player.playerX.contains(index)
                            ? "X"
                            : Player.playerO.contains(index)
                                ? "O"
                                : "",
                        style: TextStyle(
                          color: Player.playerX.contains(index)
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  List<Widget> lastBlock() {
    return [
      Text(
        result,
        style: const TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            result = '';
            gameOver = false;
            turne = 0;
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text(
          "Repeat the game",
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
    ];
  }
}
