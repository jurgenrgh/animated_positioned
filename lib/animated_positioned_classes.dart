import 'package:flutter/material.dart';
import 'puzzle_globals.dart' as globals;

class Board {
  static final tiles = List.generate(
      globals.maxRows,
      (i) => List.generate(globals.maxCols, (j) => i * globals.maxCols + j + 1,
          growable: false),
      growable: false);

  static initTiles(int rows, int cols) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        tiles[i][j] = i * cols + j + 1;
      }
    }
  }
}

class tile extends StatefulWidget {
  final int id;
  int row;
  int col;

  tile({required this.id, this.row = 1, this.col = 1, Key? key})
      : super(key: key);

  @override
  _tileState createState() => _tileState();
}

class _tileState extends State<tile> {
  var totalTiles = globals.nbrRows * globals.nbrColumns;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: globals.tileSize,
      height: globals.tileSize,
      top: (globals.tileSize * widget.row),
      left: (globals.tileSize * widget.col),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () {
          // print("${widget.row}, ${widget.col}");
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
          color: Colors.blue,
          child: Center(
            child: Text(
              '${widget.id}',
            ),
          ),
        ),
      ),
    );
  }
}