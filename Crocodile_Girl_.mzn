% "easy " difficulty puzzle
% crocodile girl
include "alldifferent.mzn";

enum Color= { blue , green ,lilac, pink, purple};
enum Name= { Georgina , Hannah, Jessica ,Jo, Lucy};
enum Chocolate= { Boost, Crunchies, Dairy_Milk, Milky_Bars, Wispa_Bites};
enum Pet = { crocodile, hamster, horse, puppy, rabbit};
enum Hobby= { horse_riding, skiing, swimming, ten_pin_bowling, tennis};
enum Holiday= { Australia, Canada, Florida, Maldives, Tobago};
set of int: Girls= 1..5;

array[Color] of var Girls: colors;
constraint alldifferent(colors);

array[Name] of var Girls: names;
constraint alldifferent(names);

array[Chocolate] of var Girls: chocolates;
constraint alldifferent(chocolates);

array[Pet] of var Girls: pets;
constraint alldifferent(pets);

array[Hobby] of var Girls: hobbies;
constraint alldifferent(hobbies);

array[Holiday] of var Girls: holidays;
constraint alldifferent(holidays);





% Jo likes the Wispa Bites.
constraint names[Jo]==chocolates[Wispa_Bites];

% The person with the Hamster likes Swimming.
constraint pets[hamster]==hobbies[swimming];

% Hannah eats Dairy Milk.
constraint names[Hannah] ==chocolates[Dairy_Milk];

% Jessica is on the left of Georgina.
constraint names[Jessica] ==names[Georgina] -1;

%Lucy is the first on the left.
constraint names[Lucy] == 1;

%The first person on the right likes Swimming.
constraint hobbies[swimming] == 5;

% The person who eats Milky Bars owns a Horse.
constraint chocolates[Milky_Bars] == pets[horse];

%The person in the middle eats Dairy Milk.
constraint chocolates[Dairy_Milk] == 3;

% Jessica likes Green.
constraint names[Jessica] == colors[green];

%The person on the left of the middle wants to go to Tobago.
constraint holidays[Tobago] < 3;

% The person who wants to go to the Maldives likes Lilac.
constraint holidays[Maldives] == colors[lilac];

% The person who likes Wispa Bites sits next to the person who wants to go to Florida.
constraint chocolates[Wispa_Bites] ==holidays[Florida] + 1 \/ chocolates[Wispa_Bites] ==holidays[Florida] - 1;
 
 % The person who likes Pink wants to go to Florida.
constraint colors[pink] == holidays[Florida];

% The person who sits first on the left likes Lilac.
constraint colors[lilac] ==1;

% The girl that likes Blue owns a Puppy.
constraint colors[blue]==pets[puppy];

%The person who likes Skiing sits next to the person who has a Hamster.
constraint hobbies[skiing] == pets[hamster] + 1 \/ hobbies[skiing] == pets[hamster] - 1;

% The girl on the right of the girl who likes Tennis likes Horse riding.
constraint hobbies[tennis] + 1 == hobbies[horse_riding];

% The girl next to the girl who likes Milky Bars likes Boost.
constraint chocolates[Milky_Bars] + 1= chocolates[Boost] \/ chocolates[Milky_Bars] - 1= chocolates[Boost];

% The girl who likes Purple wants to go to Canada.
constraint colors[purple] == holidays[Canada];

%The girl who likes Crunchies owns a Rabbit.
constraint chocolates[Crunchies]==pets[rabbit];

%The girl who likes Skiing sits next to the girl who plays Ten-pin bowlings.
constraint hobbies[skiing]== hobbies[ten_pin_bowling] + 1 \/  hobbies[skiing]== hobbies[ten_pin_bowling] - 1;

%Jessica wants to go to Australia.
constraint names[Jessica]==holidays[Australia];

solve satisfy;



output[ "colors:  { blue: \(colors[blue]), ",
                    "green: \(colors[green]), ",
                    "lilac: \(colors[lilac]), ",
                    "pink: \(colors[pink]) ",
                    "purple: \(colors[purple]) } \n",
                    
        "names:  { Georgina: \(names[Georgina]), ",
                    "Hannah: \(names[Hannah]), ",
                    "Jessica: \(names[Jessica]), ",
                    "Jo: \(names[Jo]) ",
                    "Lucy: \(names[Lucy]) } \n",
                    
        "chocolates:  { Boost: \(chocolates[Boost]), ",
                    "Crunchies: \(chocolates[Crunchies]), ",
                    "Dairy Milk: \(chocolates[Dairy_Milk]), ",
                    "Milky Bars: \(chocolates[Milky_Bars]) ",
                    "Wispa Bites: \(chocolates[Wispa_Bites]) } \n",
                    
        "pets:  { crocodile: \(pets[crocodile]), ",
                    "hamster: \(pets[hamster]), ",
                    "horse: \(pets[horse]), ",
                    "puppy: \(pets[puppy]) ",
                    "rabbit: \(pets[rabbit]) } \n",
                    
        "hobbies:  { horse riding: \(hobbies[horse_riding]), ",
                    "skiing: \(hobbies[skiing]), ",
                    "swimming: \(hobbies[swimming]), ",
                    "ten-pin bowling: \(hobbies[ten_pin_bowling]) ",
                    "tennis: \(hobbies[tennis]) } \n",
                    
        "holidays:  { Australia: \(holidays[Australia]), ",
                    "Canada: \(holidays[Canada]), ",
                    "Florida: \(holidays[Florida]), ",
                    "Maldives: \(holidays[Maldives]) ",
                    "Tobago: \(holidays[Tobago]) } \n"];
                    
                    



























