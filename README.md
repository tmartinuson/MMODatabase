# CPSC304Project_project_a9r2b_c9v2b_k4u3u

## Group members: Yukie Man, Tristan Martinuson, Clare Tuch

Project setup: Run start databaseSetup.sql in SQL+ to populate the tables from the file.

Runnable class: Game Manager

Options for Warrior ids: 887, 4567, 26227, 10000, 27493, 432

Options for Location Names (case sensitive): Ludi, Kerning, Ellinia, Henney, Perion

### SQL Plus commands to check INSERT/DELETE/UPDATE

Insert: Select * from assassin;

Delete: Select * from warrior;
        Select * from playercharacter where id = ?; // replace ? with the id you have removed

Update: Select * from locations;

