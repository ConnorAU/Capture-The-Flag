
CREATE DATABASE `capturetheflag` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE capturetheflag;

CREATE TABLE `player_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playerid` varchar(200) NOT NULL,
  `beguid` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `first_online` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_online` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `servers_played_on` text NOT NULL,
  `join_game_restriction` text NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `playerid_UNIQUE` (`playerid`),
  UNIQUE KEY `beguid_UNIQUE` (`beguid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

CREATE TABLE `player_settings` (
  `playerid` varchar(200) NOT NULL,
  `currency` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  `vehicles` text NOT NULL,
  `clothing_blufor` text NOT NULL,
  `clothing_opfor` text NOT NULL,
  `weapons` text NOT NULL,
  `skills` text NOT NULL,
  `enable_environment` enum('0','1') NOT NULL DEFAULT '1',
  `show_player_tags` enum('0','1') NOT NULL DEFAULT '1',
  `show_hit_markers` enum('0','1') NOT NULL DEFAULT '0',
  `terrain_smoothing` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `foot_view_distance` int(11) NOT NULL,
  `land_view_distance` int(11) NOT NULL,
  `air_view_distance` int(11) NOT NULL,
  PRIMARY KEY (`playerid`),
  UNIQUE KEY `playerid_UNIQUE` (`playerid`),
  CONSTRAINT `player_settings_fk_playerid` FOREIGN KEY (`playerid`) REFERENCES `player_info` (`playerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `player_skills` (
  `playerid` varchar(200) NOT NULL,
  `steadyAim` enum('0','1','2','3','4','5') NOT NULL,
  `athlete` enum('0','1','2','3','4','5') NOT NULL,
  `ammo` enum('0','1','2','3','4','5') NOT NULL,
  `mechanic` enum('0','1','2','3','4','5') NOT NULL,
  `lifeSaver` enum('0','1','2','3','4','5') NOT NULL,
  `packingHeat` enum('0','1') NOT NULL,
  `flakJacket` enum('0','1','2','3','4','5') NOT NULL,
  `conqueror` enum('0','1','2','3','4','5') NOT NULL,
  PRIMARY KEY (`playerid`),
  UNIQUE KEY `playerid_UNIQUE` (`playerid`),
  KEY `player_skills_fk_playerid_idx` (`playerid`),
  CONSTRAINT `player_skills_fk_playerid` FOREIGN KEY (`playerid`) REFERENCES `player_info` (`playerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `player_statistics` (
  `playerid` varchar(200) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT '0',
  `play_time_blufor` time NOT NULL DEFAULT '00:00:00',
  `play_time_opfor` time NOT NULL DEFAULT '00:00:00',
  `round_victory` int(11) NOT NULL DEFAULT '0',
  `round_defeat` int(11) NOT NULL DEFAULT '0',
  `kills_normal` int(11) NOT NULL DEFAULT '0',
  `kills_assist` int(11) NOT NULL DEFAULT '0',
  `kills_assist_driver` int(11) NOT NULL DEFAULT '0',
  `kills_roadkill` int(11) NOT NULL DEFAULT '0',
  `kills_headshot` int(11) NOT NULL DEFAULT '0',
  `kills_longdistance` int(11) NOT NULL DEFAULT '0',
  `kills_avenger` int(11) NOT NULL DEFAULT '0',
  `kills_doublekill` int(11) NOT NULL DEFAULT '0',
  `kills_triplekill` int(11) NOT NULL DEFAULT '0',
  `kills_quadkill` int(11) NOT NULL DEFAULT '0',
  `kills_pentakill` int(11) NOT NULL DEFAULT '0',
  `kills_killfeed` int(11) NOT NULL DEFAULT '0',
  `deaths` int(11) NOT NULL DEFAULT '0',
  `revive_player` int(11) NOT NULL DEFAULT '0',
  `revived` int(11) NOT NULL DEFAULT '0',
  `heal_player` int(11) NOT NULL DEFAULT '0',
  `healed` int(11) NOT NULL DEFAULT '0',
  `execute_player` int(11) NOT NULL DEFAULT '0',
  `executed` int(11) NOT NULL DEFAULT '0',
  `repaired_vehicle` int(11) NOT NULL DEFAULT '0',
  `flag_captures` int(11) NOT NULL DEFAULT '0',
  `flag_steals` int(11) NOT NULL DEFAULT '0',
  `flag_pickups` int(11) NOT NULL DEFAULT '0',
  `flag_returns` int(11) NOT NULL DEFAULT '0',
  `flag_drops` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`playerid`),
  UNIQUE KEY `playerid_UNIQUE` (`playerid`),
  CONSTRAINT `player_statistics_fk_playerid` FOREIGN KEY (`playerid`) REFERENCES `player_info` (`playerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `round_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` varchar(200) NOT NULL,
  `map` varchar(200) NOT NULL,
  `blufor_flags` int(11) NOT NULL DEFAULT '0',
  `opfor_flags` int(11) NOT NULL DEFAULT '0',
  `round_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `round_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
