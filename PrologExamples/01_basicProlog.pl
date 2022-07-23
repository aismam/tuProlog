% 1 - Queries on list

% 1.1 search(?Elem,?List) - given a list and an element, check if the element is part of the list
% search(a,[a,b,c]). --> yes
% search(X,[a,b,c]). --> X / a; X / b; X / c;
% search(a,[X,b,Y,Z]). --> X / a; Y / a; Z / a;
/**
* The base case is represented by the fact that the element to search (H) corresponds to the head of the list (H).
* Otherwise it (E) must be searched inside the tail (T) in a recursive way.
*/
search(H,[H|_]). 
search(E,[_|T]) :- search(E,T). 

% 1.2 search2(?Elem,?List) - given a list and an element, check if the element has two consecutive occurrences in the list
% search2(a,[b,c,a,a,d,e,a,a,g,h]). --> yes
% search2(X,[b,c,a,a,d,d,e]). --> X / a; X / d;
/**
* The base case is represented by the fact that the element (H) correspond to the first two elements of the list (H,H).
* Otherwise it (E) must be searched inside the tail (T) in a recursive way.
*/
search2(H,[H,H|_]).
search2(E,[_|T]) :- search2(E,T). 

% 1.3 search_two(?Elem,?List) - given a list and an element, check if the element has two occurrences in the list separated by any character
% search_two(a,[b,c,a,d,a,d,e]). --> yes
% search_two(a,[b,c,a,d,a,d,e]). --> X / a; X / d;
% search_two(a,[b,c,a,X,a,Y,e]). --> X / a; Y / a;
/**
* The base case is represented by the fact that the element (H) correspond to the first and the third elements of the list (H,_,H).
* Otherwise it (E) must be searched inside the tail (T) in a recursive way.
*/
search_two(H,[H,_,H|_]). 
search_two(E,[_|T]) :- search_two(E,T). 

% 1.4 search_anytwo(?Elem,?List) - given a list and an element, check if the element has two occurrences in the list
% search_anytwo(a,[b,c,a,a,d,e]). --> yes
% search_anytwo(X,[b,c,a,a,d,e]). --> X / a
% search_anytwo(a,[b,c,X,Y,d,e]). --> X / a; Y / a;
/**
* The base case is represented by the fact that the element (H) correspond to the head of list (H) if is also on the tail (T).
* Otherwise it (E) must be searched inside the tail (T) in a recursive way.
*/
search_anytwo(H,[H|T]) :- search(H,T). 
search_anytwo(E,[_|T]) :- search_anytwo(E,T).


% 2 - Extracting information from a list

% 2.1 size(+List,?Size) - given a list, get its size (the number of element inside the list) 
% size([1,2,3,4],4). --> yes
% size([1,2,3,4],X). --> X / 4
/**
* The base case is represented by the fact that an empty list has a size of zero.
* Otherwise, the size of a list (M) is the size (N) of its tail (T) plus the size of the head (_), which is one.
*/
size([],0). 
size([_|T],M) :- size(T,N), M is N+1. 

% 2.2 size_peano(+List,?Size) - given a list, get its size (the number of element inside the list) in the Peano notation
% size_peano([a,b,c],X). --> X / s(s(s(zero)))
% size_peano(L,s(s(s(zero)))). --> L / [_4621,_4623,_4625]; it is not fully relational, because the elements of the list can be anything
/**
* The base case is represented by the fact that an empty list has a size of zero (0 = zero in the Peano notation).
* Otherwise, the size of a list (M) starts from one, which is the head (s(M)), plus the size of its tail (T).
*/
size_peano([],zero).
size_peano([_|T],s(M)) :- size_peano(T,M). 

% 2.3 sum(+List,?Sum) - given a list of integers, get the sum
% sum([1,2,3],X). --> X / 6
% sum([1,X,3],6). --> halt; it is not fully relational, because the elements of the list must be numeric
/**
* The base case is represented by the fact that an empty list has a sum of zero. 
* Otherwise, the size of a list (M) is the sum (N) of the tail (T), plus the head (H).
*/
sum([],0). 
sum([H|T],M) :- sum(T,N), M is N+H.

% 2.4 average(+List,?Average) - given a list of integers, get the average
% average([3,4,3],A). --> A / 3.3333333333333335
% scan([3,4,3],0,0,A). --> A / 3.3333333333333335
% scan([4,3],1,3,A). --> A / 3.3333333333333335 
% .. the sequence of goals continues
/**
* Before analyzing the base case, it is necessary to change the ariety of the predicate, because at each iteration you have to keep track of the sum and number of elements, which start from zero
* At every iteration the list is progressively "emptied", an empty list means therefore to have defenitive sum and counter.
* If the list isn't empty yet, the counter (C2) must be updated (C+1), also the sum (S2 is S+H), and with those new values a (tail) recursive call is made. 
*/
average(L,A) :- scan(L,0,0,A). 
scan([],C,S,A) :- A is S/C. 
scan([H|T],C,S,A) :- C2 is C+1, S2 is S+H, scan(T,C2,S2,A).

% 2.4 max(+List,?Max) - given a list of integers, get the biggest element
% max([10,20,30,200],M). --> M / 200
/**
* Before analyzing the base case, it is necessary to change the ariety of the predicate, because at each iteration you have to keep track of the temporary biggest value, the first time is the head of the list
* At every iteration the list is progressively "emptied", an empty list means therefore to have defenitive maximum value, so the second and the third argument are the same.
* The next iterations calculate each time the maxValue(N1,N2,X) where X is the biggest value between N1 and N2. And then a (tail) recursive call is made where the new temporary max value is X. 
*/
max([H|T],M) :- max(T,M,H). 
max([],M,M).
max([H|T],M,Tm) :- maxValue(H,Tm,X), max(T,M,X).
maxValue(X,Y,X) :- X>=Y, !.
maxValue(X,Y,Y).


% 3 - Compare lists

% 3.1 same(?List1,?List2) - given two lists, check if they are identical
% same([1,2,3],[1,2,3]). --> yes
% same([1,2,3],X). --> X / [1,2,3]
% same([1,X,3],[1,2,3]) --> X / 2
/**
* The base case is rapresented by the fact that two empty list are identical.
* Otherwise, the head (H) must be the same and then the tail (T) is checked recursively. 
*/
same([],[]). 
same([H|T],[H|T2]) :- same(T,T2). 

% 3.2 all_bigger(+List1,+List2) - given two lists, check if all the elements of the first one are bigger than the second's (considering the index)
% all_bigger([10,20,30,40],[9,19,29,39]). --> yes
% all_bigger([10,X,30,40],[9,19,29,39]). --> halt; it is not fully relational, because the elements of the list must be numeric
/**
* The base case is rapresented by the fact if the two lists have only the head, the first one (E) must be bigger than the second (E2).  
* Otherwise, also all elements of the tail (T) must be bigger of the second (T2).
*/
all_bigger([E],[E2]) :- E>E2. 
all_bigger([H|T],[H2|T2]) :- H>H2, all_bigger(T,T2).

% 3.3 sublist(?List1,?List2) - given two lists, check if the second contains all the elements of the first one
% sublist([1,2],[5,3,2,1]). --> yes
% sublist([1,2],[5,3,2,X]). --> X / 1
% sublist([1,X],[5,3,2,1]). --> X / 5; X / 4; X / 3; X / 2; X / 1;
/**
* The base case is given by the fact that an empty list is always a subset.
* Otherwise, first check if the head (T) of the first list is member of the second list (L), and then check the tail (T) is checked recursively. 
*/
sublist([],_). 
sublist([H|T],L) :- search(H,L), sublist(T,L). 


% 4 - Creating lists 

% 4.1 seq(+N,?List) - given an integer, create a list of the same size of the integer's value composed only by zero 
% seq(4,[0,0,0,0]). --> yes
% seq(4,X). --> X / [0,0,0,0]
% seq(4,[X,0,Y,0]). --> X / 0; Y / 0;
% seq(X,[0,0,0,0]). --> halt; it is not fully relational, because the integer must be numeric
/**
* The base case is rapresented by the fact that a list of size zero is empty. 
* Otherwise, add a zero in the head of the list, decrement the integer at every iteration (N-1) and secursevly call the function on the tail (T) with the new integer (N2). 
*/
seq(0,[]) :- !.
seq(N,[0|T]) :- N2 is N-1, seq(N2,T).

% 4.2 seqR(?N,?List) - given an integer and a list, create a list composed by the descending number's sequence
% seqR(4,[4,3,2,1,0]). --> yes
% seqR(4,X). --> X / [4,3,2,1,0]
% seqR(4,[X,3,Y,1,0]). --> X / 4; Y / 2;
% seqR(X,[4,3,2,1,0]). --> X / 4
/**
* The base case is rapresented by the fact that if the integer is zero, the list contains only a zero.
* Otherwise, the integer (N) is the head of the list, and it must be decremented at every iteration (N-1) and recursevly call the function on the tail (T) with the new integer (N2).  
*/
seqR(0,[0]) :- !.
seqR(N,[N|T]) :- N2 is N-1, seqR(N2,T). 

% 4.3 seqR2(+N,?List) - given an integer and a list, create a list composed by the increasing number's sequence
% seqR2(4,[0,1,2,3,4]). --> yes
% seqR2(4,[0,X,2,3,4]). --> X / 1
% seqR2(4,[0,X,Y,3,4]). --> X / 1; Y / 2;
% seqR(X,[4,3,2,1,0]). --> halt; it is not fully relational, because the integer must be numeric
/**
* The base case is rapresented by the fact that if the integer is zero, the list contains only a zero.
* Otherwise, the integer must be decremented at every iteration (N-1), recursevly call the function on the new list (L2) with the new integer (N2).
* Before proceeding with the recursive call the previous integer must be append. The list (L) is the result of the call last, that appen the integer (N) to the new list (L2).
* The base case of last is is rapresented by the fact that if the starting list is empty, than the new list contains only the element.
* Otherwise, the lists will have the same head, and a recursive call is done on the tails (T, T2).  
*/
seqR2(0,[0]) :- !.
seqR2(N,L) :- N2 is N-1, seqR2(N2,L2), last(L2,N,L).
last([],M,[M]). 
last([H|T],M,[H|T2]) :- last(T,M,T2).


% 5 - Other exercises

% 5.1 inv(+List1,?List2) - given a list, create another list that is the opposite
% inv([1,2,3],[1,2,3]). --> yes
% inv([1,2,3],X). --> X / [1,2,3]
/**
* The base case is rapresented by the fact that the opposite of an empty list is an empty list.
* Otherwise, before do the recursive call using the tail of the list (T) and the new list (L2), the head (H) must be append to the resulting list (L) 
*/
inv([],[]). 
inv([H|T],L) :- inv(T,L2), last(L2,H,L).

% 5.2 double(?List1,?List2) - given a list, create another list that contains the first twice in a row
% double([1,2,3],[1,2,3,1,2,3]). --> yes
% double(X,[1,2,3,1,2,3]). --> X / [1,2,3]
% double([1,2,3],X). --> X / [1,2,3,1,2,3]
/**
* The append predicate takes the starting list (L), the element that must be append (L) and create a list (L2). 
*/
double(L,L2) :- append(L,L,L2).

% 5.3 times(?List1,+N,?List2) - given a list and an integer N, create another list containing N consecutive times the first list
% times([1,2,3],3,[1,2,3,1,2,3,1,2,3]). --> yes
% times([1,2,3],3,X). --> X / [1,2,3,1,2,3,1,2,3]
% times(X,3,[1,2,3,1,2,3,1,2,3]). --> X / [1,2,3] 
/**
* The base case is rapresented by the fact that if the integer is 0, the resulting list is empty.
* Otherwise, at every iteration the integer is decremented (N-1), a recursive call is made passing the starting list (L), the new integer (N2), after the append that results in the final list (L2) is made passing the result of the recursive call (L3)
*/
times(_,0,[]) :- !.
times(L,N,L2) :- N2 is N-1, times(L,N2,L3), append(L,L3,L2).

% 5.4 proj(?ListOfList,?List) - given a list of list, create another list that contains only the first element of every list
% proj([[1,2],[3,4],[5,6]],[1,3,5]). --> yes
% proj([[1,2],[3,4],[5,6]],X). --> X / [1,3,5]
% proj([[1,2],[3,4],[X,6]],[1,3,5]). --> X / 5
/**
* The base case is rapresented by the fact that an empty list of list generate an empty list. 
* Otherwise, the head of the resulting list is the head of the first list (H), and the a recursive call is made with all the others lists (L) and the tail of the resulting list (T).
*/
proj([],[]).
proj([[H|_]|L],[H|T]) :- proj(L,T).
