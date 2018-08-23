# Capture The Flag

A 60v60 variation of the classic CTF game mode for Arma 3.


## About the mission
I had been wondering for a while why [Sa-Matra's KOTH](https://armakoth.com/) was the only popular classic game mode in Arma 3. I wanted to see if anything else could be as enjoyable as KOTH and thought CTF would be the best mode to try.

## Why I've released the source
I originally planned to use the mission as a framework and just change the objective to try out a few game modes, but after CTF I could see my time was better spent elsewhere. It's been over 6 months since I touched the mission so the dust is starting to build up. 

Considering I have no other use for this code it only makes sense to release it so others can have a read and maybe learn something. SQF was the first language I learnt and I found it easiest to expand my knowledge by seeing features working ingame then reading the functions to understand how it worked. 

I feel it's important to be able to plan a system out in your head before you write it, so hopefully trying things in the mission and reading how it works can help others develop that skill. The scripts aren't perfect (nothing ever is) but it's good to see both good and bad scripts while you're learning so you know the difference.

## Main features
- All things related to capturing the flag and showing the flag state the HUD
- Dynamic map SQM loading
- Clothing, weapon and vehicle stores
- Progression system
- Tiered skills
- Player data and stats saving

## Please note the following
The mission was built with multiple layers of obscurity. I have cleaned up what needed cleaning so things aren't as confusing but have left the file structure and order of events alone. This means you will come across some scripts (especially in the client/server init) that are way over-complicated.

## Contributing
I have no plans to continue working on the mission but if you have the urge to contribute to the repository please do. Especially with my intention for it to be learning material, if you believe you can make a positive contribution I won't stop you.

## Gameplay
The final product isn't exactly classic CTF. Instead of teams trying to steal each other's flag, they are fighting over a neutral flag trying to get it back to their capture point. The idea was to focus the main battle around the neutral flag so we didn't have two major battles taking place as well as smaller battles to secure the capture points. 

It is good fun with a decent amount of players (20+) but there are some pretty big flaws in my opinion. 
- Once the flag holder was in a vehicle it was very hard to prevent them from getting all the way to their capture point. You needed a team set up on the enemy cap to intercept and return the flag.
- The large scale made vehicles almost necessary to get to the capture point, which was an issue when there were no vehicles around.
- Having a single flag to fight over often caused both teams to fall into defense mode just waiting for the other team to try and take it.
- The progression was obviously inspired by KOTH, sadly here it felt like more of a restriction than a goal to achieve. This is mostly because the point of focus moved around the map depending on where the flag was so it was hard to keep up.

I think the biggest mistake was trying to make the mission KOTH with a different objective. I do have some plans if I get time down the line to try CTF again, but I would be taking a very different approach.



# Setup
All testing and hosting of the mission was done using the arma 3 dedicated server package.

## Server setup
1. Place the mission pbo in the `mpmissions` folder
2. Place the server mod in `@CTFServer\addons`
3. Place the `server.cfg` in your Arma 3 server root folder
4. Put this in the server command line `-config=server.cfg -serverMod=@CTFServer`

### Notes
- If you wish to use your own server.cfg make sure the mission difficulty is set to `difficulty="CaptureTheFlag";`
- There is no [basic.cfg](https://community.bistudio.com/wiki/basic.cfg) included in this repository as I have never had a problem with default settings


## Saving player data
The mission was built to use [extDB3](https://bitbucket.org/torndeco/extdb3), however I've added local saving to the server profile for this release to make it easier to hop on and mess around. The server will automatically use profile saving if extDB3 fails to load.

### extDB3 setup (optional)
The purpose of using extDB3 is if you wish to host multiple servers with linked stats, or if you wish to display player statistics (kills, assists, headshots, etc) on a website.
1. Use this [database setup](https://github.com/ConnorAU/Capture-The-Flag/blob/master/database.sql) to create the schema
2. Create an account and make sure it has SELECT, INSERT and UPDATE permissions to the schema
3. Fill out the extDB3 config with your database credentials
4. Place the [CaptureTheFlag.ini](https://github.com/ConnorAU/Capture-The-Flag/blob/master/CaptureTheFlag.ini) in `@extDB3\sql_custom`
5. Add extDB3 to the -serverMod parameter in the command line `-serverMod=@CTFServer;@extDB3`



# License
This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0).
License: https://creativecommons.org/licenses/by-nc-sa/4.0/