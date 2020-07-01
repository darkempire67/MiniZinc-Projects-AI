include "alldifferent.mzn";

% "Medium" dificulty Puzzle einstein riddle

enum Color ={ blue, green, red ,white ,yellow};
enum Nationality= { Brit , Dane ,German, Norwegian, Swede};
enum Drink= {beer, coffee, milk,tea, water};
enum Cigarrete= { Blends, Blue_Master, Dunhill, Pall_Mall, Prince};
enum Pet= { birds ,cats,dogs, horses, fish};
set of int:Houses= 1..5;

array[Color] of var Houses:colors;
constraint alldifferent(colors);

array[Nationality] of var Houses:nationalities;
constraint alldifferent(nationalities);

array[Drink] of var Houses:drinks;
constraint alldifferent(drinks);

array[Cigarrete] of var Houses:cigarretes;
constraint alldifferent(cigarretes);

array[Pet] of var Houses:pets;
constraint alldifferent(pets);

% The Brit lives in the Red house.
constraint nationalities[Brit]==colors[red];

% The Swede keeps Dogs as pets.
constraint nationalities[Swede] ==pets[dogs];

% The Dane drinks Tea.
constraint nationalities[Dane] ==drinks[tea];

% The Green house is next to the White house, on the left.
constraint colors[green]==colors[white] -1;

% The owner of the Green house drinks Coffee.
 constraint colors[green]== drinks[coffee];
 
 % The person who smokes Pall Mall rears Birds.
constraint cigarretes[Pall_Mall]==pets[birds];

% The owner of the Yellow house smokes Dunhill.
constraint colors[yellow]==cigarretes[Dunhill];

%The man living in the centre house drinks Milk.
constraint drinks[milk]==3;

% The Norwegian lives in the first house.
constraint nationalities[Norwegian]==1;

% The man who smokes Blends lives next to the one who keeps Cats.
constraint cigarretes[Blends]==pets[cats]+1  \/ cigarretes[Blends]==pets[cats]-1;

% The man who keeps Horses lives next to the man who smokes Dunhill.
constraint pets[horses] ==cigarretes[Dunhill] +1 \/ pets[horses] ==cigarretes[Dunhill]-1 ;

%The man who smokes Blue Master drinks Beer.
constraint  cigarretes[Blue_Master]==drinks[beer];

% The German smokes Prince.
constraint nationalities[German]==cigarretes[Prince];

% The Norwegian lives next to the Blue house.
constraint nationalities[Norwegian] ==colors[blue]+1 \/ nationalities[Norwegian] ==colors[blue] -1;

% The man who smokes Blends has a neighbour who drinks Water.
constraint cigarretes[Blends]+1==drinks[water] \/ cigarretes[Blends]-1==drinks[water];

solve satisfy;



output ["colors:  { blue: \(colors[blue]), ",
                    "green: \(colors[green]), ",
                    "red: \(colors[red]), ",
                    "white: \(colors[white]) ",
                    "yellow: \(colors[yellow]) } \n",
                    
        "nationalities:  { Brit: \(nationalities[Brit]), ",
                    "Dane: \(nationalities[Dane]), ",
                    "German: \(nationalities[German]), ",
                    "Norwegian: \(nationalities[Norwegian]) ",
                    "Swede: \(nationalities[Swede]) } \n",

        "drinks:  { beer: \(drinks[beer]), ",
                    "coffee: \(drinks[coffee]), ",
                    "milk: \(drinks[milk]), ",
                    "tea: \(drinks[tea]) ",
                    "water: \(drinks[water]) } \n",

        "cigarretes:  { Blends: \(cigarretes[Blends]), ",
                    "Blue_Master: \(cigarretes[Blue_Master]), ",
                    "Dunhill: \(cigarretes[Dunhill]), ",
                    "Pall_Mall: \(cigarretes[Pall_Mall]) ",
                    "Prince: \(cigarretes[Prince]) } \n",
                    
        "pets:  { birds: \(pets[birds]), ",
                    "cats: \(pets[cats]), ",
                    "dogs: \(pets[dogs]), ",
                    "horses: \(pets[horses]) ",
                    "fish: \(pets[fish]) } \n"];            


























