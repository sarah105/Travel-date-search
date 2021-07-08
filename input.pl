cities([["Alexandria"	,31.2           ,29.95],
        ["Aswan"	,24.0875        ,32.8989],
        ["Cairo"	,30.05          ,31.25],
        ["Chicago"	,41.8373        ,-87.6862],
        ["Edinburgh"	,55.9483        ,-3.2191],
        ["Liverpool"	,53.416         ,-2.918],
        ["London"	,51.5	        ,-0.1167],
        ["Lyon"	        ,45.77	        ,4.83],
        ["Manchester"	,53.5004	,-2.248],
        ["Miami"	,25.7839	,-80.2102],
        ["Milan"	,45.47	        ,9.205],
        ["New York"	,40.6943	,-73.9249],
        ["Nice"	        ,43.715	        ,7.265],
        ["Paris"	,48.8667	,2.3333],
        ["Port Said"	,31.26	        ,32.29],
        ["Rome"	        ,41.896	        ,12.4833],
        ["San Francisco",37.7562	,-122.443],
        ["Shanghai"	,31.2165	,121.4365],
        ["Tokyo"	,35.685	        ,139.7514],
        ["Venice"	,45.4387	,12.335]]).

% flightsTimeTable("Aswan","Port Said",[[7:05/8:18/"MS023"/[tue, thu,
% fri]]]).
% flightsTimetable("Cairo","Alexandria",[[13:00/13:45/"MS008"/[sun, mon,
% wed]],[20:15/21:00/"MS009"/[thu, fri]]]).
/*flightsTimetable("Cairo","Aswan",[[8:00 / 9:20 / "MS010"/ [sun, wed]],[17:15/ 18:35/"MS011"/[sat, tue, thu]]]).
flightsTimetable("London","Cairo",[[20:00 / 0:40 / "BA144" / [tue, thu]]]).
*/


/*flightsTimetable("Alexandria","Aswan",[[11:00/12:15/"MS005"/[mon, tue, wed]],[15:15/16:30/"MS004"/[sat, fri]]]).
flightsTimetable("Aswan","Cairo",[[10:20/11:40/"MS022"/[sat, sun, mon, wed]]]).
flightsTimetable("Aswan","Port Said",[[7:05/8:18/"MS023"/[tue, thu, fri]]]).*/

flightsTimetable("Alexandria","Aswan",[[11:00/12:15/"MS005"/[mon, tue, wed]],[15:15/16:30/"MS004"/[sat, fri]]]).
flightsTimetable("Alexandria","Cairo",[[9:15/10:00/"MS003"/[mon, tue, wed]],[12:30/13:15/"MS001"/[sat, sun]],[17:00/17:45/"MS002"/[sat,mon, thu, fri]]]).
flightsTimetable("Alexandria","London",[[19:30/0:32/"MS006"/[sat, sun, thu, fri]]]).
flightsTimetable("Alexandria","New York",[[2:00/15:14/"MS007"/[sun, tue, thu]]]).
flightsTimetable("Aswan","Cairo",[[10:20/11:40/"MS022"/[sat, sun, mon, wed]]]).
flightsTimetable("Aswan","Port Said",[[7:05/8:18/"MS023"/[tue, thu, fri]]]).
flightsTimetable("Cairo","Alexandria",[[13:00/13:45/"MS008"/[sun, mon, wed]],[20:15/21:00/"MS009"/[thu, fri]]]).
flightsTimetable("Cairo","Aswan",[[8:00/9:20/"MS010"/[sun, wed]],[17:15/18:35/"MS011"/[sat, tue, thu]]]).
flightsTimetable("Cairo","London",[[10:00/15:10/"MS014"/[sun, mon, tue]],[15:15/20:25/"MS015"/[sat, wed, thu]]]).
flightsTimetable("Cairo","New York",[[3:00/15:05/"MS016"/[sat, sun, wed]],[19:30/7:35/"MS017"/[mon, tue, fri]]]).
flightsTimetable("Cairo","Paris",[[2:00/6:55/"MS018"/[wed, thu, fri]],[5:00/9:55/"MS019"/[sat, mon]]]).


