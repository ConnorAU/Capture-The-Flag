class NotificationTemplates {
	position[]={
		"safezoneX",
    	"(safezoney+safezoneh)-0.299821",
    	"safezoneW-0.005-0.284999-0.015",
    	"0.04"
	};


// ~~ DEFAULT
	class Default {
		text="%1";
		textSize="1.375";
		textFont="RobotoCondensed";
		textAlign="right";
		textColour="#FFFFFF";
		textShadow="1";
	};


// ~~ Events
	class bluforEvent: Default {
		text="<t color='#11B8EC'>Blufor</t> %1";
	};
	class opforEvent: Default {
		text="<t color='#bf0000'>Opfor</t> %1";
	};
	class addCurrency: Default {
		text="%1 <t color='#CCFFCC'>$%2</t>";
	};
	class addExperience: Default {
		text="%1 <t color='%3'>%2xp</t>";
	};
	class addCandE: Default {
		text="%1 <t color='%3'>%2xp</t> <t color='#CCFFCC'>$%4</t>";
	}; 


// ~~ Kills
	class bluforKillOpfor: Default {
		text="<t color='#11B8EC'>%1</t> <img image='%4'></img> <t color='#bf0000'>%2</t> %3m";
	};
	class bluforKillBlufor: Default {
		text="<t color='#11B8EC'>%1</t> <img image='%4'></img> <t color='#11B8EC'>%2</t> %3m";
	};
	class bluforSuicide: Default {
		text="<img image='%2'></img> <t color='#11B8EC'>%1</t> committed suicide";
	};
	class opforKillBlufor: Default {
		text="<t color='#bf0000'>%1</t> <img image='%4'></img> <t color='#11B8EC'>%2</t> %3m";
	};
	class opforKillOpfor: Default {
		text="<t color='#bf0000'>%1</t> <img image='%4'></img> <t color='#bf0000'>%2</t> %3m";
	};
	class opforSuicide: Default {
		text="<img image='%2'></img> <t color='#bf0000'>%1</t> committed suicide";
	};

// ~~ Auto Team Balance
	class teamBalance_BluforOver: Default {
		text="%1 minutes before <t color='#11B8EC'>blufor</t> team balance will be forced by the server.";
	};	
	class teamBalance_BluforBalanced: Default {
		text="<t color='#11B8EC'>Blufor</t> team balance was forced by the server.";
	};
	class teamBalance_OpforOver: Default {
		text="%1 minutes before <t color='#bf0000'>opfor</t> team balance will be forced by the server.";
	};
	class teamBalance_OpforBalanced: Default {
		text="<t color='#bf0000'>Opfor</t> team balance was forced by the server.";
	};

};