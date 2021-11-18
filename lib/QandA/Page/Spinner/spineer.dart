import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';

class Spinner extends StatefulWidget {
  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  final StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      '10',
      '500',
      '30',
      '20',
      '100',
      '200',
      '50',
      '70',
    ];
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double height = size.height - padding.top;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/quiz/spinnerbackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          //  appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                //coins count
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset('assets/quiz/spinnerbagcoins.png'),
                        ),
                        Chip(
                          backgroundColor: Colors.red,
                          avatar: CircleAvatar(
                            child:
                                Image.asset('assets/quiz/spinnerbagcoins.png'),
                          ),
                          label: Text('100'),
                        )
                      ],
                    ),
                  ),
                ),

                //spinner
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: FortuneWheel(
                              animateFirst: false,
                              onAnimationEnd: () {},
                              selected: selected.stream,
                              physics: CircularPanPhysics(
                                duration: Duration(seconds: 1),
                                curve: Curves.decelerate,
                              ),
                              onFling: () {
                                selected.add(1);
                              },
                              indicators: <FortuneIndicator>[
                                FortuneIndicator(child: Container())
                              ],
                              items: [
                                for (var it in items)
                                  FortuneItem(
                                      child: Text(it),
                                      style: FortuneItemStyle(
                                        color: Colors.orange,
                                        borderColor: Colors.green,
                                        borderWidth: 3,
                                      )),
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected.add(
                                Fortune.randomInt(0, items.length),
                              );
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      'assets/quiz/Spinnermiddlebutton.png',
                                    ))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //video reward
                //share
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
