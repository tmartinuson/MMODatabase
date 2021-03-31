DROP TABLE Participates;
DROP TABLE Quest_Contains;
DROP TABLE Fights;
DROP TABLE Monster_isAt;
DROP TABLE MLevelRewardHealth;
DROP TABLE Completes;

DROP TABLE BuysFrom;
DROP TABLE Converses;
DROP TABLE NonPlayerCharacter_Gives;
DROP TABLE Rewards;
DROP TABLE Events;
DROP TABLE Item_Equips_Sells;
DROP TABLE NPCQuestXP;
DROP TABLE Shop_IsIn;
DROP TABLE Locations;
DROP TABLE GamesWith;
DROP TABLE Mage;
DROP TABLE Warrior;
DROP TABLE Assassin;
DROP TABLE PlayerCharacter;
DROP TABLE PlayerXPLevel;

CREATE TABLE PlayerXPLevel(
                              PlayerLevel INTEGER PRIMARY KEY,
                              XP INTEGER
);

grant select on PlayerXPLevel to public;

CREATE TABLE PlayerCharacter(
                                Username VARCHAR(20) UNIQUE NOT NULL,
                                ID VARCHAR(10) PRIMARY KEY,
                                PlayerMoney INTEGER NOT NULL,
                                PlayerLevel INTEGER NOT NULL,
                                FOREIGN KEY (PlayerLevel) REFERENCES PlayerXPLevel ON DELETE CASCADE
);

grant select on PlayerCharacter to public;

CREATE TABLE Assassin(
                         ID VARCHAR(10) PRIMARY KEY,
                         AttackPower INTEGER NOT NULL,
                         FOREIGN KEY (ID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on Assassin to public;



CREATE TABLE Warrior(
                        ID VARCHAR(10) PRIMARY KEY,
                        DefensePower INTEGER NOT NULL,
                        FOREIGN KEY (ID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on Warrior to public;



CREATE TABLE Mage(
                     ID VARCHAR(10) PRIMARY KEY,
                     PrimarySpell VARCHAR(20),
                     FOREIGN KEY (ID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on Mage to public;

CREATE TABLE GamesWith(
                          IDPlayer1 VARCHAR(10),
                          PartyName VARCHAR(20),
                          IDPlayer2 VARCHAR(10),
                          PRIMARY KEY (IDPlayer1, IDPlayer2),
                          FOREIGN KEY (IDPlayer1) REFERENCES PlayerCharacter ON DELETE CASCADE,
                          FOREIGN KEY (IDPlayer2) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on GamesWith to public;

CREATE TABLE NPCQuestXP(
                           Miniquest VARCHAR(70) PRIMARY KEY,
                           RewardXP INTEGER
);

grant select on NPCQuestXP to public;

CREATE TABLE Locations(
                          LocationName VARCHAR(20) PRIMARY KEY,
                          Biome VARCHAR(20) NOT NULL
);

grant select on Locations to public;

CREATE TABLE Shop_IsIn(
                          ShopName VARCHAR(20),
                          LocationName VARCHAR(20),
                          ShopType VARCHAR(20),
                          InventoryAmount INTEGER,
                          PRIMARY KEY (ShopName, LocationName),
                          FOREIGN KEY (LocationName) REFERENCES Locations ON DELETE CASCADE
);

grant select on Shop_IsIn to public;

CREATE TABLE Item_Equips_Sells(
                                  Price INTEGER,
                                  ItemID VARCHAR(10) PRIMARY KEY,
                                  Stats VARCHAR(40),
                                  ShopName VARCHAR(20) NOT NULL,
                                  LocationName VARCHAR(20) NOT NULL,
                                  PlayerID VARCHAR(10),
                                  FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn ON DELETE CASCADE,
                                  FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on Item_Equips_Sells to public;

CREATE TABLE NonPlayerCharacter_Gives(
                                         NPCName VARCHAR(20) PRIMARY KEY,
                                         Miniquest VARCHAR(70),
                                         ItemID VARCHAR(10),
                                         FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells ON DELETE CASCADE,
                                         FOREIGN KEY (Miniquest) REFERENCES NPCQuestXP ON DELETE CASCADE
);

grant select on NonPlayerCharacter_Gives to public;

CREATE TABLE Converses(
                          PlayerID VARCHAR(10),
                          converseDate DATE,
                          NPCName VARCHAR(20),
                          PRIMARY KEY (PlayerID, NPCName),
                          FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE,
                          FOREIGN KEY (NPCName) REFERENCES NonPlayerCharacter_Gives ON DELETE CASCADE
);

grant select on Converses to public;

CREATE TABLE Events(
                       EventName VARCHAR(30),
                       StartDate DATE,
                       EndDate DATE,
                       PRIMARY KEY (EventName, StartDate, EndDate)
);

grant select on Events to public;


CREATE TABLE Rewards(
                        ItemID VARCHAR(10),
                        EventName VARCHAR(30) NOT NULL,
                        EventStartDate DATE NOT NULL,
                        EventEndDate DATE NOT NULL,
                        PRIMARY KEY (ItemID, EventName, EventStartDate, EventEndDate),
                        FOREIGN KEY (ItemID) REFERENCES Item_Equips_Sells ON DELETE CASCADE,
                        FOREIGN KEY (EventName, EventStartDate, EventEndDate) REFERENCES Events ON DELETE CASCADE
);

grant select on Rewards to public;


CREATE TABLE BuysFrom(
                         PlayerID VARCHAR(10),
                         ShopName VARCHAR(20),
                         LocationName VARCHAR(20),
                         PRIMARY KEY (PlayerID, ShopName, LocationName),
                         FOREIGN KEY (ShopName, LocationName) REFERENCES Shop_IsIn ON DELETE CASCADE,
                         FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on BuysFrom to public;


CREATE TABLE Completes(
                          LocationName VARCHAR(20),
                          PlayerID VARCHAR(10),
                          PRIMARY KEY (LocationName, PlayerID),
                          FOREIGN KEY (LocationName) REFERENCES Locations ON DELETE CASCADE,
                          FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE
);

grant select on Completes to public;

CREATE TABLE MLevelRewardHealth (
                                    MonsterLevel INTEGER PRIMARY KEY,
                                    RewardXP INTEGER,
                                    RewardMoney INTEGER,
                                    RewardItemId INTEGER,
                                    Health INTEGER
);

grant select on MLevelRewardHealth to public;


CREATE TABLE Monster_isAt (
                              Race VARCHAR(20),
                              MonsterID VARCHAR(10) PRIMARY KEY,
                              MonsterType VARCHAR(20),
                              MonsterLevel INTEGER,
                              LocationName VARCHAR(20),
                              FOREIGN KEY (LocationName) REFERENCES Locations ON DELETE CASCADE,
                              FOREIGN KEY (MonsterLevel) REFERENCES MLevelRewardHealth ON DELETE CASCADE
);

grant select on Monster_isAt to public;

CREATE TABLE Fights(
                       MonsterID VARCHAR(10),
                       PlayerID VARCHAR(10),
                       PRIMARY KEY (MonsterID, PlayerID),
                       FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE,
                       FOREIGN KEY (MonsterID) REFERENCES Monster_IsAt ON DELETE CASCADE
);

grant select on Fights to public;

CREATE TABLE Quest_Contains(
                               Title VARCHAR(30) PRIMARY KEY,
                               QuestDescription VARCHAR(50),
                               Reward VARCHAR(50),
                               EventName VARCHAR(30),
                               EventStartDate DATE,
                               EventEndDate DATE,
                               FOREIGN KEY (EventName, EventStartDate, EventEndDate) REFERENCES Events ON DELETE CASCADE
);

grant select on Quest_Contains to public;

CREATE TABLE Participates(
                             QuestTitle VARCHAR(30),
                             PlayerID VARCHAR(10),
                             QStatus SMALLINT,
                             PRIMARY KEY (QuestTitle, PlayerID),
                             FOREIGN KEY (PlayerID) REFERENCES PlayerCharacter ON DELETE CASCADE,
                             FOREIGN KEY (QuestTitle) REFERENCES Quest_Contains ON DELETE CASCADE
);

grant select on Participates to public;

INSERT INTO PlayerXPLevel VALUES (1, 0);
INSERT INTO PlayerXPLevel VALUES (2, 1000);
INSERT INTO PlayerXPLevel VALUES (3, 2000);
INSERT INTO PlayerXPLevel VALUES (4, 3000);
INSERT INTO PlayerXPLevel VALUES (5, 4000);
INSERT INTO PlayerXPLevel VALUES (6, 5000);
INSERT INTO PlayerXPLevel VALUES (7, 6000);
INSERT INTO PlayerXPLevel VALUES (8, 7000);
INSERT INTO PlayerXPLevel VALUES (9, 8000);
INSERT INTO PlayerXPLevel VALUES (10, 10000);
INSERT INTO PlayerXPLevel VALUES (11, 15000);
INSERT INTO PlayerXPLevel VALUES (12, 20000);
INSERT INTO PlayerXPLevel VALUES (13, 25000);
INSERT INTO PlayerXPLevel VALUES (14, 50000);
INSERT INTO PlayerXPLevel VALUES (15, 75000);
INSERT INTO PlayerXPLevel VALUES (16, 100000);
INSERT INTO PlayerXPLevel VALUES (17, 125000);
INSERT INTO PlayerXPLevel VALUES (18, 150000);
INSERT INTO PlayerXPLevel VALUES (19, 175000);
INSERT INTO PlayerXPLevel VALUES (20, 200000);

INSERT INTO PlayerCharacter VALUES ('Spready', '34521', 3749, 1);
INSERT INTO PlayerCharacter VALUES ('fangblade', '432567', 5432, 18);
INSERT INTO PlayerCharacter VALUES ('oopokays', '887', 0, 1);
INSERT INTO PlayerCharacter VALUES ('yorroy', '12144', 0, 1);
INSERT INTO PlayerCharacter VALUES ('SergRyu', '155', 50, 1);
INSERT INTO PlayerCharacter VALUES ('Doublelift', '1122', 13456, 19);
INSERT INTO PlayerCharacter VALUES ('KumaClub', '33579', 3749, 18);
INSERT INTO PlayerCharacter VALUES ('kittyx', '863', 1949754, 13);
INSERT INTO PlayerCharacter VALUES ('cinnabunz', '4567', 2614681, 14);
INSERT INTO PlayerCharacter VALUES ('Emiru', '26227', 24194, 10);
INSERT INTO PlayerCharacter VALUES ('Faker', '10000', 245608778, 13);
INSERT INTO PlayerCharacter VALUES ('FrameArms', '27493', 278401, 16);
INSERT INTO PlayerCharacter VALUES ('RetroMuse', '432', 264, 4);
INSERT INTO PlayerCharacter VALUES ('Dunkey', '20958', 20855, 14);
INSERT INTO PlayerCharacter VALUES ('ZyraPlant', '8644', 108752, 13);
INSERT INTO PlayerCharacter VALUES ('Lilyyyxx', '78', 2948, 16);
INSERT INTO PlayerCharacter VALUES ('Geegee', '1098', 29957, 5);
INSERT INTO PlayerCharacter VALUES ('UberHaxor', '15624', 40099932, 20);

INSERT INTO Assassin VALUES ('155', 0);
INSERT INTO Assassin VALUES ('34521', 10);
INSERT INTO Assassin VALUES ('432567', 180);
INSERT INTO Assassin VALUES ('1122', 180);
INSERT INTO Assassin VALUES ('33579', 270);
INSERT INTO Assassin VALUES ('863', 100);

INSERT INTO Warrior VALUES ('887', 0);
INSERT INTO Warrior VALUES ('4567', 360);
INSERT INTO Warrior VALUES ('26227', 300);
INSERT INTO Warrior VALUES ('10000', 500);
INSERT INTO Warrior VALUES ('27493', 430);
INSERT INTO Warrior VALUES ('432', 40);

INSERT INTO Mage VALUES ('12144', NULL);
INSERT INTO Mage VALUES ('20958', 'Flash Frost');
INSERT INTO Mage VALUES ('8644', 'Deception Orb');
INSERT INTO Mage VALUES ('78', 'Bouncing Blade');
INSERT INTO Mage VALUES ('1098', 'Light Binding');
INSERT INTO Mage VALUES ('15624', 'Pyroblast');

INSERT INTO GamesWith VALUES ('20958', 'YTCrew', '15624');
INSERT INTO GamesWith VALUES ('8644', 'MusicTime', '432');
INSERT INTO GamesWith VALUES ('78', 'MapleMaple', '432567');
INSERT INTO GamesWith VALUES ('1098', 'Freelo', '26227');
INSERT INTO GamesWith VALUES ('34521', 'Buds', '15624');
INSERT INTO GamesWith VALUES ('432', 'PCMR', '4567');

INSERT INTO NPCQuestXP VALUES ('Travel 5,000 km', 1000);
INSERT INTO NPCQuestXP VALUES ('Buy a weapon from any weapon store', 300);
INSERT INTO NPCQuestXP VALUES ('Catch a salmon from any stream', 500);
INSERT INTO NPCQuestXP VALUES ('Fight 10 Level 20 monsters', 3000);
INSERT INTO NPCQuestXP VALUES ('Create a party with two buddies', 5000);
INSERT INTO NPCQuestXP VALUES ('Complete any boss raid with a buddy', 5000);
INSERT INTO NPCQuestXP VALUES ('Gather 3000 wood', 750);
INSERT INTO NPCQuestXP VALUES ('Craft gold armor', 1000);

INSERT INTO Locations VALUES ('Ludi', 'Temperate forest');
INSERT INTO Locations VALUES ('Kerning', 'Taiga');
INSERT INTO Locations VALUES ('Ellinia', 'Swamp');
INSERT INTO Locations VALUES ('Henney', 'Grassland');
INSERT INTO Locations VALUES ('Perion', 'Desert');

INSERT INTO Shop_IsIn VALUES ('PotionZ', 'Ludi', 'Potion', 20);
INSERT INTO Shop_IsIn VALUES ('PowerSurge', 'Kerning', 'Weapon', 50);
INSERT INTO Shop_IsIn VALUES ('Magix', 'Ellinia', 'Magic', 120);
INSERT INTO Shop_IsIn VALUES ('ShieldsUp', 'Henney', 'Armor', 50);
INSERT INTO Shop_IsIn VALUES ('Chargers', 'Kerning', 'Armor', 100);
INSERT INTO Shop_IsIn VALUES ('Unlost', 'Kerning', 'Potion', 30);
INSERT INTO Shop_IsIn VALUES ('Armure', 'Perion', 'Armor', 100);
INSERT INTO Shop_IsIn VALUES ('SpellingsBees', 'Ellinia', 'Magic', 50);

INSERT INTO Item_Equips_Sells VALUES (5, '17894', '+10 Health from potion', 'PotionZ', 'Ludi', '34521');
INSERT INTO Item_Equips_Sells VALUES (200, '18849', '+2 Attack', 'PowerSurge', 'Kerning', '33579');
INSERT INTO Item_Equips_Sells VALUES (500, '98392', '+3 Effectiveness on Primary Spell', 'SpellingsBees', 'Ellinia', '1122');
INSERT INTO Item_Equips_Sells VALUES (800, '1984', '+3000 Health from potion', 'PotionZ', 'Ludi', '78');
INSERT INTO Item_Equips_Sells VALUES (200, '324', '+2 Defense', 'ShieldsUp', 'Henney', '10000');
INSERT INTO Item_Equips_Sells VALUES (432, '564', '+200 health', 'PotionZ', 'Ludi', '1122');
INSERT INTO Item_Equips_Sells VALUES (206900, '193', '+20 Attack', 'Chargers', 'Kerning', '10000');
INSERT INTO Item_Equips_Sells VALUES (345, '532', '+1 Attack', 'Chargers', 'Kerning', '4567');
INSERT INTO Item_Equips_Sells VALUES (25662, '314', '+7 Defense', 'ShieldsUp', 'Henney','26227');
INSERT INTO Item_Equips_Sells VALUES (2377, '211', '+3 Attack', 'Unlost', 'Kerning','863');
INSERT INTO Item_Equips_Sells VALUES (4000, '15699', '+20 Illumination for Dark Locations', 'Unlost', 'Kerning', '4567');
INSERT INTO Item_Equips_Sells VALUES (186362, '5332', '+15 Defense', 'Armure', 'Perion', '26227');

INSERT INTO NonPlayerCharacter_Gives VALUES ('Marzia', 'Travel 5,000 km', '17894');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Eren', 'Buy a weapon from any weapon store', '18849');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Nami', 'Catch a salmon from any stream', '98392');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Chika', 'Fight 10 Level 20 monsters', '1984');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Erwin', 'Create a party with two buddies', '324');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Viego', 'Complete any boss raid with a buddy', '193');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Braum', 'Gather 3000 wood', '15699');
INSERT INTO NonPlayerCharacter_Gives VALUES ('Ornn', 'Craft gold armor', '5332');

INSERT INTO Converses VALUES ('34521', TO_DATE('2020/12/24', 'yyyy/mm/dd'), 'Marzia');
INSERT INTO Converses VALUES ('33579', TO_DATE('2010/06/22', 'yyyy/mm/dd'), 'Eren');
INSERT INTO Converses VALUES ('1122', TO_DATE('2013/01/30', 'yyyy/mm/dd'), 'Nami');
INSERT INTO Converses VALUES ('78', TO_DATE('2021/02/10', 'yyyy/mm/dd'), 'Chika');
INSERT INTO Converses VALUES ('10000', TO_DATE('2019/09/07', 'yyyy/mm/dd'), 'Erwin');
INSERT INTO Converses VALUES ('10000', TO_DATE('2019/09/07', 'yyyy/mm/dd'), 'Viego');
INSERT INTO Converses VALUES ('4567', TO_DATE('2015/10/18', 'yyyy/mm/dd'), 'Braum');
INSERT INTO Converses VALUES ('26227', TO_DATE('2020/07/29', 'yyyy/mm/dd'), 'Ornn');

INSERT INTO Events VALUES ('Magicians’ Arena', TO_DATE('2019/10/03', 'yyyy/mm/dd'), TO_DATE('2019/10/13', 'yyyy/mm/dd'));
INSERT INTO Events VALUES ('Every Potion We’ve Got', TO_DATE('2014/06/25', 'yyyy/mm/dd'), TO_DATE('2014/06/28', 'yyyy/mm/dd'));
INSERT INTO Events VALUES ('Assassin Power Surge', TO_DATE('2020/09/10', 'yyyy/mm/dd'), TO_DATE('2020/10/10', 'yyyy/mm/dd'));
INSERT INTO Events VALUES ('Scare Away the Darkness', TO_DATE('2021/01/01', 'yyyy/mm/dd'), TO_DATE('2021/01/15', 'yyyy/mm/dd'));
INSERT INTO Events VALUES ('Hold The Door', TO_DATE('2016/05/22', 'yyyy/mm/dd'), TO_DATE('2016/05/23', 'yyyy/mm/dd'));

INSERT INTO Rewards VALUES ('98392', 'Magicians’ Arena', TO_DATE('2019/10/03', 'yyyy/mm/dd'), TO_DATE('2019/10/13', 'yyyy/mm/dd'));
INSERT INTO Rewards VALUES ('1984', 'Every Potion We’ve Got', TO_DATE('2014/06/25', 'yyyy/mm/dd'), TO_DATE('2014/06/28', 'yyyy/mm/dd'));
INSERT INTO Rewards VALUES ('193', 'Assassin Power Surge', TO_DATE('2020/09/10', 'yyyy/mm/dd'), TO_DATE('2020/10/10', 'yyyy/mm/dd'));
INSERT INTO Rewards VALUES ('15699', 'Scare Away the Darkness', TO_DATE('2021/01/01', 'yyyy/mm/dd'), TO_DATE('2021/01/15', 'yyyy/mm/dd'));
INSERT INTO Rewards VALUES ('5332', 'Hold The Door', TO_DATE('2016/05/22', 'yyyy/mm/dd'), TO_DATE('2016/05/23', 'yyyy/mm/dd'));

INSERT INTO BuysFrom VALUES ('8644', 'Chargers', 'Kerning');
INSERT INTO BuysFrom VALUES ('8644', 'Magix', 'Ellinia');
INSERT INTO BuysFrom VALUES ('8644', 'PotionZ', 'Ludi');
INSERT INTO BuysFrom VALUES ('8644', 'ShieldsUp', 'Henney');
INSERT INTO BuysFrom VALUES ('8644', 'Armure', 'Perion');
INSERT INTO BuysFrom VALUES ('78', 'Magix', 'Ellinia');
INSERT INTO BuysFrom VALUES ('1098', 'ShieldsUp', 'Henney');
INSERT INTO BuysFrom VALUES ('863', 'PotionZ', 'Ludi');
INSERT INTO BuysFrom VALUES ('20958', 'SpellingsBees', 'Ellinia');
INSERT INTO BuysFrom VALUES ('15624', 'Unlost', 'Kerning');
INSERT INTO BuysFrom VALUES ('34521', 'Armure', 'Perion');
INSERT INTO BuysFrom VALUES ('10000', 'PowerSurge', 'Kerning');

INSERT INTO Completes VALUES ('Ludi', '1098');
INSERT INTO Completes VALUES ('Kerning', '863');
INSERT INTO Completes VALUES ('Ellinia', '20958');
INSERT INTO Completes VALUES ('Henney', '15624');
INSERT INTO Completes VALUES ('Perion', '34521');
INSERT INTO Completes VALUES ('Perion', '10000');

INSERT INTO MLevelRewardHealth VALUES (1, 5, 5, NULL, 10);
INSERT INTO MLevelRewardHealth VALUES (5, 15, 15, 17894, 85);
INSERT INTO MLevelRewardHealth VALUES (10, 125 , 50 , 18849, 220);
INSERT INTO MLevelRewardHealth VALUES (35, 300, 150, 324, 70000);
INSERT INTO MLevelRewardHealth VALUES (50, 500, 800, 98392, 500550);
INSERT INTO MLevelRewardHealth VALUES (66, 1000, 1400, 1984, 700950);
INSERT INTO MLevelRewardHealth VALUES (83, 1500, 2500, 314, 900000);
INSERT INTO MLevelRewardHealth VALUES (95, 1800, 3100, 15699, 1100500);
INSERT INTO MLevelRewardHealth VALUES (100, 2000, 3800, 5332, 1500000);

INSERT INTO Monster_isAt VALUES ('Yordle', '3017', 'Normal', 1, 'Henney');
INSERT INTO Monster_isAt VALUES ('Treeant', '2223', 'Wind', 5, 'Henney');
INSERT INTO Monster_isAt VALUES ('Orc', '1231', 'Earth', 10, 'Perion');
INSERT INTO Monster_isAt VALUES ('Angel', '1155', 'Ice', 35, 'Kerning');
INSERT INTO Monster_isAt VALUES ('Demon', '2518', 'Fire', 50, 'Perion');
INSERT INTO Monster_isAt VALUES ('Mermaid', '6687', 'Water', 66, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Elf', '1353', 'Electric', 83, 'Perion');
INSERT INTO Monster_isAt VALUES ('Bug', '9521', 'Poison', 95, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Dragon', '1562', 'Psychic', 100, 'Kerning');
INSERT INTO Monster_isAt VALUES ('Mermaid', '1345', 'Ice', 66, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Elf', '7754', 'Fire', 83, 'Perion');
INSERT INTO Monster_isAt VALUES ('Bug', '8319', 'Wind', 95, 'Ellinia');
INSERT INTO Monster_isAt VALUES ('Dragon', '6744', 'Ice', 100, 'Kerning');

INSERT INTO Fights VALUES ('3017', '34521');
INSERT INTO Fights VALUES ('2223', '33579');
INSERT INTO Fights VALUES ('1231', '1122');
INSERT INTO Fights VALUES ('1155', '78');
INSERT INTO Fights VALUES ('2518', '10000');
INSERT INTO Fights VALUES ('6687', '10000');
INSERT INTO Fights VALUES ('1353', '4567');
INSERT INTO Fights VALUES ('9521', '26227');


INSERT INTO Quest_Contains VALUES ('Cast all the Spells', 'Cast 20 unique spells in a party raid',
                                   'An Ice or Fire spell scroll', 'Magicians’ Arena', TO_DATE('2019/10/03', 'yyyy/mm/dd'), TO_DATE('2019/10/13', 'yyyy/mm/dd'));
INSERT INTO Quest_Contains VALUES ('Best Potions', 'Farm 15 potions from a Mermaid',
                                   '3 Double XP Boost Potions', 'Every Potion We’ve Got', TO_DATE('2014/06/25', 'yyyy/mm/dd'), TO_DATE('2014/06/28', 'yyyy/mm/dd'));
INSERT INTO Quest_Contains VALUES ('So Much Power', 'Win a 1v1 against a higher level player',
                                   'Attack power scroll', 'Assassin Power Surge', TO_DATE('2020/09/10', 'yyyy/mm/dd'), TO_DATE('2020/10/10', 'yyyy/mm/dd'));
INSERT INTO Quest_Contains VALUES ('Good Vision', 'Fight 50 monsters under a campfire',
                                   'Illumination potion lasting 1 hr', 'Scare Away the Darkness',
                                   TO_DATE('2021/01/01', 'yyyy/mm/dd'), TO_DATE('2021/01/15', 'yyyy/mm/dd'));
INSERT INTO Quest_Contains VALUES ('Duty Comes First', 'Resurrect 5 friends',
                                   'Badge of Honour Icon', 'Hold The Door', TO_DATE('2016/05/22', 'yyyy/mm/dd'), TO_DATE('2016/05/23', 'yyyy/mm/dd'));

INSERT INTO Participates VALUES ('Cast all the Spells', '8644', 0);
INSERT INTO Participates VALUES ('Best Potions', '8644', 0);
INSERT INTO Participates VALUES ('So Much Power', '1098', 1);
INSERT INTO Participates VALUES ('Good Vision', '863', 1);
INSERT INTO Participates VALUES ('Duty Comes First', '20958', 0);
INSERT INTO Participates VALUES ('Cast all the Spells', '15624', 1);
INSERT INTO Participates VALUES ('Best Potions', '34521', 0);
INSERT INTO Participates VALUES ('So Much Power','10000', 1);
INSERT INTO Participates VALUES ('Good Vision','33579', 1);
INSERT INTO Participates VALUES ('Duty Comes First', '1122', 0);