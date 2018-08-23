class CfgPatches {
	class CaptureTheFlag_Server {
        name="CaptureTheFlag_Server";
        author="Connor";
        url="https://steamcommunity.com/id/_connor";

		requiredVersion=0.01;
		requiredAddons[]={
			"A3_Functions_F",
			"A3_Modules_F"
		};
		units[]={};
		weapons[]={};
	};
};
#include "CfgCTFSettings.cpp"
class CfgCTFScripts {
    #include "scripts\checks\config.cpp"
	#include "scripts\evh\config.cpp"
    #include "scripts\map\config.cpp"
	#include "scripts\mysql\config.cpp"
    #include "scripts\round\config.cpp"
    #include "scripts\session\config.cpp"
    #include "scripts\setup\config.cpp"
};
class CfgDifficultyPresets {
    // Custom difficulty in the server config instead of the server profile. Works the same.
    class CaptureTheFlag { 
        displayName="Capture the Flag";
        description="Capture the Flag";
        optionDescription="Capture the Flag";
        optionPicture="\A3\Ui_f\data\Logos\arma3_white_ca.paa";
        levelAI="AILevelLow";
        class Options {
            autoReport=0;
            cameraShake=1;
            commands=0;
            deathMessages=0;
            detectedMines=0;
            enemyTags=0;
            friendlyTags=1;
            groupIndicators=2;
            mapContent=0;
            mapContentEnemy=0;
            mapContentFriendly=0;
            mapContentMines=0;
            mapContentPing=0;
            multipleSaves=0;
            reducedDamage=0;
            scoreTable=1;
            squadRadar=1;
            staminaBar=1;
            stanceIndicator=2;
            tacticalPing=1;
            thirdPersonView=1;
            visionAid=0;
            vonID=1;
            waypoints=2;
            weaponCrosshair=1;
            weaponInfo=2;
        };
    };
};
class CfgFunctions {
	class CaptureTheFlag_Server {
		tag = "CTFServer";
		class Init {
            file = "\CTFServer";
			class initServer {preInit=1;};
		};
	};
    class A2 {
        class Numbers {
            class parseNumber {
                file="\CTFServer\BIS_Patches\fn_parseNumber.sqf";
            };
        };
    };
	class A3_Modules
	{
		class Environment
		{
			class moduleHideTerrainObjects
			{
				file="\CTFServer\BIS_Patches\fn_hideTerrainObjects.sqf";
			};
		};
	};
};