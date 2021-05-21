import 'package:flutter/material.dart';
import 'puzzle_globals.dart' as globals;
import 'puzzle_functions.dart';
import 'dart:math';

class Board {
  static final tiles = List.generate(
      globals.maxRows,
      (i) => List.generate(globals.maxCols, (j) => i * globals.maxCols + j + 1,
          growable: false),
      growable: false);

  static initTiles(int rows, int cols) {
    print("init Tiles called, Flag: ${globals.shuffleFlag}");
    if (!globals.shuffleFlag) {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          tiles[i][j] = i * cols + j + 1;
        }
      }
    }
    globals.shuffleFlag = false;
  }

  static int getRandomIx(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  static shuffle(int rows, int cols) {
    print("Board.Shuffle. ShuffleFlag: ${globals.shuffleFlag}");
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        int i = getRandomIx(rows);
        int j = getRandomIx(cols);
        int tem = tiles[i][j];
        tiles[i][j] = tiles[row][col];
        tiles[row][col] = tem;
        print("$i, $j, $row, $col");
      }
    }
    print(Board.tiles);
  }
}

class ShuffleButton extends StatelessWidget {
  final Function doShuffle;
  ShuffleButton({required this.doShuffle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        doShuffle();
        //print("onTap Shuffle Button. ShuffleFlag: ${globals.shuffleFlag}");
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.amber[500],
        ),
        child: Center(
          child:
              Text('Shuffle', style: TextStyle(fontSize: globals.tileSize / 4)),
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  final int id;
  int row;
  int col;

  Tile({required this.id, this.row = 1, this.col = 1, Key? key})
      : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  //var totalTiles = globals.nbrRows * globals.nbrColumns;
  @override
  Widget build(BuildContext context) {
    Color _color = globals.tileColors[getTileColor(
      Board.tiles[widget.row][widget.col],
    )];
    return AnimatedPositioned(
      width: globals.tileSize,
      height: globals.tileSize,
      top: (globals.tileSize * widget.row),
      left: (globals.tileSize * widget.col),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () {
          var totalTiles = globals.nbrRows * globals.nbrColumns;
          print(
              "${widget.row}, ${widget.col}, ${totalTiles}, ${globals.nbrSideTiles}");
          setState(() {
            if (((widget.col + 1) < globals.nbrColumns) &&
                (Board.tiles[widget.row][widget.col + 1] == totalTiles)) {
              Board.tiles[widget.row][widget.col + 1] =
                  Board.tiles[widget.row][widget.col];
              Board.tiles[widget.row][widget.col] = totalTiles;
              widget.col += 1;
            } else if ((widget.col > 0) &&
                (Board.tiles[widget.row][widget.col - 1] == totalTiles)) {
              Board.tiles[widget.row][widget.col - 1] =
                  Board.tiles[widget.row][widget.col];
              Board.tiles[widget.row][widget.col] = totalTiles;
              widget.col += -1;
            } else if (((widget.row + 1) < globals.nbrRows) &&
                (Board.tiles[widget.row + 1][widget.col] == totalTiles)) {
              Board.tiles[widget.row + 1][widget.col] =
                  Board.tiles[widget.row][widget.col];
              Board.tiles[widget.row][widget.col] = totalTiles;
              widget.row += 1;
            } else if ((widget.row > 0) &&
                (Board.tiles[widget.row - 1][widget.col] == totalTiles)) {
              Board.tiles[widget.row - 1][widget.col] =
                  Board.tiles[widget.row][widget.col];
              Board.tiles[widget.row][widget.col] = totalTiles;
              widget.row += -1;
            }
          });
          // print("${Board.tiles}");
        },
        child: Container(
          margin: const EdgeInsets.all(2.0),
          color: _color,
          child: Center(
            child: Text(
              '${widget.id}',
              style: TextStyle(fontSize: globals.tileSize / 2),
            ),
          ),
        ),
      ),
    );
  }
}
