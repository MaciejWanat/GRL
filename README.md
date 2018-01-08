# GRL
Program translating GRL (Graphs Representation Language) into dot, with lex and yacc. It was made as a Text Proccessing student's project.

Contents:
* grl.l - lex tokenizer for GRL language
* grl.y - flex parser for GRL language
* grlEx - example graph wrriten in GRL
* Make - commands that builds lexer & parser, and then translates grlEx into dot and prints graph in ps format. To run the program you need to have Lex, Flex and dot installed on your machine.

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
EDGE 1--3 "Edge label";
```
Edge label is optional. You can use -> to make a directed edge.
* To end a graph:
```
END_GRAPH;
```
