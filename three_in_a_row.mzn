include "alldifferent.mzn";

% Objective / Rules
%-     Fill the grid with Blue and White squares.
%-     A 3-In-A-Row of the same colour is not allowed.
%-     Each row and column has an equal number of Blue and White squares.

 % ************************************************************************
 % ===>  To represent this puzzle Blue = 1 and White = 0;
% ************************************************************************
%  1 0 1 1 0 0
%  0 1 1 0 1 0
%  0 1 0 1 0 1
%  1 0 0 1 0 1
%  1 0 1 0 1 0
%  0 1 0 0 1 1
%  ------------- 
int :n =6;
set of int :Domain=0..1;
array[1..n,1..n] of var Domain:grid;

% **********************************************************************
% For all rows and columns if two squares are blue the third must be white "0".

 % rows 
 constraint forall( i in 1..n, j in 1..n-2) (grid[i,j]=1 /\grid[i,j+1]=1 -> grid[i,j+2]=0);
 % columns 
 constraint forall( i in 1..n-2, j in 1..n) (grid[i,j]=1 /\grid[i+1,j]=1 -> grid[i+2,j]=0);
 % **********************************************************************
 
 % the sums must be hald the number of elements in that row
 constraint forall(j in 1..n)( 3=sum(i in 1..n)( grid[i,j] ))
 /\
     forall(i in 1..n)( 3=sum(j in 1..n)( grid[i,j] ));

% *******************************************************
%   These squares are reserved and cannot be changed.
 
 constraint grid[5,5]=1;
 constraint grid[3,6]=1;
 
  constraint grid[3,3]=0;
    
  constraint grid[4,2]=0;
    constraint grid[4,3]=0;

  constraint grid[5,2]=0;
  
    constraint grid[6,3]=0;
  constraint grid[6,4]=0;
  % end reserved squares
% ****************************************************


solve satisfy;
output[ "*************************************\n This is the 3 in a row puzzle\n Each row and column has an equal number of '0's and '1's. : \n***********************************\n"] ++ % [ show(puzzle[1,i])| i in 1..7  ]++ ["\n"]++
        [ show( grid[i,j]) ++
         if j ==6 then 
             if i mod 6=0 /\ i < 6 then " \n\n" else "\n" endif
         else
             if j mod 1= 0 then " " else " " endif
         endif
         | i,j in 1..6]++["------------- \n"];