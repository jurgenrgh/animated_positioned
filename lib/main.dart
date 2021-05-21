/// Flutter code sample for AnimatedPositioned

// The following example transitions an AnimatedPositioned
// between two states. It adjusts the `height`, `width`, and
// [Positioned] properties when tapped.

import 'package:flutter/material.dart';
import 'puzzle_globals.dart' as globals;
import 'animated_positioned_classes.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Sample: AnimatedPositioned';

  @override
  Widget build(BuildContext context) {
    //globals.tileSize = 70;

    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  //int margin = 4 * globals.nbrColumns;

  @override
  Widget build(BuildContext context) {
    Board.initTiles(globals.nbrRows, globals.nbrColumns);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.black, // red as border color
        ),
      ),
      child: SizedBox(
        width: globals.nbrColumns * globals.tileSize,
        height: globals.nbrRows * globals.tileSize,
        child: Stack(
          children: [
            for (int row = 0; row < globals.nbrRows; row++)
              for (int col = 0; col < globals.nbrColumns; col++)
                if ((globals.nbrColumns * row + col + 1) <
                    (globals.nbrColumns * globals.nbrRows))
                  Tile(
                      id: globals.nbrColumns * row + col + 1,
                      col: col,
                      row: row)
          ],
        ),
      ),
    );
  }
}
