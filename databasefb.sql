CREATE TABLE `player` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `First Name` varchar(255) NOT NULL,
  `Middle Name` varchar(255) DEFAULT NULL,
  `Last Name` varchar(255) NOT NULL,
  `Height` int(11) NOT NULL COMMENT 'in cm',
  `Weight` int(11) NOT NULL COMMENT 'in grams',
  `Experience` int(11) NOT NULL COMMENT 'Measured by the number of national and international matches played',
  `Team ID` int(11) NOT NULL,
  `Pro` varchar(5) NOT NULL,
  CONSTRAINT `Option Player_Pro` CHECK `Pro` in ('True', 'False')
);

CREATE TABLE `occupation` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Type` varchar(10) NOT NULL COMMENT 'Either education or employment',
  `Institution` varchar(255) NOT NULL,
  CONSTRAINT `Option Occupation_Type` CHECK `Type` in ('Education', 'Employment'),
  CONSTRAINT `Relation Occupation_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
);

CREATE TABLE `hobby` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  CONSTRAINT `Relation Hobby_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
);

CREATE TABLE `position` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL
);

CREATE TABLE `playerposition` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Position ID` int(11) NOT NULL,
  `Start` varchar(25) NOT NULL,
  `End` varchar(25) NOT NULL,
  CONSTRAINT `Relation PP_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Relation PP_Position` FOREIGN KEY (`Position ID`) REFERENCES `position` (`ID`) ON DELETE CASCADE,
);

CREATE TABLE `history` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `History` varchar(255) NOT NULL, -- Add TEAM ID. Maybe entry/exit???
  CONSTRAINT `Relation History_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
);

CREATE TABLE `expense` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Team ID` int(11) NOT NULL,
  `Name` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  CONSTRAINT `Relation Expense_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Relation Expense_Team` FOREIGN KEY (`Team ID`) REFERENCES `team` (`ID`) ON DELETE CASCADE,
);

---
--- Team stuff
---

CREATE TABLE `team` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL, -- Add TEAM ID. Maybe entry/exit???
);

---
--- Contract
---

CREATE TABLE `contract` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Team ID` int(11) NOT NULL,
  `Entry` varchar(255) NOT NULL,
  `Exit` varchar(255) NOT NULL,
  `Salary` varchar(255) NOT NULL,
  CONSTRAINT `Relation Contract_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Relation Contract_Team` FOREIGN KEY (`Team ID`) REFERENCES `team` (`ID`) ON DELETE CASCADE,
);

CREATE TABLE `conditions` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Contract ID` int(11) NOT NULL,
  `Condition` varchar(255) NOT NULL,
  CONSTRAINT `Relation Condition_Contract` FOREIGN KEY (`Contract ID`) REFERENCES `contract` (`ID`) ON DELETE CASCADE,
);


---
--- Match
---

CREATE TABLE `match` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ---
  --- We have to go over this !!!
  ---
);

CREATE TABLE `called` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Match ID` int(11) NOT NULL,
  `Play` varchar(5) NOT NULL,
  CONSTRAINT `Option Called_Play` CHECK `Play` in ('True', 'False'),
  CONSTRAINT `Relation Called_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Relation Called_Match` FOREIGN KEY (`Match ID`) REFERENCES `match` (`ID`) ON DELETE CASCADE,
);


---
--- Performance
---

CREATE TABLE `player_performance` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Player ID` int(11) NOT NULL,
  `Match ID` int(11) NOT NULL,
  `Goals` int(3) NOT NULL,
  `Attempts` int(3) NOT NULL,
  `Attack On Target` int(3) NOT NULL,
  `Pass Success` int(3) NOT NULL,
  `Pass Fail` int(3) NOT NULL,
  `Tackles` int(3) NOT NULL,
  `Yellow cards` int(1) NOT NULL,
  `Red cards` int(1) NOT NULL,
  `Fouls` int(1) NOT NULL,
  CONSTRAINT `Relation Performance_Player` FOREIGN KEY (`Player ID`) REFERENCES `player` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Relation Performance_Match` FOREIGN KEY (`Match ID`) REFERENCES `match` (`ID`) ON DELETE CASCADE,
);
