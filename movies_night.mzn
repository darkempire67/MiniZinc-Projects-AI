
% Based on brainzilla's Movies Night puzzle (https://www.brainzilla.com/logic/zebra/movies-night/)

include "alldifferent.mzn";

enum Name = { Daniel, Joshua, Nicholas, Ryan };
enum Shirt_Color = { black, blue, green, red };
enum Movie_Genre = { action, comedy, horror, thriller };
enum Snack = { chips, cookies, crackers, popcorn };

set of int: Position = 1 .. 4;
set of int: Age = 11 .. 14;

% Define arrays that map from a feature to position. 
% Positions are convenient for this problem because they are ordered. 
% This allows us to compare them with relational operators such as '<'.

% This shirt_to_pos array tells us the position of each shirt.
array[Shirt_Color] of var Position: shirt_to_pos;
constraint alldifferent(shirt_to_pos);

% This movie_to_pos array tells us the position of each movie genre.
array[Movie_Genre] of  var Position: movie_to_pos;
constraint alldifferent(movie_to_pos);

% This snack_to_pos array tells us the position of each snack preference.
array[Snack] of  var Position: snack_to_pos;
constraint alldifferent(snack_to_pos);

% This age_to_pos array tells us the position of each age.
array[Age] of var  Position: age_to_pos;
constraint alldifferent(age_to_pos);

% This name_to_pos array tells us the position of each boy by name.
array[Name] of var Position: name_to_pos;
constraint alldifferent(name_to_pos);


% The clues/constraints

% Joshua is at one of the ends.
constraint name_to_pos[Joshua] == 1 \/ name_to_pos[Joshua] == 1;

% The boy wearing the black shirt is somewhere to the left of the youngest boy.
constraint  shirt_to_pos[black] < age_to_pos[11];

% Joshua likes Horror movies. Note that this says that the horror movie genre
% is at the same position as the boy named Joshua.
constraint movie_to_pos[horror] == name_to_pos[Joshua];   

% The 14 years old boy is at third position.
constraint age_to_pos[14] ==3;

% The boy wearing the Red shirt is somewhere between the 13 years old boy and the one 
% who likes Action movies, in that order.
constraint  age_to_pos[13] < shirt_to_pos[red] /\ shirt_to_pos[red]  < movie_to_pos[action];

% Daniel likes Thriller movies. Again, we are identifying Daniel and
% the Thriller movie fan as being in the same position.
constraint movie_to_pos[thriller] == name_to_pos[Daniel];

% The boy who is going to eat Cookies is in one of the ends.
constraint snack_to_pos[cookies] == 1 \/ snack_to_pos[cookies] == 4 ;

% The boy wearing the Black shirt is exactly to the left of the one who likes Thriller movies.
constraint shirt_to_pos[black] == movie_to_pos[thriller]  - 1 ;

% The boy who is going to eat Crackers is exactly to the right of the boy who likes Comedy movies.
constraint movie_to_pos[comedy]  + 1  == snack_to_pos[crackers] ;
% Could also have been written as follows. Since the two lines say the same thing, 
% either can be commented out with no effect on the model.
constraint '=='('+'(movie_to_pos[comedy], 1), snack_to_pos[crackers]) ;

% The boy wearing the Red shirt is somewhere between
% the boy who is going to eat Popcorn and Nicholas, in that order.
constraint snack_to_pos[popcorn]  < shirt_to_pos[red]  /\  shirt_to_pos[red] < name_to_pos[Nicholas];
% Could also have been written as follows. Since the two lines say the same thing, 
% either can be commented out with no effect on the model.
constraint '/\'(snack_to_pos[popcorn]  < shirt_to_pos[red], shirt_to_pos[red] < name_to_pos[Nicholas]);

% In one of the ends is the boy who likes Thriller movies.
constraint movie_to_pos[thriller] == 1  \/  movie_to_pos[thriller] == 4 ;
% Could also have been written as follows. Since the two lines say the same thing, 
% either can be commented out with no effect on the model.
constraint '\/'( '=='(movie_to_pos[thriller], 1),  '=='(movie_to_pos[thriller], 4)) ;


% Nicholas is somewhere between Joshua and Daniel, in that order.
constraint name_to_pos[Joshua] < name_to_pos[Nicholas]  /\  name_to_pos[Nicholas] < name_to_pos[Daniel];

% At first position is the boy wearing the Green shirt.
constraint shirt_to_pos[green] == 1;


% Define additional arrays  that map backwards. (These aren't needed to solve the puzzle.)
array[Position] of var Name: pos_to_name;
constraint alldifferent(pos_to_name);
constraint forall (n in Name, p in Position) (name_to_pos[n] == p <->  pos_to_name[p] == n);

array[Name] of var Shirt_Color: name_to_shirt;
constraint alldifferent(name_to_shirt);
constraint forall (n in Name, s in Shirt_Color) (name_to_shirt[n] == s <->  pos_to_name[shirt_to_pos[s]] == n);

array[Name] of var Age: name_to_age;
constraint alldifferent(name_to_age);
constraint forall (n in Name, a in Age) (name_to_age[n] == a <->  pos_to_name[age_to_pos[a]] == n);

array[Name] of var Movie_Genre: name_to_movie;
constraint alldifferent(name_to_movie);
constraint forall (n in Name, m in Movie_Genre) (name_to_movie[n] == m <->  pos_to_name[movie_to_pos[m]] == n);

array[Name] of var Snack: name_to_snack :: output_array([Name]);
constraint alldifferent(name_to_snack);
constraint forall (n in Name, s in Snack) (name_to_snack[n] == s <->  pos_to_name[snack_to_pos[s]] == n);

solve satisfy;

/*
    The output must be an array of strings.   Arrays may be concatenated with '++'. 
    In this case, the output is multiple arrays of strings concatenated together.
    Note the use of a list comprehension to generate an array of strings on each output line.
    
    Strings may also be concatenated with '++'. Note that most lines end with a string, which
    is continued on the following line. They could  just as well have ended with an array, which 
    is followed by another array on the next line.  For output purposes, the following, an array 
    of one string element created by concatenating two strings,
    
                                                                               ... ++ ["}\n" ++
       "name -> pos: {  "] ++ 
       
    is equivalent to the concatenation of two arrays of one string element each.
    
                                                                               ... ++ ["}\n"] ++
       ["name -> pos: {  "] ++ 
       
    As far as output is concerned ["a", "b"] will produce the same result as ["ab"].
*/
output 
               ["\n"] ++
               
               ["pos -> name: {  "] ++ ["\(p):  \(pos_to_name[p]);   " | p in Position] ++ ["}\n" ++
                "name -> pos: {  "] ++ ["\(n):  \(name_to_pos[n]);   " | n in Name]  ++ ["}\n\n" ++
               
               % Note the use of pos_to_name to get from position to name. In other words, we go
               % from shirt to position to name because there is no direct shirt-to-name array.
                "shirt -> name: {  "] ++ ["\(s):  \(pos_to_name[shirt_to_pos[s]]);   " | s in Shirt_Color] ++ ["}\n"  ++
                "name -> shirt: {  "] ++ ["\(n):  \(name_to_shirt[n]);   " | n in Name]  ++ ["}\n\n"  ++
               
                "age -> name: {  "] ++ ["\(a):  \(pos_to_name[age_to_pos[a]]);   " | a in Age] ++ ["}\n"  ++
                "name -> age: {  "] ++ ["\(n):  \(name_to_age[n]);   " | n in Name]  ++ ["}\n\n"  ++
               
                "movie -> name: {  "] ++ ["\(m):  \(pos_to_name[movie_to_pos[m]]);   " | m in Movie_Genre] ++ ["}\n"  ++
                "name -> movie: {  "] ++ ["\(n):  \(name_to_movie[n]);   " | n in Name]  ++ ["}\n\n"  ++
               
                "snack -> name: {  "] ++ ["\(s):  \(pos_to_name[snack_to_pos[s]]);   " | s in Snack] ++ ["}\n"  ++
                "name -> snack: {  "] ++ ["\(n):  \(name_to_snack[n]);   " | n in Name]  ++ ["}\n\n"]
