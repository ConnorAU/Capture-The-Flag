/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

class CfgDebriefing {
	class template {
		title="";
		subtitle="";
		description="";
		picture="";
		pictureBackground="";
		pictureColor[]={1,1,1,1};
	};
	


	class genericError: template {
		title="Oops, something went wrong!";
		subtitle="A screw popped loose and the system fell apart.";
		description="\
Don't worry, we have sent a crew of highly trained sea turtles armed with duct tape to patch up the mess.<br/>\
They will be with you sometime in the next two to four months.<br/>\
<br/>\
Alternatively you can rejoin and try again.\
";
	};
	class nullUnit: template {
		title="Setup Failed";
		subtitle="Unit not registered with the server";
		description="Relog and try again, if this issue persists please contact support.";
	};
	class afkTimeout: template {
		title="AFK Timeout";
		subtitle="You have been idle for too long.";
		description="";
	};
	class roundOver: template {
		title="Round Over";
		subtitle="Please wait a moment.";
		description="The next round will start momentarily.";
	};
	class teamBalance: template {
		title="Team Balance";
		subtitle="Too many players on the team.";
		description="Please join the other team or wait for players to leave the selected side.";
	};
	class dataReadError: template {
		title="Data Error";
		subtitle="Your save data is corrupted";
		description="Contact support to resolve this issue.";
	};
	class restricted: template {
		title="Restricted";
		subtitle="You are restricted from play.";
		description="Contact support to resolve this issue.";
	};

	class bluforWon: template {
		title="Victory";
		subtitle="Blufor won the round!";
		description="Great job team, get ready for the next round.";
	};
	class opforWon: bluforWon {
		subtitle="Opfor won the round!";
	};


	class bluforLost: template {
		title="Defeated";
		subtitle="Blufor lost the round!";
		description="Mission failed, we'll get 'em next time.";
	};
	class opforLost: bluforLost {
		subtitle="Opfor lost the round!";
	};

};