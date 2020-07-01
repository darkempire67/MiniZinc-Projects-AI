% Use this editor as a MiniZinc scratch book
% NIne nine nie 
% Arrange the given digits to make three 3 digit numbers that add up to 999.
include "alldifferent.mzn";

set of int: Domain = 1..9;

array[1..3,1..3] of var Domain: puzzle;


constraint
    forall(i in 1..3)( alldifferent(j in 1..3)( puzzle[i,j] ))
    /\
    forall(j in 1..3)( alldifferent(i in 1..3)( puzzle[i,j] ))
    /\
    forall(i,j in 1..1)
        ( alldifferent(p,q in 1..3)( puzzle[3*(i-1)+p, 3*(j-1)+q] ));

constraint ((puzzle[1,1]*100) + (puzzle[1,2]*10) + puzzle[1,3] )+
            ((puzzle[2,1]*100) +(puzzle[2,2]*10) +puzzle[2,3] )+
            ((puzzle[3,1]*100) + (puzzle[3,2]*10) +puzzle[3,3])
            ==999;

            
solve satisfy;
output[ "*************************\nThis is the  999 puzzles :\nArrange the given digits to make three 3 digit numbers that add up to 999 \n***********************\n"] ++
        [ show( puzzle[i,j]) ++
         if j ==3 then 
             if i mod 3=0 /\ i < 3 then " \n\n" else "\n" endif
         else
             if j mod 1= 0 then " " else " " endif
         endif
         | i,j in 1..3]++["----- + \n9 9 9"];