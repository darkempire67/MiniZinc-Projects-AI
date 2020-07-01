include "alldifferent.mzn";
include "globals.mzn";

set of int: Domain= 1..7;

array[1..7,1..7] of var Domain: puzzle;


constraint
    forall(i in 1..7)( alldifferent(j in 1..7)( puzzle[i,j] ))
    /\
    forall(j in 1..7)( alldifferent(i in 1..7)( puzzle[i,j] ));
    
%  https://www.brainbashers.com/showneighbours.asp?date=1101&size=9&diff=1
%    All neighbours will be under here-->
%    from top to bottom
% 

constraint abs(puzzle[1,1] - puzzle[1,2] )  ==1;
constraint abs(puzzle[1,4] - puzzle[1,5] )  ==1;
constraint abs(puzzle[1,6] - puzzle[1,7] )  ==1;

constraint abs(puzzle[2,1] - puzzle[3,1] )  ==1;
constraint abs(puzzle[2,2] - puzzle[1,2] )  ==1;
constraint abs(puzzle[2,2] - puzzle[2,3] )  ==1;
constraint abs(puzzle[2,2] - puzzle[3,2] )  ==1;
constraint abs(puzzle[2,4] - puzzle[1,4] )  ==1;
constraint abs(puzzle[2,7] - puzzle[1,7] )  ==1;

constraint abs(puzzle[3,5] - puzzle[3,6] )  ==1;
constraint abs(puzzle[3,5] - puzzle[4,5] )  ==1;
constraint abs(puzzle[3,6] - puzzle[3,7] )  ==1;
constraint abs(puzzle[3,7] - puzzle[4,7] )  ==1;

constraint abs(puzzle[4,2] - puzzle[4,3] )  ==1;
constraint abs(puzzle[4,2] - puzzle[5,2] )  ==1;
constraint abs(puzzle[4,3] - puzzle[5,3] )  ==1;
constraint abs(puzzle[4,4] - puzzle[4,5] )  ==1;
constraint abs(puzzle[4,5] - puzzle[5,5] )  ==1;

constraint abs(puzzle[5,2] - puzzle[5,3] )  ==1;
constraint abs(puzzle[5,2] - puzzle[6,2] )  ==1;
constraint abs(puzzle[5,4] - puzzle[6,4] )  ==1;

constraint abs(puzzle[6,1] - puzzle[6,2] )  ==1;
constraint abs(puzzle[6,3] - puzzle[6,4] )  ==1;
constraint abs(puzzle[6,5] - puzzle[7,5] )  ==1;
constraint abs(puzzle[6,6] - puzzle[7,6] )  ==1;
constraint abs(puzzle[6,7] - puzzle[7,7] )  ==1;

constraint puzzle[4,6] ==3;
constraint puzzle[5,6] ==1;
constraint puzzle[5,7] ==5;



output[ "*************************\nThis is the  Daily Neighbours puzzles :\n \n***********************\n"] ++ % [ show(puzzle[1,i])| i in 1..7  ]++ ["\n"]++
        [ show( puzzle[i,j]) ++
         if j ==7then 
             if i mod 7=0 /\ i < 7 then " \n\n" else "\n" endif
         else
             if j mod 1= 0 then " " else " " endif
         endif
         | i,j in 1..7]++["------------- \n"];