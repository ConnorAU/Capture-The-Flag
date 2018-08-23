class CfgCTFSettings {
    keysToTheKingdom="serverCommandPassword"; // MUST be same as serverCommandPassword in server.cfg

    maxFlagCaptures=5;                  // Number of captures required for a side to win the round
    restartServerAfterXRounds=6;        // Recommended 6 max. Tend to get seagull issues when the server soft restarts too many times

    disablePlaySameMapTwiceInRow=1;     // Remove the last played map from the selection pool on soft restart
    disableFriendlyFire=0;              // Allow bad aim
    disableVehicleThermals=1;           // Disable thermal view on vehicles that have it

    welcomeMessageInterval=0;           // Interval between messages
    welcomeMessages[]={                 // Messages to be sent in the feed when a player loads into the game
        "Welcome to Capture the Flag",
        "https://github.com/ConnorAU/Capture-The-Flag"
    };

    class Maps {
        /*
            Random selection is done using a ticket system. I'll explain using maps as the example.
            You set the number of tickets a map has in the selection pool. 
            A map must have at least one ticket to have a chance of being selected.
            The more tickets in the pool the higher the odds of it being selected.
        */
        class Altis {
            class Kavala {
                mapTickets=1;
                class times {
                    dawnTickets=1;
                    dayTickets=1;
                    afternoonTickets=1;
                    eveningTickets=1;
                };
            };
            class Pygros {
                mapTickets=1;
                class times {
                    dawnTickets=1;
                    dayTickets=1;
                    afternoonTickets=1;
                    eveningTickets=1;
                };
            };
            class Sofia {
                mapTickets=1;
                class times {
                    dawnTickets=1;
                    dayTickets=1;
                    afternoonTickets=1;
                    eveningTickets=1;
                };
            };
        };
    };

    class Rules { // Any class name works as long as its unique
        class objective {
            title="The Objective";
            text="\
The objective of the game is to steal the flag marked on your HUD and return it to your team's capture point.<br/>\
The enemy team is fighting to capture the same flag, you must prevent this at all costs.<br/>\
First team to capture 5 flags wins!\
";
        };
        class reportplayers {
            title="Reporting Players";
            text="When reporting a player please provide evidence of the offence.<br/>Players will not be punished from your word alone.";
        };
        class teamwork {
            title="Teamwork";
            text="\
To win the game you will need to work as a team.<br/>\
Purposefully doing something with the intention of putting your team at a disadvantage will result in a ban.<br/>\
This includes actions such as team killing, damaging friendly vehicles, preventing your team from capturing the flag and anything else of similar nature.\
";
        };
        class spawncamping {
            title="Spawn Camping";
            text="Spawn camping is strictly prohibited.<br/>Players are not to shoot into enemy safezones or be waiting for enemies to leave their safezone to assault them. Stick to the objective.";
        };
        class kamikaze {
            title="Kamikaze";
            text="We all love a good kamikaze, but it is a cheap trick. Intentionally ploughing aircraft into enemy ground forces will not be tolerated.";
        };
        class commonsense {
            title="Common Sense";
            text="Screw your head on straight and don't be an idiot.<br/>Harassing players, mic spamming, trolling and similar behaviour will earn you some time off the server.";
        };
        class enjoy {
            title="Enjoy the Game";
            text="At the end of the day this is just a game.<br/>Don't take it too serious.<br/>Just sit back, relax and have fun!";
        };
    };


    // None of these work.

    teamBalanceEnabled=1;
    teamBalancePlayerThreshold=4;
    teamBalanceMinPlayersPerSide=10;

    class SkillRestriction {
        //Skill=0;
    };
    class WeaponRestriction {
        //Weapon=0;
    };
    class VehicleRestriction {
        //Vehicle=0;
    };
};