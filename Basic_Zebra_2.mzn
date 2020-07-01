% Use this editor as a MiniZinc scratch book

% dificulty " Basic" zebra puzzle
include "alldifferent.mzn";
enum Color={ blue ,green , red };
enum Nationality = { Australian, Brazillian, German};
enum Animal ={ cats ,dogs,fishes};
enum Sport ={ basketball, football, soccer};
set of int:Houses=1..3;

array [Color] of var Houses: colors;
constraint alldifferent(colors);

array [Nationality] of var Houses: nationalities;
constraint alldifferent(nationalities);

array [Animal] of var Houses: animals;
constraint alldifferent(animals);

array [Sport] of var Houses: sports;
constraint alldifferent(sports);

% The Brazilian does not live in house two.
constraint nationalities[Brazillian] != 2;

% The person with the Dogs plays Basketball.
constraint animals[ dogs]==sports[basketball];

% There is one house between the house of the person-
% -who plays Football and the Red house on the right.
constraint sports[football]== colors[red]- 2;

% The person with the Fishes lives directly to the left-
% -of the person with the Cats.
constraint animals[fishes]== animals[cats] -1;

% The person with the Dogs lives directly to the right of the Green house.
constraint animals[dogs]==colors[green] +1;
 
% The German lives in house three.
constraint nationalities[German] ==3;

solve satisfy;
output[ "colors:          { blue: \(colors[blue]), ",
      "red: \(colors[red]), ",
      "green: \(colors[green]) } \n",
      
      "nationalities:   { Australian: \(nationalities[Australian]), ",
      "Brazillian: \(nationalities[Brazillian]), ",
      "German: \(nationalities[German]) }\n",
      
      "animals:         { cats: \(animals[cats]), ",
      "dogs: \(animals[dogs]), ",
      "fishes: \(animals[fishes]) } \n",
      
      "sports:          { basketball: \(sports[basketball]), ",
      "football: \(sports[football]), ",
      "soccer: \(sports[soccer]) }"];
      











