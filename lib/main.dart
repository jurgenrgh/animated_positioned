/// Flutter code sample for AnimatedPositioned

// The following example transitions an AnimatedPositioned
// between two states. It adjusts the `height`, `width`, and
// [Positioned] properties when tapped.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'puzzle_globals.dart' as globals;
import 'animated_positioned_classes.dart';
import 'puzzle_functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Puzzle15());
}

class Puzzle15 extends StatelessWidget {
  const Puzzle15({Key? key}) : super(key: key);

  static const String _title = 'Flutter App: Fifteen-Puzzle';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        accentColor: Colors.blue[200],
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      home: TopWidget(title: _title),
    );
  }
}

// The actual Top Level Widget
class TopWidget extends StatefulWidget {
  final String title;
  TopWidget({required this.title});

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  //
  // Methods
  //
  // Increase the size of the Board
  void plusSideLength() {
    setState(() {
      //>>>>>this is what causes the visual change
      if (globals.nbrSideTiles < 8) {
        globals.nbrRows++;
        globals.nbrColumns++;
        globals.nbrSideTiles++;
        Board.initTiles(globals.nbrRows, globals.nbrColumns);
      }
    });
  }

  // Reduce Size of the Board
  void minusSideLength() {
    setState(() {
      //>>>>>this is what causes the visual change
      if (globals.nbrSideTiles > 2) {
        globals.nbrRows--;
        globals.nbrColumns--;
        globals.nbrSideTiles--;
        Board.initTiles(globals.nbrRows, globals.nbrColumns);
      }
    });
  }

  // Arrange tiles randomly
  void executeShuffle() {
    //>>>>>this is what causes the visual change
    setState(() {
      print("executeShuffle callback. ShuffleFlag: ${globals.shuffleFlag}");
      globals.shuffleFlag = true; //prevent initializing
      Board.shuffle(globals.nbrRows, globals.nbrColumns);
    });
  }

  // Actual start of the widget construction
  @override
  Widget build(BuildContext context) {
    globals.tileSize =
        getTileSize(context, globals.nbrSideTiles, globals.nbrSideTiles);
    Board.initTiles(globals.nbrRows, globals.nbrColumns);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.title))),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Spacer(),
          SizedBox(
            width: globals.nbrColumns * globals.tileSize,
            height: globals.nbrRows * globals.tileSize,
            child: Stack(
              children: [
                for (int row = 0; row < globals.nbrRows; row++)
                  for (int col = 0; col < globals.nbrColumns; col++)
                    // if ((globals.nbrColumns * row + col + 1) <
                    //     (globals.nbrColumns * globals.nbrRows))
                    if (Board.tiles[row][col] !=
                        globals.nbrRows * globals.nbrColumns)
                      Tile(id: Board.tiles[row][col], col: col, row: row)
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShuffleButton(doShuffle: executeShuffle),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: plusSideLength,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.amber,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Size = ${globals.nbrSideTiles}',
                    style: TextStyle(fontSize: globals.tileSize / 4)),
              ),
              FloatingActionButton(
                onPressed: minusSideLength,
                child: new Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                backgroundColor: Colors.amber,
              ),
            ],
          ),
          Spacer(),
        ]),
      ),
    );
  }
}
