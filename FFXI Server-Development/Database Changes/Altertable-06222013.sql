ALTER TABLE dspdb.char_inventory
 CHANGE signature signature VARCHAR(20),
 ADD augment0 SMALLINT(5) UNSIGNED DEFAULT '0' AFTER worn,
 ADD augment1 SMALLINT(5) UNSIGNED DEFAULT '0',
 ADD augment2 SMALLINT(5) UNSIGNED DEFAULT '0',
 ADD augment4 SMALLINT(5) UNSIGNED DEFAULT '0',
 ADD trialNumber SMALLINT(5) UNSIGNED DEFAULT '0';
 
 ALTER TABLE dspdb.chars
 ADD gmlevel SMALLINT(3) NOT NULL DEFAULT '0' AFTER unlocked_weapons;

 ALTER TABLE dspdb.linkshells
 DROP name,
 CHANGE fullname name VARCHAR(20) NOT NULL;
 
 ALTER TABLE dspdb.mob_skill
 CHANGE mob_skill_name mob_skill_name CHAR(25) ASCII NOT NULL;