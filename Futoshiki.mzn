include "alldifferent.mzn";
/* 
https://www.brainbashers.com/showfutoshiki.asp?date=1115&size=4&diff=1
Objective / Rules
- Complete the grid such that every row and column contains the numbers 1 to the size of the grid.
- The arrows on the grid are less-than and greater-than signs.
      e.g. 1 < 4, 3 < 5, 2 > 1.
      
      */
int :n =4;
set of int :Domain=1..4;
array[1..n,1..n] of var Domain:puzzle;

constraint
    forall(i in 1..4)( alldifferent(j in 1..4)( puzzle[i,j] ))
    /\
    forall(j in 1..4)( alldifferent(i in 1..4)( puzzle[i,j] ))
    ;
    %must be 2 in the grid
constraint puzzle[2,2]=2;
constraint puzzle[4,1]=3;


% constraints on ceratain squares are greater or less than the neighbor
constraint puzzle[3,1]> puzzle[4,1];

constraint puzzle[4,1]> puzzle[4,2];
constraint puzzle[4,3]< puzzle[4,4];

solve satisfy;
output[ "*************************\nThis is the  Futoshiki puzzle :\n Complete the grid such that every row and column contains the numbers 1 to the size of the grid. \n***********************\n"] ++
        [ show( puzzle[i,j]) ++
         if j ==4 then 
             if i mod 4=0 /\ i < 4 then " \n\n" else "\n" endif
         else
             if j mod 1= 0 then " " else " " endif
         endif
         | i,j in 1..4]++["----- "];