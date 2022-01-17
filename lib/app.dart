import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const numInRow = 25;
const numInCol = numInRow * 36;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var gameStarted = false;
  var snake = [75, 100, 125, 150, 175];

  static var randomNum = Random();
  int food = randomNum.nextInt(900);
  void generateNewFood() {
    food = randomNum.nextInt(900);
  }

  void startGame() {
    // snake = [78, 103, 128, 153, 178];
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      // if (gameOver) {
      //   timer.cancel();
      //   _showGameOverScreen();
      // }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snake.last >= 875) {
            snake.add(snake.last + 25 - 900);
          } else {
            snake.add(snake.last + 25);
          }
          break;
        case 'up':
          if (snake.last <= 24) {
            snake.add(snake.last - 25 + 900);
          } else {
            snake.add(snake.last - 25);
          }
          break;
        case 'left':
          if (snake.last % 25 == 0) {
            snake.add(snake.last - 1 + 25);
          } else {
            snake.add(snake.last - 1);
          }
          break;
        case 'right':
          if ((snake.last + 1) % 25 == 0) {
            snake.add(snake.last + 1 - 25);
          } else {
            snake.add(snake.last + 1);
          }
          break;
        default:
          break;
      }

      if (snake.last == food) {
        generateNewFood();
      } else {
        snake.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numInRow),
              itemCount: numInCol,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: snake.contains(index)
                        ? Colors.red
                        : index == food
                            ? Colors.green
                            : Colors.grey[900],
                    // child: Text(
                    //   index.toString(),
                    //   style: TextStyle(color: Colors.white, fontSize: 6),
                    // ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: gameStarted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: IconButton(
                          onPressed: () => setState(() {
                            direction = 'left';
                          }),
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                onPressed: () => setState(() {
                                  direction = 'up';
                                }),
                                icon: const Icon(
                                  Icons.arrow_upward_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                onPressed: () => setState(() {
                                  direction = 'down';
                                }),
                                icon: const Icon(
                                  Icons.arrow_downward_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: IconButton(
                          onPressed: () => setState(() {
                            direction = 'right';
                          }),
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () => {
                      startGame(),
                      setState(() {
                        gameStarted = true;
                      })
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
