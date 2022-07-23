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
