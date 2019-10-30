-- CREATE DATABASE fb;

-- USE fb;



CREATE TABLE "player" (
  "ID" INTEGER NOT NULL PRIMARY KEY ,
  "First Name" VARCHAR(255) NOT NULL,
  "Middle Name" VARCHAR(255) DEFAULT NULL,
  "Last Name" VARCHAR(255) NOT NULL,
  "Height" INTEGER NOT NULL,
  "Weight" INTEGER NOT NULL,
  "Experience" INTEGER NOT NULL,
  "Team ID" INTEGER NOT NULL,
  "Pro" VARCHAR(5) NOT NULL,
  CONSTRAINT "Option Player_Pro" CHECK ("Pro" in ('True', 'False'))
);

CREATE TABLE "occupation" (
  "ID" INTEGER  NOT NULL PRIMARY KEY ,
  "Player ID" INTEGER NOT NULL,
  "Type" VARCHAR(10) NOT NULL,
  "Institution" VARCHAR(255) NOT NULL,
  CONSTRAINT "Option Occupation_Type" CHECK ("Type" in ('Education', 'Employment')),
  CONSTRAINT "Relation Occupation_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
);

CREATE TABLE "hobby" (
  "ID" INTEGER  NOT NULL PRIMARY KEY ,
  "Player ID" INTEGER NOT NULL,
  "Name" VARCHAR(255) NOT NULL,
  CONSTRAINT "Relation Hobby_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
);

CREATE TABLE "position" (
  "ID" INTEGER  NOT NULL PRIMARY KEY ,
  "Name" VARCHAR(255) NOT NULL
);


CREATE TABLE "team" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Name" VARCHAR(255) NOT NULL,
  "Address" VARCHAR(255) NOT NULL -- Add TEAM ID. Maybe entry/exit???
);

CREATE TABLE "match" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Home ID" INTEGER NOT NULL,
  "Away ID" INTEGER NOT NULL,
  "Home Score" INTEGER NOT NULL,
  "Away Score" INTEGER NOT NULL,
  "Extra time" INTEGER NOT NULL,
  "Penalties" INTEGER NOT NULL,
  CONSTRAINT "Relation Match_Team_Home" FOREIGN KEY ("Home ID") REFERENCES "team" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation Match_Team_Away" FOREIGN KEY ("Away ID") REFERENCES "team" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Check Not Same Team" CHECK ("Home ID" <> "Away ID")
);


CREATE TABLE "contract" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Player ID" INTEGER NOT NULL,
  "Team ID" INTEGER NOT NULL,
  "Entry" VARCHAR(255) NOT NULL,
  "Exit" VARCHAR(255) NOT NULL,
  "Salary" VARCHAR(255) NOT NULL,
  CONSTRAINT "Relation Contract_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation Contract_Team" FOREIGN KEY ("Team ID") REFERENCES "team" ("ID") ON DELETE CASCADE
);


CREATE TABLE "playerposition" (
  "ID" INTEGER  NOT NULL PRIMARY KEY ,
  "Player ID" INTEGER NOT NULL,
  "Position ID" INTEGER NOT NULL,
  "Start" VARCHAR(25) NOT NULL,
  "End" VARCHAR(25) NOT NULL,
  CONSTRAINT "Relation PP_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation PP_Position" FOREIGN KEY ("Position ID") REFERENCES "position" ("ID") ON DELETE CASCADE
);

CREATE TABLE "history" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Player ID" INTEGER NOT NULL,
  "History" VARCHAR(255) NOT NULL, -- Add TEAM ID. Maybe entry/exit???
  CONSTRAINT "Relation History_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
);

CREATE TABLE "expense" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Player ID" INTEGER NOT NULL,
  "Team ID" INTEGER NOT NULL,
  "Name" INTEGER NOT NULL,
  "Amount" INTEGER NOT NULL,
  CONSTRAINT "Relation Expense_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation Expense_Team" FOREIGN KEY ("Team ID") REFERENCES "team" ("ID") ON DELETE CASCADE
);


CREATE TABLE "conditions" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Contract ID" INTEGER NOT NULL,
  "Condition" VARCHAR(255) NOT NULL,
  CONSTRAINT "Relation Condition_Contract" FOREIGN KEY ("Contract ID") REFERENCES "contract" ("ID") ON DELETE CASCADE
);


--
-- Match
--



CREATE TABLE "called" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Player ID" INTEGER NOT NULL,
  "Match ID" INTEGER NOT NULL,
  "Play" VARCHAR(5) NOT NULL,
  CONSTRAINT "Option Called_Play" CHECK ("Play" in ('True', 'False')),
  CONSTRAINT "Relation Called_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation Called_Match" FOREIGN KEY ("Match ID") REFERENCES "match" ("ID") ON DELETE CASCADE
);


--
-- Performance
--

CREATE TABLE "player_performance" (
  "ID" INTEGER NOT NULL PRIMARY KEY  ,
  "Player ID" INTEGER NOT NULL,
  "Match ID" INTEGER NOT NULL,
  "Goals" INTEGER NOT NULL,
  "Attempts" INTEGER NOT NULL,
  "Attack On Target" INTEGER NOT NULL,
  "Pass Success" INTEGER NOT NULL,
  "Pass Fail" INTEGER NOT NULL,
  "Tackles" INTEGER NOT NULL,
  "Yellow cards" INTEGER NOT NULL,
  "Red cards" INTEGER NOT NULL,
  "Fouls" INTEGER NOT NULL,
  CONSTRAINT "Relation Performance_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
  CONSTRAINT "Relation Performance_Match" FOREIGN KEY ("Match ID") REFERENCES "match" ("ID") ON DELETE CASCADE
);
