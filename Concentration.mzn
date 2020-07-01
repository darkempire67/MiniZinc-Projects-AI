include "alldifferent.mzn";

%  popular Concentration Game...unfinished

%  Symbols instead of images



enum Symbols={ a, b, c,d ,e ,f, g ,h ,i ,j , k, l, m, n, o, p, q, r,a2 , b2, c2,d2 ,e2 ,f2, g2 ,h2 ,i2 ,j2 , k2, l2, m2, n2, o2, p2, q2, r2};

int: max_states= 2^card(Symbols);

set of int:States= 0..10000;

States: start_state=0;

var States: final_state;

enum Choice = {first_pick, second_pick};


array[States , Choice] of var set of Symbols: concentration;

constraint forall(s in States, sym in Symbols , sym2 in Symbols diff{sym}  , c in Choice )  
( sym in concentration[s,c] <->sym2 in concentration[s,c]  );

% start game
constraint concentration[final_state,first_pick] = {};
constraint concentration[final_state,second_pick] = {};

% final first pick
constraint
    concentration[final_state,first_pick ] = { a, b, c,d ,e ,f, g ,h ,i ,j , k, l, m, n, o, p, q, r};
    
  %final second pick 
constraint
    concentration[final_state,second_pick ] ={ a2 , b2, c2,d2 ,e2 ,f2, g2 ,h2 ,i2 ,j2 , k2, l2, m2, n2, o2, p2, q2, r2};



                              
 