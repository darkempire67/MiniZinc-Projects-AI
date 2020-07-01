include "alldifferent.mzn";
% "very hard " dificulty puzzle


enum Tie ={black ,blue ,green, purple, red};
enum Name ={ Austin, James, Jason, Stan, Sterling};
enum Country={ Australia, Brazil, Germany, Libya, Russia};
enum Accessory= { clock, pen , phone, ring , umbrella};
enum Skill= { computer_hacking, disguise, driving, martial_arts, parkour};
enum Age= { twenty_five, thirty,thirty_five,forty,forty_five};

set of int: Agents= 1..5;

array[Tie] of var Agents: ties;
constraint alldifferent(ties);

array[Name] of var Agents: names;
constraint alldifferent(names);

array[Country] of var Agents: countries;
constraint alldifferent(countries);

array[Accessory] of var Agents: accessories;
constraint alldifferent(accessories);

array[Skill] of var Agents: skills;
constraint alldifferent(skills);

array[Age] of var Agents: ages;
constraint alldifferent(ties);

% Austin is next to the agent wearing the Black tie.
constraint names[Austin]==ties[black]+1 \/ names[Austin]==ties[black]-1 ;

%The master of Disguise is exactly to the right of the agent that has a spy Umbrella.
constraint skills[disguise]==accessories[umbrella]+1;

% The 35 years old agent is going to a mission on Tripoli.
constraint ages[thirty_five]==countries[Libya];

%James is the youngest secret agent.
 constraint ages[twenty_five]==names[James];
 
 % The agent that is going to Australia is next to the agent that is specialized in Parkour.
constraint countries[Australia] == skills[parkour] +1 \/ countries[Australia] == skills[parkour] -1;

% James is exactly to the right of the agent that has a special Clock.
 constraint names[James] == accessories[clock] + 1;
 
 % The spy that has an unique Umbrella is somewhere between the 40 years old agent and Austin, in that order.
constraint ages[forty]< accessories[umbrella] /\ accessories[umbrella] < names[Austin];

% Stan is next to the agent that is going to Asia.
constraint names[Stan]==countries[Russia]+1 \/ names[Stan]==countries[Russia]-1 ;

% Sterling is at one of the ends.
constraint names[Sterling] == 1 \/ names[Sterling] == 5;

% The man wearing the Red tie is 40 years old.
constraint ties[red]==ages[forty];

% The spy that is going to South America is exactly to the left of the 45 years old spy.
constraint countries[Brazil]== ages[forty_five]-1;

% Jason is exactly to the left of Austin.
constraint names[Jason] == names[Austin]-1;

% The Driver expert is next to the 30 years old man.
constraint skills[driving] == ages[thirty]+1 \/ skills[driving] == ages[thirty]-1;

% The 35 years old agent is next to the agent that is going Sydney.
constraint ages[thirty_five] == countries[Australia] +1 \/ ages[thirty_five] == countries[Australia] -1;

% The agent with advanced knowledge of Hacking is exactly to the left of the 35 years old man.
constraint skills[computer_hacking] == ages[thirty_five]-1;

% The spy wearing the Purple tie is next the Geek spy.
constraint ties[purple] == skills[computer_hacking]+1 \/ ties[purple] == skills[computer_hacking]-1;

%Austin is 30.
constraint names[Austin]== ages[thirty];

% The agent that has a special Phone is exactly to the left of the agent that is going to Africa.
constraint accessories[phone] ==countries[Libya] -1;

% The agent wearing a spy Ring is somewhere to the right of the agent wearing the Purple tie.
constraint accessories[ring] > ties[purple];

% At the second position is the spy wearing the Green tie.
constraint ties[green] ==2;

% The spy that is going to Australia is exactly to the right of the 30 years old spy.
constraint countries[Australia] == ages[thirty] +1;

solve satisfy;



output [ "ties:  { black: \(ties[black]), ",
                    "blue: \(ties[blue]), ",
                    "green: \(ties[green]), ",
                    "purple: \(ties[purple]) ",
                    "red: \(ties[red]) } \n",

          "names:  { Austin: \(names[Austin]), ",
                    "James: \(names[James]), ",
                    "Jason: \(names[Jason]), ",
                    "Stan: \(names[Stan]) ",
                    "Sterling: \(names[Sterling]) } \n",

         "countries:  { Australia: \(countries[Australia]), ",
                    "Brazil: \(countries[Brazil]), ",
                    "Germany: \(countries[Germany]), ",
                    "Libya: \(countries[Libya]) ",
                    "Russia: \(countries[Russia]) } \n",
      
          "accessories:  { clock: \(accessories[clock]), ",
                    "pen: \(accessories[pen]), ",
                    "phone: \(accessories[phone]), ",
                    "ring: \(accessories[ring]) ",
                    "umbrella: \(accessories[umbrella]) } \n",
                    
          "skills:  { computer_hacking: \(skills[computer_hacking]), ",
                    "disguise: \(skills[disguise]), ",
                    "driving: \(skills[driving]), ",
                    "martial_arts: \(skills[martial_arts]) ",
                    "parkour: \(skills[parkour]) } \n",
                    
          "ages:  { twenty_five: \(ages[twenty_five]), ",
                    "thirty: \(ages[thirty]), ",
                    "thirty_five: \(ages[thirty_five]), ",
                    "forty: \(ages[forty]) ",
                    "forty_five: \(ages[forty_five]) } \n"];





















