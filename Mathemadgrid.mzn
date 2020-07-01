%  daily mathematics
include "alldifferent.mzn";
/*

https://www.brainbashers.com/showmathemagrid.asp
Objective / Rules
- Complete the grid using all of the digits 1 to 9.
- When completed all of the sums must be correct.
- The sums are solved strictly left to right, up to down.
- The normal order of mathematical operations is ignored.
- For example 2 + 5 x 9 is calculated as (2 + 5) x 9 = 63.
- There are no ÷ 1 in the puzzle.
- There are no x 1 in the puzzle (although there might be 1 x).
- At no point will any calculation go below zero, or fractional.
*/
int: n=3 ; 
set of int : Domain= 1..9;
array[1..9] of var Domain:grid;
constraint alldifferent(grid);
            % rows
constraint  (grid[1] - grid[2]) *  grid[3]== 14 /\
             (grid[4] + grid[5]) +  grid[6]== 16 /\
             (grid[7] * grid[8]) +  grid[9]== 49 /\
             %cols
             (grid[1] - grid[4] )*  grid[7]== 5 /\
               (grid[2] * grid[5]) *  grid[8]== 27 /\
              ( grid[3] * grid[6]) *  grid[9]== 48;



constraint grid[5]=3;
solve satisfy;
output [ "***************************************\n Arrange the digits too match the equation square\n.\n answer =====>\n  \(grid[1]) - \(grid[2]) * \(grid[3]) = 14 \n  -   *   *     \n  \(grid[4]) + \(grid[5]) + \(grid[6]) = 16 \n  *   *   *     \n  \(grid[7]) * \(grid[8]) + \(grid[9]) = 49 \n  =   =   =     \n  5  27  48 "];