include "alldifferent.mzn";

set of int: Domain=1..9;


% _  * _ _ = _ _ _ = _ _ * _

% 4  * 39  = 156   = 78  * 2

array[1..9] of var Domain: equation;
constraint alldifferent(equation);
constraint equation[1] * ((equation[2]*10 ) + equation[3])== 
           ( (equation[4] * 100) + ( equation[5] * 10 ) + ( equation[6]) ) /\
           ( (equation[4] * 100) + ( equation[5] * 10 ) + ( equation[6]) ) ==
           ( ((equation[7]*10 ) + equation[8] ) * equation[9]);
solve satisfy;
output [ "***************************************\n Arrange the digits in the squares so that the single digit numbers\nmultiplied by the two digit numbers next to them equal the three \ndigit number at the centre.\n answer =====>\n\(equation[1])  * \(equation[2])\(equation[3]) = \(equation[4])\(equation[5])\(equation[6]) = \(equation[7])\(equation[8]) * \(equation[9])"];