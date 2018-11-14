param m;			#max allowable number of stations
param tasks;			#total number of tasks

set S:= 1..m;			#set of stations
set T:= 1..tasks;		#set of Tasks
set P{T};			#set of Predecessor Tasks

param d{T};			#Task Duration
param CT;			#Required Cycle Time
param c{s in S}:=(tasks+1)^(s);	#"cost" associated with a station: encourages the use of lesser number of stations
param num:= sum{t in T}(d[t]);	#numerator for efficiency calculation

var x{T,S} binary;		#a task is/isn't assigned to a station
var Efficiency;			
var Percent_Idle_Time;

minimize Stations: sum{t in T, s in S}(c[s]*x[t,s]);
s.t. Assignment{t in T}: sum{s in S}(x[t,s]) = 1;
s.t. Sequence{s in 1..m-1,t2 in T, t1 in P[t2]}: x[t2,s] <= sum{s1 in 1..s}(x[t1,s1]);
s.t. CycleTime{s in S}: sum{t in T}(d[t]*x[t,s]) <= CT;
