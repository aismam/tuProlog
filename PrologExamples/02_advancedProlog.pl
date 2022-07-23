% 1 - Drop nodes

% 1.1 drop_any(?Elem,+List,?OutList) - given a list and an element, create a list where any occurrences of the element have been dropped, the solutions are presented one by one
% drop_any(10,[10,20,10,30,10],[20,10,30,10]). --> yes
% drop_any(10,[10,20,10,30,10],X). --> X / [20,10,30,10]
% drop_any(X,[10,20,10,30,10],[20,10,30,10]). --> X / 10
/**
* The base case is rapresented by the fact that the element is the head of the list (H). 
* Ohterwise, the new list will have the same head of the original one, because it isn't the same as the element (E), and a recursive call is made using the tail of the first list (T) and the tail of the output list (T2). 
*/
drop_any(H,[H|T],T).
drop_any(E,[H|T],[H|T2]) :- drop_any(E,T,T2).

% 1.2 drop_first(?Elem,+List,?OutList) - given a list and an element, create a list where the first occurrence of the element has been dropped
% drop_first(10,[10,20,10,30,10],[20,10,30,10]). --> yes
% drop_first(10,[10,20,10,30,10],X). --> X / [20,10,30,10]
% drop_first(X,[10,20,10,30,10],[20,10,30,10]). --> X / 10
/**
* The logic behind is the same as before (drop_any), but when an occurence of the element is found, the trees containing all the possible ways just stops. This can be achieved using cut (!).
*/
drop_first(H,[H|T],T) :- !. 
drop_first(E,[H|T],[H|T2]) :- drop_first(E,T,T2).

% 1.3 drop_last(?Elem,+List,?OutList) - given a list and an element, create a list where the last occurrence of the element has been dropped
% drop_last(10,[10,20,10,30,10],[10,20,10,30]). --> yes
% drop_last(10,[10,20,10,30,10],X). --> X / [10,20,10,30]
% drop_last(X,[10,20,10,30,10],[10,20,10,30]). --> X / 10
/**
* The base case is rapresented by the fact that the element isn's inside the tail of the list (T), and it is the same of just the head (H), so the output list will be the tail (T).
* Otherwise, if the element (E) isn't the head of the list (H), the output list will have the same head, and a tail (L) where the last occurence of the element has been dropped from the original (T), so a recursive call is made.  
* The base case of the not_in predicate is rapresented by the fact that if the list is empty, stays empty regardless of the element's value. 
* Otherwise, at every iteration the diversity of the head of the list (H) and the element (E) is checked, and than a recursive call is made in the tail (T). 
*/
drop_last(H,[H|T],T) :- not_in(H,T). 
drop_last(E,[H|T],[H|L]) :- drop_last(E,T,L). 
not_in(_,[]).
not_in(E,[H|T]) :- E\=H, not_in(E,T).

% 1.4 drop_all(?Elem,+List,?OutList) - given a list and an element, create a list where all the occurrences of the element have been dropped (union of drop_any results)
% drop_all(10,[10,20,10,30,10],[20,30]). --> yes
% drop_last(10,[10,20,10,30,10],X). --> X / [20,30]
% drop_last(X,[10,20,10,30,10],[20,30]). --> X / 10
/**
* The base case is rapresented by the fact that if the input list is empty, so will be the output one.
* If the element (E) is the same as the head of the input list (H), since those are composed terms this is checked using copy_term, a recursive call is made using only the tail (T) of the input list.  
* Otherwise, the head of the ouput list remains the same (H), so a recursive call is made using the tail (T) of the input list and the tail (T2) of the output list. 
*/
drop_all(_,[],[]).
drop_all(E,[H|T],L) :- copy_term(E,H), drop_all(E,T,L), !.
drop_all(E,[H|T],[H|T2]):- drop_all(E,T,T2).


%2 - Graphs operations

% 2.1 from_list(?List,?Graph) - given a list, create a graph where the nodes are linearly connected
% from_list([10,20,30],[e(10,20),e(20,30)]). --> yes
% from_list([10,20,30],X). --> X / [e(10,20),e(20,30)]
% from_list(X,[e(10,20),e(20,30)]). --> X / [10,20,30]
% from_list([10,20,30],[e(10,20),e(20,X)]). --> X / 30
/**
* The base case is rapresented by the fact that if the list has only one element, the graph will be empty.
* Otherwise, for each couple of element in the head of the list (H1,H2) a corresponding node is added to the graph (e(H1,H2)). Then the second element (H2) and the rest of the list (T) will be used to make a recursive call.
*/
from_list([_],[]). 
from_list([H1,H2|T],[e(H1,H2)|T2]) :- from_list([H2|T],T2). 

% 2.1 from_circ_list(?List,?Graph) - given a list, create a graph where the nodes are circularly connected
% from_circ_list([10,20,30],[e(10,20),e(20,30),e(30,10)]). --> yes
% from_circ_list([10,20,30],[e(10,20),e(20,30),e(30,10)]). --> X / [e(10,20),e(20,30),e(30,10)] 
% from_circ_list(X,[e(10,20),e(20,30),e(30,10)]). --> X / [10,20,30]
% from_circ_list([10,20,30],[e(10,20),e(20,30),e(30,X)]). --> X / 10
/**
* Before analyzing the base case, the predicate must be transformed, the ariety must be three in order to keep track of the original head (H). 
* The base case is rapresented by the fact that the list has only one element (E), in this case the graph will contains only the node that connect the original head (H) and the element.
* Otherwise, for each couple of element in the head of the list (H1,H2) a corresponding node is added to the graph (e(H1,H2)). Then the second element (H2) and the rest of the list (T) will be used to make a recursive call.
*/
from_circ_list([H|T],G) :- from_circ_list([H|T],H,G).
from_circ_list([E],H,[e(E,H)]).
from_circ_list([H1,H2|T],H,[e(H1,H2)|T2]) :- from_circ_list([H2|T],H,T2).

% 2.3 drop_node(+Graph,+Node,?OutGraph) - given a graph and a node, create a graph where the node has been dropped
% drop_node([e(1,2),e(1,3),e(2,3)],1,[e(2,3)]). --> yes 
% drop_node([e(1,2),e(1,3),e(2,3)],1,X). --> X / [e(2,3)]
/**
* The operation is done in two steps. In the first one all the connection that goes out from the node (N) are dropped, generating a new graph (G2).
* Starting from this graph (G2), all the connection that goes in to the node (N) are dropped, generating the final graph (G3).
*/ 
drop_node(G,N,G3) :- drop_all(e(N,_),G,G2), drop_all(e(_,N),G2,G3).

% 2.4 reaching(+Graph,+Node,?List) - given a graph and a node, create a list containing all the nodes that can be reached from the starting node with only one step
% reaching([e(1,2),e(1,3),e(2,3)],1,[2,3]). --> yes
% reaching([e(1,2),e(1,3),e(2,3)],1,L). --> L / [2,3]
/**
* The logic behind the predicate is the following: the list (L) will contains all the couples of nodes where the starting node (N) is in the first position and the findall must resolve the node that can be reached (X).    
*/
reaching(G,N,L) :- findall(X,member(e(N,X),G),L).

%2.5 any_path(+Graph,?Node1,?Node2,?ListPath) - given a graph and two nodes, create a list containing all the possible path that connects the two nodes
% any_path([e(1,2),e(1,3),e(2,3)],1,3,[e(1,2),e(2,3)]). --> yes
% any_path([e(1,2),e(1,3),e(2,3)],1,3,X). --> X / [e(1,2),e(2,3)]
% any_path([e(1,2),e(1,3),e(2,3)],X,Y,[e(1,2),e(2,3)]). --> X / 1; Y / 3
/**
* The base case is rapresented by the fact that the two nodes are the first element of the graph (N1,N2), so they are added to the list. 
* Otherwise, if the graph as the first node passed (N1) and another (N3) on the head they are added on the list and a recursive call is done to check the connection between the new node (N3) and the second node passed (N2). 
* The last case is rapresented by the fact that both node passed aren't the head of the list, so they must be searched in tail of the graph (T), using the tail of the list as an ouput (T2). 
*/
any_path([e(N1,N2)|_],N1,N2,[e(N1,N2)]). 
any_path([e(N1,N3)|T],N1,N2,[e(N1,N3)|T2]) :- any_path(T,N3,N2,T2).
any_path([_|T],N1,N2,T2) :- any_path(T,N1,N2,T2).

% 2.6 all_reaching(+Graph,+Node,?List) - given a graph and a node, create a list containing all the node that can be reached starting from the passed node
% all_reaching([e(1,2),e(2,3),e(3,5)],1,[2,3,5]). --> yes
% all_reaching([e(1,2),e(2,3),e(3,5)],1,X). --> X / [2,3,5]
/**
* The logic behind the predicate is the following: the list (L) will contains all the node resulting from the any_path query where the starting node (N) is in the first position and the reaching node (N2) is the result.    
*/
all_reaching(G,N,L) :- findall(N2,any_path(G,N,N2,_),L).
