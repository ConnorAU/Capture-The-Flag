/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_secPrefix","",[""]],
	["_log","",[""]],
	["_parseLog",true,[true]]
];
_log = ["[Capture the Flag: ",_secPrefix,"] ",_log] joinstring "";
if _parseLog then {
	// Personally i dislike the quotes normal diag_logs have, however depending on the contents of the log it can complain about structured text things
	diag_log parsetext _log;
} else {
	diag_log _log;
};
