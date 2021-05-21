import 'package:flutter/material.dart';
//import 'puzzle_classes.dart;
import 'dart:math';
import 'puzzle_globals.dart' as globals;

// The Tile is square. Size is the smaller of height and width
double getTileSize(BuildContext context, int nbrRows, int nbrColumns,
    {double scale = 0.9, double margin = 8.0}) {
  double w = getTileWidth(context, nbrColumns, scale: scale, margin: margin);
  double h = getTileHeight(context, nbrRows, scale: scale, margin: margin);
  double tileSide = min(w, h);
  return tileSide;
}

// The width is the screen width divided by nbr of columns
// adjusted by a scale factor and a margin (default 0.9 and 8px)
double getTileWidth(BuildContext context, int nbrColumns,
    {double scale = 0.9, double margin = 8.0}) {
  double screenW = screenWidth(context);
  double rectangleWidth = scale * screenW - margin;

  double tileWidth = (rectangleWidth / nbrColumns);
  return tileWidth;
}

// Analogous to width
double getTileHeight(BuildContext context, int nbrRows,
    {double scale = 0.9, double margin = 8.0}) {
  double screenH = screenHeight(context);
  double rectangleHeight = scale * screenH - margin;

  double tileHeight = (rectangleHeight / nbrRows);
  return tileHeight;
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

// Tile colors alternate except for the last one, which
// is the hole
// id = tile nbr; x, y the position coordinates,
// nbrR, nbrC = rows, columns of the Board
// returns 0,1,2 for even, odd, last
int getTileColor(int id) {
  int cix = 2; //Provisionally code for the last
  if (!detectLastTile(id, globals.nbrRows, globals.nbrColumns)) {
    //cix = (x + y) % 2;
    cix = (((id - 1) % globals.nbrColumns) +
            ((id - 0.5) / globals.nbrRows).truncate()) %
        2;
  }
  //print("Color: $id, $cix");
  return cix;
}

// Returns true if this is the last Tile, i.e the one that's missing
// which has the highest id, counted from 1
// id = tile number; nbrR = rows; nbrC = columns
bool detectLastTile(int id, int nbrR, nbrC) {
  if (id == (nbrR * nbrC)) {
    return true;
  } else {
    return false;
  }
}
