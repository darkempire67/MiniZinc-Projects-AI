include "alldifferent.mzn";
% "hard" puzzle dificulty meeting room


enum Tie={ black, blue, green ,red ,yellow};
enum Name={ Adam, Julian, Nathan, Michael, Thomas};
enum Department= { HR,IT, marketing, R_D, sales};
enum Salary= { two_k, three_k,four_k,five_k,six_k};
enum Vacation= { August, December, January,June ,March};
enum Age ={ thirty_four, forty, forty_six, fifty_one, fifty_five};
set of int: Bosses= 1..5;

array[Tie] of var Bosses: ties;
constraint alldifferent(ties);

array[Name] of var Bosses: names;
constraint alldifferent(names);

array[Department] of var  Bosses: departments;
constraint alldifferent(departments);

array[Salary] of var  Bosses: salaries;
constraint alldifferent(salaries);

array[Vacation] of var  Bosses: vacations;
constraint alldifferent(vacations);

array[Age] of var  Bosses: ages;
constraint alldifferent(ages);

% Julian is at the fifth position.
constraint names[Julian]==5;

% The boss with the Red tie is going on vacation on June.
constraint ties[red]==vacations[June];

% The man wearing the Black tie is somewhere between -
% -who earns $3,000 and Adam, in that order.
constraint salaries[three_k] < ties[black] /\ ties[black] < names[Adam];

% The 51 years old boss makes $2,000 monthly.
constraint ages[fifty_one]==salaries[two_k];

% Michael is at the first position.
constraint names[Michael]==1;

% The boss who is going on vacation on March is in one of the ends.
constraint vacations[March]==1 \/ vacations[March]==5;

% Adam sitting is next to who earns $4,000 each month.
constraint names[Adam]== salaries[four_k]+ 1 \/ names[Adam]== salaries[four_k]- 1;

% In the fourth position is the boss who is going on vacation on August.
constraint vacations[August]==4;

%The man wearing the Black tie earns $4,000 monthly.
constraint ties[black]==salaries[four_k];

% In one of the ends is the boss who makes $5,000 monthly.
constraint salaries[five_k]==5 \/ salaries[five_k]==1;

% The 46 years old boss is somewhere to the left of the boss who works at HR department.
constraint ages[forty_six]< departments[HR] ;

% The man from HR department is somewhere between who is 40 years old and Thomas, in that order.
constraint ages[forty] < departments[HR] /\ departments[HR] < names[Thomas];

% Nathan is going on vacation on December.
constraint names[Nathan]==vacations[December];

%The Sales department's boss is exactly to the right of the 46 years old boss.
constraint departments[sales]== ages[forty_six] +1;

%The boss wearing the Red tie is somewhere to the left of the boss wearing the Yellow tie.
constraint ties[red]< ties[yellow];

% In the first position is the boss of R&D department.
constraint departments[R_D]==1;

% The oldest boss is wearing Blue tie.
constraint ages[fifty_five]==ties[blue];

% The man wearing the Yellow tie is in one of the ends.
constraint ties[yellow] ==1 \/ ties[yellow] ==5;

% The youngest boss is at the fifth position.
constraint ages[thirty_four] ==5;

% The boss of the Marketing department is 51 years old.
constraint  departments[marketing]==ages[fifty_one];

solve satisfy;



output [ "ties:  { black: \(ties[black]), ",
                    "blue: \(ties[blue]), ",
                    "green: \(ties[green]), ",
                    "red: \(ties[red]) ",
                    "yellow: \(ties[yellow]) } \n",
                    
        "names:  { Adam: \(names[Adam]), ",
                    "Julian: \(names[Julian]), ",
                    "Nathan: \(names[Nathan]), ",
                    "Michael: \(names[Michael]) ",
                    "Thomas: \(names[Thomas]) } \n",   
                            
        "departments:  { HR: \(departments[HR]), ",
                    "IT: \(departments[IT]), ",
                    "marketing: \(departments[marketing]), ",
                    "R&D: \(departments[R_D]) ",
                    "sales: \(departments[sales]) } \n",

        "salaries:  { 2k: \(salaries[two_k]), ",
                    "3k: \(salaries[three_k]), ",
                    "4k: \(salaries[four_k]), ",
                    "5k: \(salaries[five_k]) ",
                    "6k: \(salaries[six_k]) } \n",

        "vacations:  { August: \(vacations[August]), ",
                    "December: \(vacations[December]), ",
                    "January: \(vacations[January]), ",
                    "June: \(vacations[June]) ",
                    "March: \(vacations[March]) } \n",
                    
        "ages:  { thirty_four: \(ages[thirty_four]), ",
                    "forty: \(ages[forty]), ",
                    "forty_six: \(ages[forty_six]), ",
                    "fifty_one: \(ages[fifty_one]) ",
                    "fifty_five: \(ages[fifty_five]) } \n"];



























