
drop table PlayerXPLevel;
drop table PlayerCharacter;
drop table Assassin;
drop table Warrior;
drop table Mage;
drop table GamesWith;
drop table Converses;
drop table NPCQuestXP;
drop table NonPlayerCharacter_Gives;
drop table Item_Equips_Sells;
drop table Rewards;
drop table Shop_IsIn;
drop table BuysFrom;
drop table Location;
drop table Completes;
drop table MLevelRewardHealth;
drop table Monster_isAt;
drop table Fights;
drop table Event;
drop table Quest_Contains;
drop table Participates;

CREATE TABLE PlayerXPLevel(
    PlayerLevel INTEGER DEFAULT 1,
    XP INTEGER PRIMARY KEY
);

INSERT INTO PlayerXPLevel VALUES (1, 996);
INSERT INTO PlayerXPLevel VALUES (18, 165098);
INSERT INTO PlayerXPLevel VALUES (18, 178239);
INSERT INTO PlayerXPLevel VALUES (27, 1128543);
INSERT INTO PlayerXPLevel VALUES (30, 2056032);
INSERT INTO PlayerXPLevel VALUES (36, 8421478);
INSERT INTO PlayerXPLevel VALUES (45, 33000456);
INSERT INTO PlayerXPLevel VALUES (50, 50000000);
INSERT INTO PlayerXPLevel VALUES (34, 5049321);
INSERT INTO PlayerXPLevel VALUES (44, 22490322);
INSERT INTO PlayerXPLevel VALUES (12, 66543);
INSERT INTO PlayerXPLevel VALUES (8, 28709);
INSERT INTO PlayerXPLevel VALUES (39, 17829232);
INSERT INTO PlayerXPLevel VALUES (46, 37452201);
INSERT INTO PlayerXPLevel VALUES (50, 50000000);
INSERT INTO PlayerXPLevel VALUES (1, 0);
INSERT INTO PlayerXPLevel VALUES (1, 244);
INSERT INTO PlayerXPLevel VALUES (1, 65);
INSERT INTO PlayerXPLevel VALUES (1, 34235223);

CREATE TABLE PlayerCharacter(
    Username VARCHAR(20),
    ID VARCHAR(10),
    Money INTEGER,
    XP INTEGER DEFAULT 0,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (XP) REFERENCES PlayerXPLevel
);

grant select on PlayerCharacter to public;

INSERT INTO PlayerCharacter VALUES ('Spready', '34521', 3749, 996);
INSERT INTO PlayerCharacter VALUES ('fangblade', '432567', 5432, 165098);
INSERT INTO PlayerCharacter VALUES ('oopokays', '887', 0, 244);
INSERT INTO PlayerCharacter VALUES ('yorroy', '12144', 0, 0);
INSERT INTO PlayerCharacter VALUES ('SergRyu', '155', 0, 65);
INSERT INTO PlayerCharacter VALUES ('Doublelift', '1122', 13456, 178239);
INSERT INTO PlayerCharacter VALUES ('KumaClub', '33579', 3749, 1128543);
INSERT INTO PlayerCharacter VALUES ('kittyx', '863', 1949754, 2056032);
INSERT INTO PlayerCharacter VALUES ('cinnabunz', '4567', 2614681, 8421478);
INSERT INTO PlayerCharacter VALUES ('Emiru', '26227', 24194, 33000456);
INSERT INTO PlayerCharacter VALUES ('Faker', '10000', 245608778, 50000000);
INSERT INTO PlayerCharacter VALUES ('FrameArms', '27493', 278401, 5049321);
INSERT INTO PlayerCharacter VALUES ('RetroMuse', '432', 264, 22490322);
INSERT INTO PlayerCharacter VALUES ('Dunkey', '20958', 20855, 66543);
INSERT INTO PlayerCharacter VALUES ('ZyraPlant', '8644', 108752, 28709);
INSERT INTO PlayerCharacter VALUES ('Lilyyyxx', '78', 2948, 17829232);
INSERT INTO PlayerCharacter VALUES ('Geegee', '1098', 29957, 37452201);
INSERT INTO PlayerCharacter VALUES ('UberHaxor', '15624', 40099932, 50000000);

CREATE TABLE Assassin(
    Username VARCHAR(20),
    ID VARCHAR(10),
    AttackPower INTEGER,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
);

grant select on Assassin to public;

INSERT INTO Assassin VALUES ('SergRyu', '155', 0);
INSERT INTO Assassin VALUES ('Spready', '34521', 10);
INSERT INTO Assassin VALUES ('fangblade', '432567', 180);
INSERT INTO Assassin VALUES ('Doublelift', '1122', 180);
INSERT INTO Assassin VALUES ('KumaClub', '33579', 270);
INSERT INTO Assassin VALUES ('kittyx', '863', 300);

CREATE TABLE Warrior(
    Username VARCHAR(20),
    ID VARCHAR(10),
    DefensePower INTEGER,
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
);

grant select on Warrior to public;

INSERT INTO Warrior VALUES ('oopokays', '887', 0);
INSERT INTO Warrior VALUES ('cinnabunz', '4567', 360);
INSERT INTO Warrior VALUES ('Emiru', '26227', 450);
INSERT INTO Warrior VALUES ('Faker', '10000', 500);
INSERT INTO Warrior VALUES ('FrameArms', '27493', 340);
INSERT INTO Warrior VALUES ('RetroMuse', '432', 440);

CREATE TABLE Mage(
    Username VARCHAR(20),
    ID VARCHAR(10),
    PrimarySpell VARCHAR(20),
    PRIMARY KEY (ID, Username),
    FOREIGN KEY (ID, Username) REFERENCES PlayerCharacter
        ON DELETE CASCADE
);

grant select on Mage to public;

INSERT INTO Mage VALUES ('yorroy', '12144', NULL);
INSERT INTO Mage VALUES ('Dunkey', '20958', 'Flash Frost');
INSERT INTO Mage VALUES ('ZyraPlant', '8644', 'Deception Orb');
INSERT INTO Mage VALUES ('Lilyyyxx', '78', 'Bouncing Blade');
INSERT INTO Mage VALUES ('Geegee', '1098', 'Light Binding');
INSERT INTO Mage VALUES ('UberHaxor', '15624', 'Pyroblast');

CREATE TABLE GamesWith(
    UsernamePlayer1 VARCHAR(20),
    IDPlayer1 VARCHAR(10),
    PartyName VARCHAR(20),
    UsernamePlayer2 VARCHAR(20),
    IDPlayer2 VARCHAR(10),
    PRIMARY KEY (IDPlayer1, UsernamePlayer1, IDPlayer2, UsernamePlayer2),
    FOREIGN KEY (IDPlayer1, UsernamePlayer1) REFERENCES PlayerCharacter,
    FOREIGN KEY (IDPlayer2, UsernamePlayer2) REFERENCES PlayerCharacter
);

grant select on GamesWith to public;

INSERT INTO GamesWith VALUES ('Dunkey', '20958', 'YTCrew', 'UberHaxor', '15624');
INSERT INTO GamesWith VALUES ('ZyraPlant', '8644', 'MusicTime', 'RetroMuse', '432');
INSERT INTO GamesWith VALUES ('Lilyyyxx', '78', 'MapleMaple', 'fangblade', '432567');
INSERT INTO GamesWith VALUES ('Geegee', '1098', 'Freelo', 'Emiru', '26227');
INSERT INTO GamesWith VALUES ('Spready', '34521', 'Buds', 'UberHaxor', '15624');
INSERT INTO GamesWith VALUES ('RetroMuse', '432', 'PCMR', 'cinnabunz', '4567');

CREATE TABLE Converses(
    PlayerUsername VARCHAR(20),
    PlayerID VARCHAR(10),
    converseDate DATE,
    NPCName VARCHAR(20),
    PRIMARY KEY (PlayerID, PlayerUsername, NPCName),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (NPCName) REFERENCES NonPlayerCharacter_Gives
);

grant select on Converses to public;

INSERT INTO Converses VALUES ('Spready', '34521', 2020-12-24, 'Marzia');
INSERT INTO Converses VALUES ('KumaClub', '33579', 2010-06-22, 'Eren');
INSERT INTO Converses VALUES ('Doublelift', '1122', 2013-01-30, 'Nami');
INSERT INTO Converses VALUES ('Lilyyyxx', '78', 2021-02-10, 'Chika');
INSERT INTO Converses VALUES ('Faker', '10000', 2019-09-07, 'Erwin');
INSERT INTO Converses VALUES ('Faker', '10000', 2019-09-07, 'Viego');
INSERT INTO Converses VALUES ('cinnabunz', '4567', 2015-10-18, 'Braum');
INSERT INTO Converses VALUES ('Emiru', '26227', 2020-07-29, 'Ornn');

CREATE TABLE NPCQuestXP(
    Miniquest VARCHAR(70) PRIMARY KEY,
    RewardXP INTEGER
);

grant select on NPCQuestXP to public;

INSERT INTO NPCQuestXP VALUES ('Travel 5,000 km', 1000);
INSERT INTO NPCQuestXP VALUES ('Buy a weapon from any weapon store', 300);
INSERT INTO NPCQuestXP VALUES ('Catch a salmon from any stream', 500);
INSERT INTO NPCQuestXP VALUES ('Fight 10 Level 20 monsters', 3000);
INSERT INTO NPCQuestXP VALUES ('Create a party with two buddies', 5000);
INSERT INTO NPCQuestXP VALUES ('Complete any boss raid with a buddy', 5000);

CREATE TABLE NonPlayerCharacter_Gives(
    Name VARCHAR(20) PRIMARY KEY,
    Miniquest VARCHAR(70),
    ItemID VARCHAR(10),
    FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells,
    FOREIGN KEY (Miniquest) REFERENCES NPCQuestXP
);

grant select on NonPlayerCharacter_Gives to public;

INSERT INTO NonPlayerCharacter_Gives VALUES ('Marzia', 'Travel 5,000 km', '17894');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Eren', 'Buy a weapon from any weapon store', '18849');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Nami', 'Catch a salmon from any stream', '98392');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Chika', 'Fight 10 Level 20 monsters', '1984');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Erwin', 'Create a party with two buddies', '324');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Viego', 'Complete any boss raid with a buddy', '193');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Braum', 'Gather 3000 wood ', '15699');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Ornn', 'Craft gold armor', '5332');

CREATE TABLE Item_Equips_Sells(
    Price INTEGER,
    ItemID VARCHAR(10) PRIMARY KEY,
    Stats VARCHAR(40),
    ShopName VARCHAR(20) NOT NULL,
    LocationName VARCHAR(20) NOT NULL,
    PlayerID VARCHAR(10),
    PlayerUsername VARCHAR(20),
    FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn
        ON DELETE SET NULL,
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter
);

grant select on Item_Equips_Sells to public;

INSERT INTO Item_Equips_Sells VALUES (5, '17894', '+10 Health from potion', 'PotionZ', 'Ludi', 'Spready', '34521');
INSERT INTO Item_Equips_Sells VALUES (200, '18849', '+2 Attack', 'PowerSurge', 'Kerning', 'KumaClub', '33579');
INSERT INTO Item_Equips_Sells VALUES (500, '98392', '+3 Effectiveness on Primary Spell', 'Magix', 'Ellinia ',
                                      'Doublelift', '1122');
INSERT INTO Item_Equips_Sells VALUES (800, '1984', '+3000 Health from potion', 'PotionZ', 'Ludi', 'Lilyyyxx', '78');
INSERT INTO Item_Equips_Sells VALUES (200, '324', '+2 Defense', 'ShieldsUp', 'Henney', 'Faker', '10000');
INSERT INTO Item_Equips_Sells VALUES (432, '564', '+200 health', 'PotionZ', 'Ludi', 'NULL', 'NULL');
INSERT INTO Item_Equips_Sells VALUES (206900, '193', '+20 Attack', 'Chargers', 'Kerning', 'Faker', '10000');
INSERT INTO Item_Equips_Sells VALUES (345, '532', '+1 Attack', 'Chargers', 'Kerning', 'cinnabunz', '4567');
INSERT INTO Item_Equips_Sells VALUES (25662, '314', '+7 Defense', 'ShieldsUp', 'Henney', 'Emiru', '26227');
INSERT INTO Item_Equips_Sells VALUES (2377, '211', '+3 Attack', 'Unlost', 'Kerning', 'NULL', 'NULL');
INSERT INTO Item_Equips_Sells VALUES (4000, '15699', '+20 Illumination for Dark Locations', 'Unlost', 'Kerning',
                                      'cinnabunz', '4567');
INSERT INTO Item_Equips_Sells VALUES (186362, '5332', '+15 Defense', 'Armure', 'Perion', 'Emiru', '26227');

CREATE TABLE Rewards(
    ItemID VARCHAR(10),
    EventName VARCHAR(30) NOT NULL,
    EventStartDate DATE NOT NULL,
    EventEndDate DATE NOT NULL,
    PRIMARY KEY (ItemID, EventName, EventStartDate, EventEndDate),
    FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells,
    FOREIGN KEY (EventName, EventStartDate, EventEndDate) REFERENCES Event
);

grant select on Rewards to public;

INSERT INTO Rewards VALUES ('98392', 'Magicians’ Arena', 2019-10-03, 2019-10-13);
INSERT INTO Rewards VALUES ('1984', 'Every Potion We’ve Got', 2014-06-25, 2014-06-28);
INSERT INTO Rewards VALUES ('193', 'Assassin Power Surge', 2020-09-10, 2020-10-10);
INSERT INTO Rewards VALUES ('15699', 'Scare Away the Darkness', 2021-01-01, 2021-01-15);
INSERT INTO Rewards VALUES ('5332', 'Hold The Door', 2016-05-22, 2016-05-23);

CREATE TABLE Shop_IsIn(
    LocationName VARCHAR(20),
    ShopName VARCHAR(20),
    Type VARCHAR(20),
    InventoryAmount INTEGER,
    PRIMARY KEY (LocationName, ShopName),
    FOREIGN KEY (LocationName) REFERENCES Location
);

grant select on Shop_IsIn to public;

INSERT INTO Shop_IsIn VALUES ('PotionZ', 'Ludi', 'Potion', 20);
INSERT INTO Shop_IsIn VALUES ('PowerSurge', 'Kerning', 'Weapon', 50);
INSERT INTO Shop_IsIn VALUES ('Magix', 'Ellinia', 'Magic', 120);
INSERT INTO Shop_IsIn VALUES ('ShieldsUp', 'Henney', 'Armor', 50);
INSERT INTO Shop_IsIn VALUES ('Chargers', 'Kerning', 'Armor', 100);
INSERT INTO Shop_IsIn VALUES ('Unlost', 'Kerning', 'Potion', 30);
INSERT INTO Shop_IsIn VALUES ('Armure', 'Perion', 'Armor', 100);
INSERT INTO Shop_IsIn VALUES ('SpellingsBees', 'Ellinia', 'Magic', 50);

CREATE TABLE BuysFrom(
    PlayerUsername VARCHAR(20),
    PlayerID VARCHAR(10),
    ShopName VARCHAR(20),
    LocationName VARCHAR(20),
    PRIMARY KEY (PlayerUsername, PlayerID, ShopName, LocationName),
    FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn,
    FOREIGN KEY (PlayerUsername, PlayerID) REFERENCES PlayerCharacter
);

grant select on BuysFrom to public;

INSERT INTO BuysFrom VALUES ('ZyraPlant', '8644', 'Chargers', 'Kerning');
INSERT INTO BuysFrom VALUES ('ZyraPlant', '8644', 'Magix', 'Ellinia');
INSERT INTO BuysFrom VALUES ('ZyraPlant', '8644', 'PotionZ', 'Ludi');
INSERT INTO BuysFrom VALUES ('ZyraPlant', '8644', 'ShieldsUp', 'Henney');
INSERT INTO BuysFrom VALUES ('ZyraPlant', '8644', 'Armure', 'Perion');
INSERT INTO BuysFrom VALUES ('Lilyyyxx', '78', 'Magix', 'Ellinia');
INSERT INTO BuysFrom VALUES ('Geegee', '1098', 'ShieldsUp', 'Henney');
INSERT INTO BuysFrom VALUES ('kittyx', '863', 'PotionZ', 'Ludi');
INSERT INTO BuysFrom VALUES ('Dunkey', '20958', 'SpellingsBees', 'Ellinia');
INSERT INTO BuysFrom VALUES ('UberHaxor', '15624', 'Unlost', 'Kerning');
INSERT INTO BuysFrom VALUES ('Spready', '34521', 'Armure', 'Perion');
INSERT INTO BuysFrom VALUES ('Faker', '10000', 'PowerSurge', 'Kerning');

CREATE TABLE Location(
    Name VARCHAR(20) PRIMARY KEY,
    Biome VARCHAR(20)
);

grant select on Location to public;

INSERT INTO Location VALUES ('Ludi', 'Temperate forest');
INSERT INTO Location VALUES ('Kerning', 'Taiga');
INSERT INTO Location VALUES ('Ellinia ', 'Swamp');
INSERT INTO Location VALUES ('Henney', 'Grassland');
INSERT INTO Location VALUES ('Perion', 'Desert');

CREATE TABLE Completes(
    LocationName VARCHAR(20),
    PlayerUsername VARCHAR(20),
    PlayerID VARCHAR(10),
    PRIMARY KEY (LocationName, PlayerUsername, PlayerID),
    FOREIGN KEY (LocationName) REFERENCES Location,
    FOREIGN KEY (PlayerUsername, PlayerID) REFERENCES PlayerCharacter
        ON DELETE CASCADE
);

grant select on Completes to public;

INSERT INTO Completes VALUES ('Ludi', 'Geegee', '1098');
INSERT INTO Completes VALUES ('Kerning', 'kittyx', '863');
INSERT INTO Completes VALUES ('Ellinia ', 'Dunkey', '20958');
INSERT INTO Completes VALUES ('Henney', 'UberHaxor', '15624');
INSERT INTO Completes VALUES ('Perion', 'Spready', '34521');
INSERT INTO Completes VALUES ('Perion', 'Faker', '10000');

CREATE TABLE MLevelRewardHealth (
    MonsterLevel INTEGER PRIMARY KEY,
    Reward VARCHAR(50),
    Health INTEGER
);

grant select on MLevelRewardHealth to public;

INSERT INTO MLevelRewardHealth VALUES (1, '5 XP, 5 Gold', 10);
INSERT INTO MLevelRewardHealth VALUES (1, '15 XP, 15 Gold, Potion drop', 85);
INSERT INTO MLevelRewardHealth VALUES (1, '125 XP, 50 Gold, Occasional item drop', 220);
INSERT INTO MLevelRewardHealth VALUES (1, '450 XP, 150 Gold, Occasional item drop', 70000);
INSERT INTO MLevelRewardHealth VALUES (1, '3250 XP, 1060 Gold, Occasional item drop', 500550);
INSERT INTO MLevelRewardHealth VALUES (1, '6750 XP, 2200 Gold, Occasional item drop', 700950);
INSERT INTO MLevelRewardHealth VALUES (1, '20550 XP, 4300 Gold, Occasional item drop', 900000);
INSERT INTO MLevelRewardHealth VALUES (1, '45800 XP, 9500 Gold, Guaranteed item drop', 1100500);
INSERT INTO MLevelRewardHealth VALUES (1, '50000 XP, 11500 Gold, Guaranteed item drop', 1500000);

CREATE TABLE Monster_isAt (
    Race VARCHAR(20),
    MonsterID VARCHAR(10),
    Type VARCHAR(20),
    MonsterLevel INTEGER,
    LocationName VARCHAR(20),
    PRIMARY KEY (MonsterID),
    FOREIGN KEY (LocationName) REFERENCES Location,
    FOREIGN KEY (MonsterLevel) REFERENCES MLevelRewardHealth
);

grant select on Monster_isAt to public;

INSERT INTO Monster_isAt VALUES ('Yordle', '3017', 'Normal', 1, 'Henney');
INSERT INTO Monster_isAt VALUES ('Treeant', '2223', 'Wind', 5, 'Henney');
INSERT INTO Monster_isAt VALUES ('Orc', '1231', 'Earth', 10, 'Perion ');
INSERT INTO Monster_isAt VALUES ('Angel', '1155', 'Ice', 35, 'Kerning');
INSERT INTO Monster_isAt VALUES ('Demon', '2518', 'Fire', 50, 'Perion');
INSERT INTO Monster_isAt VALUES ('Mermaid', '6687', 'Water', 66, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Elf', '1353', 'Electric', 83, 'Perion ');
INSERT INTO Monster_isAt VALUES ('Bug', '9521', 'Poison', 95, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Dragon', '1562', 'Psychic', 100, 'Kerning');
INSERT INTO Monster_isAt VALUES ('Mermaid', '1345', 'Ice', 66, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Elf', '7754', 'Fire', 83, 'Perion ');
INSERT INTO Monster_isAt VALUES ('Bug', '8319', 'Wind', 95, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Dragon', '6744', 'Ice', 100, 'Kerning');


CREATE TABLE Fights(
    MonsterID VARCHAR(10),
    PlayerUsername VARCHAR(20),
    PlayerID VARCHAR(10),
    PRIMARY KEY (MonsterID, PlayerUsername, PlayerID),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (MonsterID) REFERENCES Monster_IsAt
);

grant select on Fights to public;

INSERT INTO Fights VALUES ('3017', 'Spready', '34521');
INSERT INTO Fights VALUES ('2223', 'KumaClub', '33579');
INSERT INTO Fights VALUES ('1231', 'Doublelift', '1122');
INSERT INTO Fights VALUES ('1155', 'Lilyyyxx', '78');
INSERT INTO Fights VALUES ('2518', 'Faker', '10000');
INSERT INTO Fights VALUES ('6687', 'Faker', '10000');
INSERT INTO Fights VALUES ('1353', 'cinnabunz', '4567');
INSERT INTO Fights VALUES ('9521', 'Emiru', '26227');


CREATE TABLE Event(
    Name VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (Name, EndDate, StartDate)
);

grant select on Event to public;

INSERT INTO Event VALUES ('Magicians’ Arena', 2019-10-03, 2019-10-13);
INSERT INTO Event VALUES ('Every Potion We’ve Got', 2014-06-25, 2014-06-28);
INSERT INTO Event VALUES ('Assassin Power Surge', 2020-09-10, 2020-10-10);
INSERT INTO Event VALUES ('Scare Away the Darkness', 2021-01-01, 2021-01-15);
INSERT INTO Event VALUES ('Hold The Door', 2016-05-22, 2016-05-23);

CREATE TABLE Quest_Contains(
    Title VARCHAR(20) PRIMARY KEY,
    Description VARCHAR(50),
    Reward VARCHAR(50),
    EventName VARCHAR(20),
    EventEndDate DATE,
    EventStartDate DATE,
    FOREIGN KEY (EventName, EventEndDate, EventStartDate) REFERENCES Event
);

grant select on Quest_Contains to public;

INSERT INTO Quest_Contains VALUES ('Cast all the Spells', 'Cast 20 unique spells in a party raid',
                                   'An Ice or Fire spell scroll', 'Magicians’ Arena', 2019-10-03, 2019-10-13);
INSERT INTO Quest_Contains VALUES ('Best Potions', 'Farm 15 potions from a Mermaid',
                                   '3 Double XP Boost Potions', 'Every Potion We’ve Got', 2014-06-25, 2014-06-28);
INSERT INTO Quest_Contains VALUES ('So Much Power', 'Win a 1v1 against a higher level player',
                                   'Attack power scroll', 'Assassin Power Surge', 2020-09-10, 2020-10-10);
INSERT INTO Quest_Contains VALUES ('Good Vision', 'Fight 50 monsters under a campfire',
                                   'Illumination potion lasting 1 hr', 'Scare Away the Darkness',
                                   2021-01-01, 2021-01-15);
INSERT INTO Quest_Contains VALUES ('Duty Comes First', 'Resurrect 5 friends',
                                   'Badge of Honour Icon', 'Hold The Door', 2016-05-22, 2016-05-23);


CREATE TABLE Participates(
    QuestTitle VARCHAR(20),
    PlayerUsername VARCHAR(20),
    PlayerID VARCHAR(10),
    Status SMALLINT,
    PRIMARY KEY (QuestTitle, PlayerUsername, PlayerID),
    FOREIGN KEY (PlayerID, PlayerUsername) REFERENCES PlayerCharacter,
    FOREIGN KEY (QuestTitle) REFERENCES Quest_Contains
);

grant select on Participates to public;

INSERT INTO Participates VALUES ('Cast all the Spells', 'ZyraPlant', '8644', 0);
INSERT INTO Participates VALUES ('Best Potions', 'ZyraPlant', '8644', 0);
INSERT INTO Participates VALUES ('So Much Power', 'Geegee', '1098', 1);
INSERT INTO Participates VALUES ('Good Vision', 'kittyx', '863', 1);
INSERT INTO Participates VALUES ('Duty Comes First', 'Dunkey', '20958', 0);
INSERT INTO Participates VALUES ('Cast all the Spells', 'UberHaxor', '15624', 1);
INSERT INTO Participates VALUES ('Best Potions', 'Spready', '34521', 0);
INSERT INTO Participates VALUES ('So Much Power', 'Faker', '10000', 1);
INSERT INTO Participates VALUES ('Good Vision', 'KumaClub', '33579', 1);
INSERT INTO Participates VALUES ('Duty Comes First', 'Doublelift', '1122', 0);