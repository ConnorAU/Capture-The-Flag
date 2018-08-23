/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params["","","","","_owner"];

// Remove owner id from the autobalance that doesn't work
CaptureTheFlag_serverSession_westClients = CaptureTheFlag_serverSession_westClients - [_owner];
CaptureTheFlag_serverSession_eastClients = CaptureTheFlag_serverSession_eastClients - [_owner];