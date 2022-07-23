% drop_zero(?List,?List)
% Input: List of elements
% Output: list of elements that is the input list without occurrences of 0
% drop_zero([10,0,20,0,30,40,0,50],[10,20,30,40,50]).  --> yes
% drop_zero([a,0,20,b,30,40,0,50],[a,20,b,30,40,50]).  --> yes
% drop_zero([a,0,b,2,0,c,0,a],X).  --> X/[a,b,2,c,d]
drop_zero([],[]).
drop_zero([0|T], R) :- drop_zero(T,R), !.
drop_zero([H|T], [H|R]) :- drop_zero(T,R).

% index(?List,?Element,?Element) 
% Input: List of elements, element contained in the list
% Output: Index of the input element
% index([a,b,55,d],55,2). --> yes
% index([p,w,y,d,51,46,q,32], q, X). --> X/6
% index([z,99,c,62,t,w,59], X, 5). --> X/w
index([E|_],E,0) :- !.
index([H|T], E, R) :- index(T,E,L), R is L+1.


% iterate(?Element)
% Input: nothing
% Output: 0,1,2,3,4,... that is, the first time it returns 0, then 1, then 2 ... infinite
% remember that prolog goals can have multiple solutions
% iterate(X). --> X/0 --> next --> X/1 --> next --> X/2 --> next --> X/3 ...
iterate(0).
iterate(X) :- iterate(R), X is R+1.
 
% rotate(?List,?List)
% Input: List of elements
% Output: List that move the first element of the input list to the last position
% rotate([a,e,g,s,w],[e,g,s,w,a]).
% rotate([t,13,g,41],X). --> X/[13,g,41,t]
% To create this rule we need to append an element to a list, to do this we can use append/3, otherwise we can make our own implementation
% app(?List,?List,?List).
% Input: List of elements
% Input: List of elements
% Output: List that is the concatenation of first list with second one
% append([a,b,c],[d,e,f],[a,b,c,d,e,f]). --> yes
% append([a,b,c],[1,2,3], X). --> X/[a,b,c,1,2,3]
app([],[],[]).
app([],L,L).
app([H|T], L, [H|R]) :- app(T,L,R). 
rotate([],[]).
rotate([H|T], R) :- app(T,[H],R).

% take(?List,?Element,?Output) 
% Input: List of elements, numeric element
% Output: List that contain first N element of the input list
% take([a,b,c,d],2,[a,b]). --> yes
% take([a,b,1,2,c,3],3,X). --> X/[1,b,1]
take(_,0,[]) :- !.
take([H|T], N, [H|R]) :- M is N-1, take(T,M, R).

% takeLast(?List,?Element,?List) 
% Input: List and a number
% Output: List that contain last N elements 
% takeLast([a,b,c,d],2,X). --> X/[c,d]
% To make this rule we need to define other 3 rules:
% lastElem:from a list retrieve the last element
% lastElem([a,b,c,d],X). --> X/d
% removeLast: from a list retrieve a list without the last element
% removeLast([a,b,c,d],X). --> X/[a,b,c]
% inv: from a list retrieve the inverted list
% inv([a,b,c,d],X). --> X/[d,c,b,a]

takeLast(L,N,Res) :- take_inv(L,N,[E|R]), inv([E|R], Res).
take_inv(_ ,0, []).
take_inv(L,N, [E|R]) :- M is N-1, lastElem(L,E), removeLast(L,L2), take_inv(L2,M,R).

lastElem([E],E).
lastElem([H|T], R) :- lastElem(T,R).

removeLast([X|Xs],Ys) :- removeLast_prev(Xs, Ys, X).
removeLast_prev([],[],_).
removeLast_prev([X|Xs], [X1|Ys] ,X1) :- removeLast_prev(Xs,Ys,X).

inv([],[]).
inv([H|T], L) :- inv(T, R), append(R,[H],L).
