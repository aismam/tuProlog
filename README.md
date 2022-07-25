# Prolog introduction and exercices

## Logic Programming
LP is using mathematical logic for computing programming, logic is used as declarative representation language and as a theorem-prover.

It is comparable to imperative programming:
* to achieve efficency, some imperative mechanisms are often used to "control" program execution
* still, a declarative interpretation is possibile which is higher-level. and helps ensuring correctness

## Prolog
Invented as a specialised theorem prover, now the reference for so-called "logic programming" (LP).
It got interesting relationships with databases, XML and rule-engines.

Prolog in S/W engineering practice:
* classical criticism 1: efficiency and scalability
* classical criticism 2: not natural for “effects” (I/O, state)
* very useful and used in specific contexts (frequently related to AI), i.e., not truly general-purpose
* certain mechanisms of FP aim at reaching the expressiveness of LP

### Wich Prolog ?
* GnuProlog:  [www.gprolog.org/](www.gprolog.org/)
    * a free and open-source Prolog engine
    * available in most Linux distributions
* SWIProlog: [www.swi-prolog.org](www.swi-prolog.org)
    * free software
    * comes with many libraries and extensions
* Sicstus Prolog: [www.sics.se/sicstus](www.sics.se/sicstus)
    * a commercial, high-performance version
* tuProlog: [http://sourceforge.net/projects/tuprolog/](http://sourceforge.net/projects/tuprolog/)
    * an academic open-source tool written in Java
    * with built-in Java integration

### TuProlog (4.0.3)
<img src="https://github.com/aismam/tuProlog/blob/main/resources/tuProlog_IDE.png"
     alt="tuProlog IDE"
     style="float: left; margin-right: 10px;" />

The 2Prolog integration framework, many versions available
* we adopt version 4.X.Y (depends on JRE)
* http://apice.unibo.it/xwiki/bin/view/Tuprolog/WebHome
* download the runnable package
* just double-click 2p-4.0.3.jar and you are ready (should use JDK 1.8)
* or: java -jar 2p-4.0.4.jar from the console

## Part 1: Queries on list

#### Ex1.1: search
``` 
% search(Elem, List)
search(X, [X|_]).
search(X, [_|Xs]) :- search(X, Xs).
```
* X|Xs is another usual naming schema for H|T
* The above theory represents the search functionality
* Read the code as follows:
  * search is OK if the element X is the head of the list
  * search is OK if the element X occurs in the tail Xs
###### One code, many purposes
* Try the following goals:
  * Check all the possible solutions!
  * To this end, use either the solve-all button or the solve button: in the latter
case, repeatedly use Next button until all the solutions are found
  * If you adopt solve-all be careful with infine branches in the resolution tree
* query:
  * search(a,[a,b,c]).
  * search(a,[c,d,e]).
  * iteration:
  * search(X,[a,b,c]).
* generation:
  * search(a,X).
  * search(a,[X,b,Y,Z]).
  * search(X,Y).
###### Resolution Tree
The tree represents the computational behaviour: it is traversed in the so-called depth-first (left-most) strategy which leads to the order of solutions X/a, Y/a, Z/a

#### Ex1.2: search2
``` 
% search2(Elem, List)
% looks for two consecutive occurrences of Elem
search2(X, [X,X|_]).
search2(X, [_|Xs]):- search2(X,Xs).
``` 
First predict and then test the result(s) of:
* search2(a,[b,c,a,a,d,e,a,a,g,h]).
* search2(a,[b,c,a,a,a,d,e]).
* search2(X,[b,c,a,a,d,d,e]).
* search2(a,L).
* search2(a,[_,_,a,_,a,_]).

#### Ex1.3: search_two
``` 
% search_two(Elem,List)
% looks for two occurrences of Elem with any element in between!
``` 
Realise it yourself by changing search2, expected results are:
* search_two(a,[b,c,a,a,d,e]).  no
* search_two(a,[b,c,a,d,a,d,e]).  yes

#### Ex1.4: search_anytwo
``` 
% search_anytwo(Elem,List)
% looks for any Elem that occurs two times, anywhere
``` 
Suggestion:
* Elem must be on the head and search must be successful on the tail
* otherwise proceed on the tail
* (search_anytwo should use search)

Expected results are:
* search_anytwo(a,[b,c,a,a,d,e]). -> yes
* search_anytwo(a,[b,c,a,d,e,a,d,e]). -> yes

## Part 2: Extracting information from a list

#### Ex2.1: size
``` 
% size(List, Size)
% Size will contain the number of elements in List
size([],0).
size([_|T],M) :- size(T,N), M is N+1.
``` 
#### Ex2.2: size with s(s(..(zero)
``` 
% size(List,Size)
% Size will contain the number of elements in List,
written using notation zero, s(zero), s(s(zero))..
``` 
Realise this version yourself!
* size( [a,b,c],X ). -> X/s(s(s(zero)))

Can it allow for a pure relational behaviour?
* size( L, s(s(s(zero)))). ??

Note: Built-in numbers are extra-relational!

#### Ex 2.3: sum
```
% sum(List,Sum)
?- sum([1,2,3],X).
yes.
X/6
```

#### Ex2.5: maximum
```
% max(List,Max)
% Max is the biggest element in List
% Suppose the list has at least one element
```
Do you need an extra argument?
* first develop: max(List,Max,TempMax)
* where TempMax is the maximum found so far (initially it is the first number in the list.)

#### Ex2.6: max and min
```
% max(List,Max,Min)
% Max is the biggest element in List
% Min is the smallest element in List
% Suppose the list has at least one element
```
Realise this yourself!
* by properly changing max
* note you ahve a predicate with “2 outputs”

## Part 3: Compare list

#### Ex3.1: same
```
% same(List1,List2)
% are the two lists exactly the same?
same([],[]).
same([X|Xs],[X|Ys]):- same(Xs,Ys).
```

#### Ex3.2: all_bigger
```
% all_bigger(List1,List2)
% all elements in List1 are bigger than those in List2, 1 by 1
% example: all_bigger([10,20,30,40],[9,19,29,39]).
```

Ex3.3: sublist
```
% sublist(List1,List2)
% List1 should contain elements all also in List2
% example: sublist([1,2],[5,3,2,1]).
```

## Part 4: Creation lists

#### Ex4.1: seq
```
% seq(N,List)
% example: seq(5,[0,0,0,0,0]).
seq(0,[]).
seq(N,[0|T]):- N > 0, N2 is N-1, seq(N2,T).
```

#### Ex4.2: seqR
```
% seqR(N,List)
% example: seqR(4,[4,3,2,1,0]).
```

#### Ex4.3: seqR2
```
% seqR2(N,List)
% example: seqR2(4,[0,1,2,3,4]).
```





