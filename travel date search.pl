weak([sat,sun,mon,tue,wed,thu,fri]).
days(["Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"]).

%Input Function , which User Deal with
print_solution(travel(From,To,Deuration)):-
    cities(Cities),
    member([From|_],Cities),%check if city exist
    member([To|_],Cities),
    travel(From,To,Deuration,Cities,_),!.
print_solution(_):-
    write("you enter something wrong"),!.

%Return a valid solution if exist
travel(From,To,Z,Cities,List):-
    getDays(Z,Days),%this return days that he want to trevel on
    h(From,To,H),%huristic function return
    %start point(open list) ,goal,days to check flights , cities , close,Res,last travel
    travel([[[From,From,_],null,H,0,H]],To,Days,Cities,[],Res,Last),
    length(Res,Len),
    Len > 0,
    getSolution(Res,Last,[Last],[_|List]),
    printSolution(List,1),!.

% if above fun fail this fun will increase the duraion time ond day before and after the actuall duraion time and search agin
travel(From,To,[Day1,Day2],Cities,List):-
    days(D),
    nth0(Index1,D,Day1),
    NewIndex1 is (Index1 - 1 + 7) mod 7,
    nth0(NewIndex1,D,NewDay1),
    nth0(Index2,D,Day2),
    NewIndex2 is (Index2 + 1) mod 7,
    nth0(NewIndex2,D,NewDay2),
    getDays([NewDay1,NewDay2],Days),
    h(From,To,H),
    travel([[[From,From,_],null,H,0,H]],To,Days,Cities,[],Res,Last),
    length(Res,Len),
    Len > 0,
    getSolution(Res,Last,[Last],[_|List]),
    printSolution(List,1),!.

travel(_,_,_,_,[]):-
    write("there isn't any suitable fllight").

%Check if state is the goal
goal([[_,Start,_],_,_,_,_],_,Start).
    /*length(Days,Len),
    Minutes is Len * 24 * 60,
    G =< Minutes.*/

%paramters : opened,goal,days,cities,closed,Res,Last
travel([],_,_,_,_,[],[]).%there isn't solution

% The Start of A* Algorithm
%Check the min if it is the goal return it
%reach to goal(destination city)
travel(Opened,To,Days,_,Closed,Closed,[[Start,End,In],Parent,F,G,H]):-
    gitMin(Opened,[[Start,End,In],Parent,F,G,H],_),
    goal([[Start,End,In],Parent,F,G,H],Days,To).

%continue searching if the above faild
travel(Opened,To,Days,Cities,Closed,Res,Last):-
    gitMin(Opened,Min,TemOpened),%opened list , Min , opend list after remove min element
    gitAllChildren(Min,To,Opened,Closed,Days,Children),%get All avalied children of Min
    append(TemOpened,Children,NewOpened),%append children  to open list and get new list
    travel(NewOpened,To,Days,Cities,[Min|Closed],Res,Last).

gitAllChildren([[Start,End,In],Parent,F,G,H],Goal,Opened,Closed,Days,Children):-
    getAllFlights(End,Days,Opened,Closed,Flights),
    getAllChildren(Flights,Goal,[[Start,End,In],Parent,F,G,H],[],Children),!.

%paramters : list of flights , goal,parent,tem,Res
%Calculate heuristic, g and f functions for each child
getAllChildren([],_,_,Tem,Tem).
getAllChildren([[Start1,End1,In1]|Tail],Goal,[[Start2,End2,In2],Parent,F2,G2,H2],Tem,Res):-
    h(End1,Goal,H),
    g(In2,In1,G2,NG),
    f(H,NG,F),
    append(Tem,[[[Start1,End1,In1],[Start2,End2,In2],F,NG,H]],NewTem),
    getAllChildren(Tail,Goal,[[Start2,End2,In2],Parent,F2,G2,H2],NewTem,Res).

%paramters : opened list , Min , New opend list
%git min cost(time) from list and remove it form the list and retun a new list
gitMin([H],H,[]):-!.
gitMin([H|T],Min,NewList):-
    gitMinFun(H,T,Min),
    remove([H|T],Min,[],NewList),!.

%git min
gitMinFun(Min,[],Min).
gitMinFun([[_,_,_],_,F1,_,_],[[[Start2,End2,In2],Parent2,F2,G2,H2]|T],Min):-
    F1 > F2,
    gitMinFun([[Start2,End2,In2],Parent2,F2,G2,H2],T,Min),!.
gitMinFun(Tem,[_|T],Min):-
    gitMinFun(Tem,T,Min).

%remove element from list
remove([],_,Tem,Tem):-!.
remove([H|T],H,Tem,Res):-
    append(Tem,T,Res),!.
remove([H|T],Element,Tem,Res):-
    append(Tem,[H],NewTem),
    remove(T,Element,NewTem,Res).

%calculate heuristic (distance)
h(City1,City2,Res):-
    loc(City1,X1,Y1),
    loc(City2,X2,Y2),
    pow( X1 - X2 , 2 , NX),
    pow( Y1 - Y2 , 2 , NY),
    Res is sqrt( NX + NY).

f(H,G,Res):-
    Res is H + G.

%calculate time
g(_, H3:M3/H4:M4/_/_ , 0 , NG):-
    convertToMinutes(H3,M3,Time3),
    convertToMinutes(H4,M4,Time4),
    NG is (Time4 - Time3 + 24 * 60) mod (24 * 60),!.

g(H1:M1/H2:M2/_/Day1 , H3:M3/H4:M4/_/Day2 , G , NG):-
    convertToMinutes(H1,M1,Time1),
    convertToMinutes(H2,M2,Time2),
    Time2 > Time1,
    getG(H2,M2,H3,M3,H4,M4,Day1,Day2,Res),
    NG is G + Res,!.

g(_:_/H2:M2/_/Day1 , H3:M3/H4:M4/_/Day2 , G , NG):-
    weak(Weak),
    nth0(Index,Weak,Day1),
    Index2 is (Index + 1) mod 7,
    nth0(Index2,Weak,NewDay1),
    getG(H2,M2,H3,M3,H4,M4,NewDay1,Day2,Res),
    NG is G + Res,!.

%return result of g fun when g fun call it
getG(H2,M2,H3,M3,H4,M4,Day1,Day1,Res):-
    convertToMinutes(H2,M2,Time2),
    convertToMinutes(H3,M3,Time3),
    convertToMinutes(H4,M4,Time4),
    Time2 > Time3,
    Res is 6 * 24 * 60 + (24*60-Time2) + Time4,!.

getG(H2,M2,H3,M3,H4,M4,Day1,Day2,Res):-
    convertToMinutes(H2,M2,Time2),
    convertToMinutes(H3,M3,Time3),
    convertToMinutes(H4,M4,Time4),
    weak(Weaks),
    nth0(Index1,Weaks,Day1),
    nth0(Index2,Weaks,Day2),
    NumOfDay is (Index2 - Index1 + 7) mod 7,
    Res is NumOfDay * 24 * 60 + (Time4 - Time3 + 24 *60) mod (24*60) + (Time3 -Time2+24*60) mod (24*60) ,!.
%Just print solution
printSolution([],_).
printSolution([[[From,To,H1:M1/H2:M2/FlightNum/Day],_,_,_,_]|T],Count):-
    nl,write("Step "),
    write(Count),
    write(" : use flight "),
    write(FlightNum),
    write(" from "),
    write(From),
    write(" to "),
    write(To),
    write(". Departure time "),
    write(H1:M1),
    write(" and arrival time "),
    write(H2:M2),
    write(" in day "),
    write(Day),
    write("."),nl,
    NewCount is Count + 1,
    printSolution(T,NewCount).

%gets closed list and last travel and return solution
getSolution(_,[_,null,_,_,_],Tem,Tem):-!.
getSolution(List,[_,Parent,_,_,_],Tem,Res):-
    member([Parent,Grand,F,G,H],List),
    append([[Parent,Grand,F,G,H]],Tem,NewTem),
    getSolution(List,[Parent,Grand,F,G,H],NewTem,Res).

%retun location of city (x ,y)
loc(C,X,Y):-
    cities(City),
    member([C,X,Y],City).

%returns days between start and end time
getDays([Start,End],Days):-
    days(D),
    weak(Weak),
    nth0(Index1,D,Start),
    nth0(Index2,D,End),
    getDays(Index1,Index2,Weak,Days),!.

getDays(Index1,Index1,Weak,[Days]):-
    nth0(Index1,Weak,Days),!.
getDays(Index1,Index2,Weak,[Day|Days]):-
    nth0(Index1,Weak,Day),
    NewIndex1 is (Index1 + 1 ) mod 7,
    getDays(NewIndex1,Index2,Weak,Days).

% getAllFlights(End,Days,Opened,Closed,Flights),
getAllFlights(Start,Days,Opened,Closed,NewRes):-
    findall(Flights,getFlights(Start,Days,Opened,Closed,Flights),Res),
    fllaten(Res,[],NewRes).

getFlights(Start,Days,Opened,Closed,Res):-
    flightsTimetable(Start,End,Flights),
    getFlights(Start,End,Flights,Days,Opened,Closed,Res).

getFlights(_,_,[],_,_,_,[]):-!.

getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/[Day|Days]]|T],ADays,Opened,Closed,[[Start,End,H1:M1/H2:M2/FlightNum/Day]|Res]):-
    member(Day,ADays),
    not(member([[Start,End,H1:M1/H2:M2/FlightNum/Day]|_],Opened)),
    not(member([[Start,End,H1:M1/H2:M2/FlightNum/Day]|_],Closed)),
    convertToMinutes(H1,M1,Time1),
    convertToMinutes(H2,M2,Time2),
    Time1 < Time2 ,%sure return in the same day
    getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/Days]|T],ADays,Opened,Closed,Res),!.

%if flight return in second day check this day in limit
getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/[Day|Days]]|T],ADays,Opened,Closed,[[Start,End,H1:M1/H2:M2/FlightNum/Day]|Res]):-
    member(Day,ADays),
    not(member([[End|_]|_],Opened)),
    not(member([[End|_]|_],Closed)),
    weak(Weak),
    nth0(Index,Weak,Day),
    Index2 is (Index + 1) mod 7 ,
    nth0(Index2,Weak,Day2),
    member(Day2,ADays),
    getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/Days]|T],ADays,Opened,Closed,Res),!.

%this day is out of limit
getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/[_|Days]]|T],ADays,Opened,Closed,Res):-
    getFlights(Start,End,[[H1:M1/H2:M2/FlightNum/Days]|T],ADays,Opened,Closed,Res),!.

getFlights(Start,End,[_|T],Days,Opened,Closed,Res):-
    getFlights(Start,End,T,Days,Opened,Closed,Res).

fllaten([],Tem,Tem).
fllaten([[H|T]|T2],Tem,Res):-
    append(Tem,[H],NewTem),
    fllaten([T|T2],NewTem,Res),!.
fllaten([_|T],Tem,Res):-
    fllaten(T,Tem,Res).

convertToMinutes(H,M,Res):-
    Res is (H * 60) + M.
























