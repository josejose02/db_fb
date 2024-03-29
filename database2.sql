DROP TABLE "player" IF EXISTS;
DROP TABLE "occupation" IF EXISTS;
DROP TABLE "hobby" IF EXISTS;
DROP TABLE "position" IF EXISTS;
DROP TABLE "team" IF EXISTS;
DROP TABLE "match" IF EXISTS;
DROP TABLE "contract" IF EXISTS;
DROP TABLE "playerposition" IF EXISTS;
DROP TABLE "history" IF EXISTS;
DROP TABLE "expense" IF EXISTS;
DROP TABLE "conditions" IF EXISTS;
DROP TABLE "called" IF EXISTS;
DROP TABLE "player_performance" IF EXISTS;

CREATE TABLE "team"
(
    "ID"      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Name"    VARCHAR(255)                                            NOT NULL,
    "Address" VARCHAR(255)                                            NOT NULL
);

CREATE TABLE "player"
(
    "ID"            INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "First Name"    VARCHAR(255)                                            NOT NULL,
    "Middle Name"   VARCHAR(255)                                            NULL,
    "Last Name"     VARCHAR(255)                                            NOT NULL,
    "Height"        INTEGER                                                 NOT NULL,
    "Weight"        DECIMAL(7, 2)                                           NOT NULL,
    "Date of Birth" DATE                                                    NOT NULL,
    "Experience"    INTEGER                                                 NOT NULL,
    "Team ID"       INTEGER                                                 NOT NULL,
    "Pro"           VARCHAR(5)                                              NOT NULL,
    CONSTRAINT "Option Player_Pro" CHECK ("Pro" in ('True', 'False')),
    CONSTRAINT "Check Age" CHECK (YEAR(CURRENT_DATE) - YEAR("Date of Birth") >= 17),
    CONSTRAINT "Relation Player_Team" FOREIGN KEY ("Team ID") REFERENCES "team" ("ID") ON DELETE CASCADE
);

CREATE TABLE "occupation"
(
    "ID"          INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID"   INTEGER                                                 NOT NULL,
    "Type"        VARCHAR(10)                                             NOT NULL,
    "Institution" VARCHAR(255)                                            NOT NULL,
    CONSTRAINT "Option Occupation_Type" CHECK ("Type" in ('Education', 'Employment')),
    CONSTRAINT "Relation Occupation_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
    -- CONSTRAINT "Check PlayerIsPro" CHECK ('False' = (SELECT "Pro" FROM "player" WHERE "ID" = "Player ID"))
);

CREATE TABLE "hobby"
(
    "ID"        INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID" INTEGER                                                 NOT NULL,
    "Name"      VARCHAR(255)                                            NOT NULL,
    CONSTRAINT "Relation Hobby_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
    -- CONSTRAINT "Check PlayerIsPro" CHECK ('False' = (SELECT "Pro" FROM "player" WHERE "ID" = "Player ID"))
);

CREATE TABLE "position"
(
    "ID"   INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Name" VARCHAR(255)                                            NOT NULL
);

CREATE TABLE "match"
(
    "ID"         INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Home ID"    INTEGER                                                 NOT NULL,
    "Away ID"    INTEGER                                                 NOT NULL,
    "Home Score" INTEGER                                                 NOT NULL,
    "Away Score" INTEGER                                                 NOT NULL,
    "Extra time" VARCHAR(5)                                              NOT NULL,
    "Penalties"  VARCHAR(5)                                              NOT NULL,
    "Date"       DATE DEFAULT CURRENT_DATE                               NOT NULL,
    "Place"      VARCHAR(255)                                            NOT NULL,
    CONSTRAINT "Relation Match_Team_Home" FOREIGN KEY ("Home ID") REFERENCES "team" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation Match_Team_Away" FOREIGN KEY ("Away ID") REFERENCES "team" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Check Not Same Team" CHECK ("Home ID" <> "Away ID"),
    CONSTRAINT "Option Extra_Time" CHECK ("Extra time" in ('True', 'False')),
    CONSTRAINT "Option Penalties" CHECK ("Penalties" in ('True', 'False'))
);

CREATE TABLE "contract"
(
    "ID"        INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID" INTEGER                                                 NOT NULL,
    "Team ID"   INTEGER                                                 NOT NULL,
    "Entry"     DATE DEFAULT CURRENT_DATE                               NOT NULL,
    "Exit"      DATE                                                    NOT NULL,
    "Salary"    DECIMAL(15, 2)                                          NOT NULL,
    CONSTRAINT "Relation Contract_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation Contract_Team" FOREIGN KEY ("Team ID") REFERENCES "team" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Check Dates" CHECK ( "Exit" >= "Entry" )
    -- CONSTRAINT "Check PlayerIsPro" CHECK ('True' = (SELECT "Pro" FROM "player" WHERE "ID" = "Player ID"))
);

CREATE TABLE "playerposition"
(
    "ID"          INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID"   INTEGER                                                 NOT NULL,
    "Position ID" INTEGER                                                 NOT NULL,
    "Start"       DATE DEFAULT CURRENT_DATE                               NOT NULL,
    "End"         DATE                                                    NOT NULL,
    CONSTRAINT "Relation PP_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation PP_Position" FOREIGN KEY ("Position ID") REFERENCES "position" ("ID") ON DELETE CASCADE
);

CREATE TABLE "history"
(
    "ID"        INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID" INTEGER                                                 NOT NULL,
    "Team ID"   VARCHAR(255)                                            NOT NULL,
    "Start"     DATE DEFAULT CURRENT_DATE                               NOT NULL,
    CONSTRAINT "Relation History_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE
);

CREATE TABLE "expense"
(
    "ID"        INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID" INTEGER                                                 NOT NULL,
    "Team ID"   INTEGER                                                 NOT NULL,
    "Name"      VARCHAR(255)                                            NOT NULL,
    "Amount"    DECIMAL(10, 2)                                          NOT NULL,
    CONSTRAINT "Relation Expense_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation Expense_Team" FOREIGN KEY ("Team ID") REFERENCES "team" ("ID") ON DELETE CASCADE
    -- CONSTRAINT "Check PlayerIsPro" CHECK ('False' = (SELECT "Pro" FROM "player" WHERE "ID" = "Player ID"))
);

CREATE TABLE "conditions"
(
    "ID"          INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Contract ID" INTEGER                                                 NOT NULL,
    "Condition"   VARCHAR(255)                                            NOT NULL,
    CONSTRAINT "Relation Condition_Contract" FOREIGN KEY ("Contract ID") REFERENCES "contract" ("ID") ON DELETE CASCADE
);

CREATE TABLE "called"
(
    -- Removing this to create compound key
    -- "ID"        INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID" INTEGER    NOT NULL,
    "Match ID"  INTEGER    NOT NULL,
    "Play"      VARCHAR(5) NOT NULL,
    PRIMARY KEY ("Player ID", "Match ID"),
    CONSTRAINT "Option Called_Play" CHECK ("Play" in ('True', 'False')),
    CONSTRAINT "Relation Called_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation Called_Match" FOREIGN KEY ("Match ID") REFERENCES "match" ("ID") ON DELETE CASCADE
);

CREATE TABLE "player_performance"
(
    -- Removing this to create compound key
    -- "ID"               INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 0) NOT NULL PRIMARY KEY,
    "Player ID"        INTEGER NOT NULL,
    "Match ID"         INTEGER NOT NULL,
    "Goals"            INTEGER NOT NULL,
    "Attempts"         INTEGER NOT NULL,
    "Attack On Target" INTEGER NOT NULL,
    "Pass Success"     INTEGER NOT NULL,
    "Pass Fail"        INTEGER NOT NULL,
    "Tackles"          INTEGER NOT NULL,
    "Yellow cards"     INTEGER NOT NULL,
    "Red cards"        INTEGER NOT NULL,
    "Fouls"            INTEGER NOT NULL,
    PRIMARY KEY ("Player ID", "Match ID"),
    CONSTRAINT "Relation Performance_Player" FOREIGN KEY ("Player ID") REFERENCES "player" ("ID") ON DELETE CASCADE,
    CONSTRAINT "Relation Performance_Match" FOREIGN KEY ("Match ID") REFERENCES "match" ("ID") ON DELETE CASCADE
);


