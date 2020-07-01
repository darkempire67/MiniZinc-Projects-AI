include "alldifferent.mzn";
int :n =8;
enum Domain={ gggg,tree,tent}; % ggg is grass-easier to read on the output
array[1..n,1..n] of var Domain:grid;
/*
https://www.brainbashers.com/showtents.asp?date=1114&size=8&diff=Medium

ggg= grass

Objective / Rules
- Find all of the hidden tents.
- Each tent is attached to one tree (so there are as many tents as there are trees).
- The numbers across the top and down the side tell you how many tents are in the respective row or column.
- A tent can only be found horizontally or vertically adjacent to a tree.
- Tents are never adjacent to each other, neither vertically, horizontally, nor diagonally.
- A tree might be next to two tents, but is only connected to one.

*/

% set all he trees 
 constraint grid[1,6]= tree/\grid[1,7]=tree /\
            grid[2,1]= tree/\grid[2,3]=tree /\
            grid[3,3]= tree/\grid[3,7]=tree /\
            grid[5,4]= tree/\grid[5,6]=tree /\
            grid[6,1]= tree/\grid[6,8]=tree /\
            grid[7,2]= tree/\
            grid[8,5]=tree;
       
       %   If there is a tent there must be a tree by it        
  constraint   forall( i in 2..n-1, j in 2..n-1) (grid[i,j]=tent ->    
                  grid[i-1,j]=tree \/ 
                  grid[i+1,j]=tree \/ 
                  grid[i,j-1]=tree \/ 
                  grid[i,j+1]=tree 
                  );  
       %  By row and col ,
       % if one space on the grid is a tent the next cannot be a tent.
  constraint forall( i in 1..n,j in 1..n-1)(grid[i,j]=tent-> grid[i,j+1]!=tent);
    constraint forall( i in 1..n-1,j in 1..n)(grid[i,j]=tent-> grid[i+1,j]!=tent);

    %  diagnal ommision from being "bingo" tent.    
  constraint   forall( i in 2..n-1, j in 2..n-1) (grid[i,j]=tent ->    
                  grid[i-1,j-1]!=tent /\ 
                  grid[i+1,j-1]!=tent /\ 
                  grid[i+1,j+1]!=tent /\ 
                  grid[i-1,j+1]!=tent );  
   
   % if theres a tree theres a tent
  constraint   forall( i in 2..n-1, j in 2..n-1) (grid[i,j]=tree ->  grid[i,j+1]=tent \/ grid[i,j-1]=tent \/  grid[i-1,j]=tent \/ grid[i+1,j]=tent );
  
  
  % sums of rows each row and col say how many tents should be in each row or col
   constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[1,j]==tent)==2 );
  
   constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[2,j]==tent)==1 );
    
     constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[3,j]==tent)==2 );
    
     constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[4,j]==tent)==1 );
    
       constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[5,j]==tent)==3 );
    
      constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[6,j]==tent)==1 );
    
       constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[7,j]==tent)==0 );
    
        constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[8,j]==tent)==2 );
    
      
    %sum of cols
 constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,1]==tent)==2 );
    
   constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,2]==tent)==1 );
constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,3]==tent)==2 ); 
 constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,4]==tent)==2 );   
  constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,5]==tent)==1);
             
  constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,6]==tent)==1 );                
                     
   constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,7]==tent)==2 );                       
     constraint forall( i in 1..n)(
             sum(j in 1..n)( grid[j,8]==tent)==1 );
             
    
 
output[ "*************************************\n This is the Daily Tents puzzle\n Each row and col have different sum of tents. : \n***********************************\n"] ++ % [ show(puzzle[1,i])| i in 1..7  ]++ ["\n"]++
        [ show( grid[i,j]) ++","++
         if j ==8 then 
             if i mod 8=0 /\ i < 8 then " \n\n" else "\n" endif
         else
             if j mod 1= 0 then " " else " " endif
         endif
         | i,j in 1..8]++["------------- \n"];