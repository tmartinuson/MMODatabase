/*
CREATE TABLE branch (
	branch_id integer not null PRIMARY KEY,
	branch_name varchar2(20) not null,
	branch_addr varchar2(50),
	branch_city varchar2(20) not null,
	branch_phone integer 
);

INSERT INTO branch VALUES (1, "ABC", "123 Charming Ave", "Vancouver", "6041234567");
INSERT INTO branch VALUES (2, "DEF", "123 Coco Ave", "Vancouver", "6044567890");
*/

CREATE TABLE PlayerXPLevel(
    Level INTEGER DEFAULT 1,
    XP INTEGER PRIMARY KEY
);
CREATE TABLE PlayerCharacter(
    Username CHAR(20),
    ID CHAR(10),
    Money INTEGER,
    XP INTEGER DEFAULT 0,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (XP) REFERENCES PlayerXPLevel
);
CREATE TABLE Assassin(
    Username CHAR(20),
    ID CHAR(10),
    AttackPower INTEGER,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE Warrior(
    Username CHAR(20),
    ID CHAR(10),
    DefensePower INTEGER,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE Mage(
    Username CHAR(20),
    ID CHAR(10),
    PrimarySpell CHAR(20),
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE GamesWith(
    UsernamePlayer1 CHAR(20),
    IDPlayer1 CHAR(10),
    PartyName CHAR(20),
    IDPlayer2 CHAR(10),
    UsernamePlayer2 CHAR(20),
    PRIMARY KEY (IDPlayer1, UsernamePlayer1, IDPlayer2, UsernamePlayer2),
    FOREIGN KEY (IDPlayer1, UsernamePlayer1) REFERENCES PlayerCharacter,
    FOREIGN KEY (IDPlayer2, UsernamePlayer2) REFERENCES PlayerCharacter
);
CREATE TABLE Converses(
    PlayerUsername CHAR(20),
    PlayerID CHAR(10),
    date DATE,
    NPCName CHAR(20),
    PRIMARY KEY (PlayerID, PlayerUsername, NPCName),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (NPCName) REFERENCES NonPlayerCharacter_Gives
);
CREATE TABLE NPCQuestXP(
    Miniquest CHAR(70) PRIMARY KEY,
    RewardXP INTEGER
);
CREATE TABLE NonPlayerCharacter_Gives(
    Name CHAR(20) PRIMARY KEY,
    Miniquest CHAR(70),
    ItemID CHAR(10),
    FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells,
    FOREIGN KEY (Miniquest) REFERENCES NPCQuestXP
);
CREATE TABLE Item_Equips_Sells(
    Price INTEGER,
    ItemID CHAR(10) PRIMARY KEY,
    Stats CHAR(40),
    ShopName CHAR(20) NOT NULL,
    LocationName CHAR(20) NOT NULL,
    PlayerID CHAR(10),
    PlayerUsername CHAR(20),
    FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter
        ON UPDATE SET NULL
);
CREATE TABLE Rewards(
    ItemID CHAR(10),
    EventName CHAR(30) NOT NULL,
    EventStartDate DATE NOT NULL,
    EventEndDate DATE NOT NULL,
    PRIMARY KEY (ItemID, EventName, EventStartDate, EventEndDate),
    FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells,
    FOREIGN KEY (EventName, EventStartDate, EventEndDate) REFERENCES Event
);
CREATE TABLE Shop_IsIn(
    LocationName CHAR(20),
    ShopName CHAR(20),
    Type CHAR(20),
    InventoryAmount INTEGER,
    PRIMARY KEY (LocationName, ShopName),
    FOREIGN KEY (LocationName) REFERENCES Location
);
CREATE TABLE BuysFrom(
    PlayerUsername CHAR(20),
    PlayerID CHAR(10),
    ShopName CHAR(20),
    LocationName CHAR(20),
    PRIMARY KEY (PlayerUsername, PlayerID, ShopName, LocationName),
    FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn,
    FOREIGN KEY (PlayerUsername, PlayerID) REFERENCES PlayerCharacter
);
CREATE TABLE Location(
    Name CHAR(20) PRIMARY KEY,
    Biome CHAR(20)
);
CREATE TABLE Completes(
    LocationName CHAR(20),
    PlayerUsername CHAR(20),
    PlayerID CHAR(10),
    PRIMARY KEY (LocationName, PlayerUsername, PlayerID),
    FOREIGN KEY (LocationName) REFERENCES Location,
    FOREIGN KEY (PlayerUsername, PlayerID) REFERENCES PlayerCharacter
        ON DELETE CASCADE
);
CREATE TABLE MLevelRewardHealth (
    Level INTEGER PRIMARY KEY,
    Reward CHAR(50),
    Health INTEGER
);
CREATE TABLE Monster_isAt (
    Race CHAR(20),
    MonsterID CHAR(10),
    Type CHAR(20),
    Level INTEGER,
    LocationName CHAR(20),
    PRIMARY KEY (Race, MonsterID),
    FOREIGN KEY (LocationName) REFERENCES Location,
    FOREIGN KEY (Level) REFERENCES MLevelRewardHealth
);
CREATE TABLE Fights(
    MonsterRace CHAR(20),
    MonsterID CHAR(10),
    PlayerUsername CHAR(20),
    PlayerID CHAR(10),
    PRIMARY KEY (MonsterRace, MonsterID, PlayerUsername, PlayerID),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (MonsterRace, MonsterID) REFERENCES Monster_IsAt
);
CREATE TABLE Event(
    Name CHAR(20),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (Name, EndDate, StartDate)
);
CREATE TABLE Quest_Contains(
    Title CHAR(20) PRIMARY KEY,
    Description CHAR(50),
    Reward CHAR(50),
    EventName CHAR(20),
    EventEndDate DATE,
    EventStartDate DATE,
    FOREIGN KEY (EventName, EventEndDate, EventStartDate) REFERENCES Event
);
CREATE TABLE Participates(
    QuestTitle CHAR(20),
    PlayerUsername CHAR(20),
    PlayerID CHAR(10),
    Status BIT,
    PRIMARY KEY (QuestTitle, PlayerUsername, PlayerID),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (QuestTitle) REFERENCES Quest_Contains
);