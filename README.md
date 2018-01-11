# GRL
Program translating GRL (Graphs Representation Language) into dot, with lex and yacc. GRL is an artificial language made by me. Projecy was made as a Text Proccessing student's project.

Contents:
* grl.l - lex tokenizer for GRL language
* grl.y - yacc parser for GRL language
* grlEx - example graph wrriten in GRL
* Makefile - Makefile that builds lexer & parser, and then translates grlEx into dot and prints graph in ps format. To run it you need to have Lex, Yacc and dot installed on your machine.

# GRL Documentation

* Each line ends with a ';'.
* Comments starts with '#':
```
# An example comment
```
* To start a new graph:
```
BEGIN_GRAPH "GraphName";
```
* To start a new driected graph:
```
BEGIN_DIGRAPH "GraphName";
```
Graph name is optional.
* To draw a new node:
```
NODE 1 "Node label";
```
Node label is optional.
* To draw a new edge:
```
EDGE 1--3 "Edge label";  #Non directed edge
EDGE 1->3;               #Directed edge
```
Edge label is optional.
* To add an egde with a custom style:
```
EDGE 1->3 STYLE="dotted";
```
* To end a graph:
```
END_GRAPH;
```
* To set a node shape or style:
```
NODE 5 "Extra 2" STYLE="filled" SHAPE="star";
```
All flags are optional.
* To set a default node shape:
```
DEFAULT_SHAPE "circle";
```
* To set a default node style:
```
DEFAULT_STYLE "dotted";
```

Graph build from grlEx code:
![Graph image](http://bit.ly/2D1pw3D)
