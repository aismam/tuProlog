# Logic Programming (and introduction to Prolog)

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

Applications:
* Rapid prototyping of algorithms
* Rapid prototyping of DSLs
* Dynamically evolving structures
* Reasoning-like computation (planning)
* Rule-based computation
* Semantic and symbolic reasoning
* Agent-based programming languages

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

### Syntax of Prolog
Grammar
* Symbols:
      * X variables, f atoms/functions/constants, p predicates
* TERMS        t :: = X | f(t...,t)
* GOALS        G ::= p(t,...,t)
* RESOLVENTS   R ::= G,...,G
* CLAUSE       C ::= G :- R
* PROGRAM      P ::= C ... C

Substitution
* $\theta$ is denoted {X/t .. X/t}, representing an operator on terms(/goals): $\theta$ t=t’
* mgu(t,t’) is a most general unifier

### Semantics of Prolog
Given a program P, and a resolvent goal, a solution is a minimal substitution such that:
* if the resolvent is empty, solution is {}
* if the resolvent is G1,G2,..Gn
   * Find in P a clause G’:-G1’,…,Gm’ (fresh version)
   * Let $\theta$ be mgu(G1,G’)
   * Let $\theta$’ be the solution of resolvent G1’$\theta$,…,Gm’$\theta$,G2,..,Gn
   * Solution is $\theta \theta$’
Hence a solution is given by a list of resolvents, starting with the input until reaching the empty list, each paired with the (minimal) substituionì created up to that point.

#### Example 1
```
son(X,Y):-father(Y,X),male(X).
grandfather(X,Z):-father(X,Y),father(Y,Z).
father(abraham,isaac).
father(terach,nachor).
father(terach,abraham).
male(isaac).
```
Sequence (tree) of resolvents (list of goals)
* grandfather(terach,isaac) {}
* father(terach,Y),father(Y,isaac) {}
* father(abraham,isaac) {}
* Final result, {}
* (note the path father(terach,nachor) leads to nosolution)

#### Example 2
```
son(X,Y):-father(Y,X),male(X).
grandfather(X,Z):-father(X,Y),father(Y,Z).
father(abraham,isaac).
father(terach,nachor).
father(terach,abraham).
male(isaac).
```
Sequence (tree) of resolvents (list of goals)
* grandfather(A,B) {}
* father(A,Y),father(Y,B) {}
* father(abraham,B) {A/terach}
* . {A/terach, B/nachor}

### Lists in Prolog
Lists in Prolog got an ad-hoc syntax:
* [H|T], where H is the Head of the list and T is a List that represent the Tail.
* [] stands for the end of a list
* [H1,H2] represent a list with 2 values, H1 and H2.
* [H1,H2|T] represent first 2 values of a list (H1,H2) and the tail (T).
