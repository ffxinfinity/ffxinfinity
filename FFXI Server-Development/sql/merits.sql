/*
MySQL Data Transfer
Source Host: localhost
Source Database: dspdb
Target Host: localhost
Target Database: dspdb
Date: 2/16/2013 9:54:02 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for merits
-- ----------------------------
DROP TABLE IF EXISTS `merits`;
CREATE TABLE `merits` (
  `meritid` smallint(5) unsigned NOT NULL,
  `name` char(25) NOT NULL,
  `upgrade` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `value` smallint(5) NOT NULL DEFAULT '0',
  `jobs` int(10) unsigned NOT NULL DEFAULT '0',
  `upgradeid` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `catagoryid` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`meritid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `merits` VALUES ('64', 'max_hp', '8', '10', '1048575', '0', '0');
INSERT INTO `merits` VALUES ('66', 'max_mp', '8', '10', '1048575', '0', '0');
INSERT INTO `merits` VALUES ('128', 'str', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('130', 'dex', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('132', 'vit', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('134', 'agi', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('136', 'int', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('138', 'mnd', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('140', 'chr', '5', '1', '1048575', '1', '1');
INSERT INTO `merits` VALUES ('192', 'h2h', '8', '2', '397347', '2', '2');
INSERT INTO `merits` VALUES ('194', 'dagger', '8', '2', '1015801', '2', '2');
INSERT INTO `merits` VALUES ('196', 'sword', '8', '2', '376817', '2', '2');
INSERT INTO `merits` VALUES ('198', 'gsword', '8', '2', '193', '2', '2');
INSERT INTO `merits` VALUES ('200', 'axe', '8', '2', '1409', '2', '2');
INSERT INTO `merits` VALUES ('202', 'gaxe', '8', '2', '129', '2', '2');
INSERT INTO `merits` VALUES ('204', 'scythe', '8', '2', '393', '2', '2');
INSERT INTO `merits` VALUES ('206', 'polearm', '8', '2', '10305', '2', '2');
INSERT INTO `merits` VALUES ('208', 'katana', '8', '2', '4096', '2', '2');
INSERT INTO `merits` VALUES ('210', 'gkatana', '8', '2', '6144', '2', '2');
INSERT INTO `merits` VALUES ('212', 'club', '8', '2', '720895', '2', '2');
INSERT INTO `merits` VALUES ('214', 'staff', '8', '2', '549455', '2', '2');
INSERT INTO `merits` VALUES ('216', 'archery', '8', '2', '7217', '2', '2');
INSERT INTO `merits` VALUES ('218', 'marksmanship', '8', '2', '70817', '2', '2');
INSERT INTO `merits` VALUES ('220', 'throwing', '8', '2', '990783', '2', '2');
INSERT INTO `merits` VALUES ('222', 'guarding_skill', '4', '2', '131074', '3', '2');
INSERT INTO `merits` VALUES ('224', 'evasion_skill', '4', '2', '1048575', '3', '2');
INSERT INTO `merits` VALUES ('226', 'shield_skill', '4', '2', '373', '3', '2');
INSERT INTO `merits` VALUES ('228', 'parrying_skill', '4', '2', '1031155', '3', '2');
INSERT INTO `merits` VALUES ('256', 'divine', '8', '2', '524372', '4', '3');
INSERT INTO `merits` VALUES ('258', 'healing', '8', '2', '524372', '4', '3');
INSERT INTO `merits` VALUES ('260', 'enhancing', '8', '2', '524380', '4', '3');
INSERT INTO `merits` VALUES ('262', 'enfeebling', '8', '2', '524444', '4', '3');
INSERT INTO `merits` VALUES ('264', 'elemental', '8', '2', '524440', '4', '3');
INSERT INTO `merits` VALUES ('266', 'dark', '8', '2', '524440', '4', '3');
INSERT INTO `merits` VALUES ('268', 'summoning', '8', '2', '16384', '4', '3');
INSERT INTO `merits` VALUES ('270', 'ninjitsu', '8', '2', '4096', '4', '3');
INSERT INTO `merits` VALUES ('272', 'singing', '8', '2', '512', '4', '3');
INSERT INTO `merits` VALUES ('274', 'string', '8', '2', '512', '4', '3');
INSERT INTO `merits` VALUES ('276', 'wind', '8', '2', '512', '4', '3');
INSERT INTO `merits` VALUES ('278', 'blue', '8', '2', '32768', '4', '3');
INSERT INTO `merits` VALUES ('320', 'enmity_increase', '5', '1', '1048575', '5', '4');
INSERT INTO `merits` VALUES ('322', 'enmity_decrease', '5', '1', '1048575', '5', '4');
INSERT INTO `merits` VALUES ('324', 'crit_hit_rate', '5', '1', '1048575', '5', '4');
INSERT INTO `merits` VALUES ('326', 'enemy_crit_rate', '5', '1', '1048575', '5', '4');
INSERT INTO `merits` VALUES ('328', 'spell_interuption_rate', '5', '2', '1048575', '5', '4');
INSERT INTO `merits` VALUES ('384', 'beserk_recast', '5', '10', '1', '6', '5');
INSERT INTO `merits` VALUES ('386', 'defender_recast', '5', '6', '1', '6', '5');
INSERT INTO `merits` VALUES ('388', 'warcry_recast', '5', '10', '1', '6', '5');
INSERT INTO `merits` VALUES ('390', 'aggressor_recast', '5', '10', '1', '6', '5');
INSERT INTO `merits` VALUES ('392', 'double_attack_rate', '5', '1', '1', '6', '5');
INSERT INTO `merits` VALUES ('448', 'focus_recast', '5', '10', '2', '6', '6');
INSERT INTO `merits` VALUES ('450', 'dodge_recast', '5', '10', '2', '6', '6');
INSERT INTO `merits` VALUES ('452', 'chakra_recast', '5', '10', '2', '6', '6');
INSERT INTO `merits` VALUES ('454', 'counter_rate', '5', '1', '2', '6', '6');
INSERT INTO `merits` VALUES ('456', 'kick_attack_rate', '5', '1', '2', '6', '6');
INSERT INTO `merits` VALUES ('512', 'divine_seal_recast', '5', '20', '4', '6', '7');
INSERT INTO `merits` VALUES ('514', 'cure_cast_time', '5', '4', '4', '6', '7');
INSERT INTO `merits` VALUES ('516', 'bar_spell_effect', '5', '2', '4', '6', '7');
INSERT INTO `merits` VALUES ('518', 'banish_effect', '5', '2', '4', '6', '7');
INSERT INTO `merits` VALUES ('520', 'regen_effect', '5', '1', '4', '6', '7');
INSERT INTO `merits` VALUES ('576', 'elemental_seal_recast', '5', '20', '8', '6', '8');
INSERT INTO `merits` VALUES ('578', 'fire_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('580', 'ice_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('582', 'wind_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('584', 'earth_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('586', 'lightning_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('588', 'water_magic_potency', '5', '2', '8', '6', '8');
INSERT INTO `merits` VALUES ('640', 'convert_recast', '5', '20', '16', '6', '9');
INSERT INTO `merits` VALUES ('642', 'fire_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('644', 'ice_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('646', 'wind_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('648', 'earth_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('650', 'lightning_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('652', 'water_magic_accuracy', '5', '3', '16', '6', '9');
INSERT INTO `merits` VALUES ('704', 'flee_recast', '5', '10', '32', '6', '10');
INSERT INTO `merits` VALUES ('706', 'hide_recast', '5', '10', '32', '6', '10');
INSERT INTO `merits` VALUES ('708', 'sneak_attack_recast', '5', '2', '32', '6', '10');
INSERT INTO `merits` VALUES ('710', 'trick_attack_recast', '5', '2', '32', '6', '10');
INSERT INTO `merits` VALUES ('712', 'triple_attack_rate', '5', '1', '32', '6', '10');
INSERT INTO `merits` VALUES ('768', 'shield_bash_recast', '5', '6', '64', '6', '11');
INSERT INTO `merits` VALUES ('770', 'holy_circle_recast', '5', '10', '64', '6', '11');
INSERT INTO `merits` VALUES ('772', 'sentinel_recast', '5', '10', '64', '6', '11');
INSERT INTO `merits` VALUES ('774', 'cover_effect_length', '5', '4', '64', '6', '11');
INSERT INTO `merits` VALUES ('776', 'rampart_recast', '5', '10', '64', '6', '11');
INSERT INTO `merits` VALUES ('832', 'souleater_recast', '5', '12', '128', '6', '12');
INSERT INTO `merits` VALUES ('834', 'arcane_circle_recast', '5', '10', '128', '6', '12');
INSERT INTO `merits` VALUES ('836', 'last_resort_recast', '5', '10', '128', '6', '12');
INSERT INTO `merits` VALUES ('838', 'last_resort_effect', '5', '2', '128', '6', '12');
INSERT INTO `merits` VALUES ('840', 'weapon_bash_effect', '5', '6', '128', '6', '12');
INSERT INTO `merits` VALUES ('896', 'killer_effects', '5', '1', '256', '6', '13');
INSERT INTO `merits` VALUES ('898', 'reward_recast', '5', '3', '256', '6', '13');
INSERT INTO `merits` VALUES ('900', 'call_beast_recast', '5', '10', '256', '6', '13');
INSERT INTO `merits` VALUES ('902', 'sic_recast', '5', '2', '256', '6', '13');
INSERT INTO `merits` VALUES ('904', 'tame_recast', '5', '20', '256', '6', '13');
INSERT INTO `merits` VALUES ('960', 'lullaby_recast', '5', '1', '512', '6', '14');
INSERT INTO `merits` VALUES ('962', 'finale_recast', '5', '1', '512', '6', '14');
INSERT INTO `merits` VALUES ('964', 'minne_effect', '5', '1', '512', '6', '14');
INSERT INTO `merits` VALUES ('966', 'minuet_effect', '5', '1', '512', '6', '14');
INSERT INTO `merits` VALUES ('968', 'madrigal_effect', '5', '1', '512', '6', '14');
INSERT INTO `merits` VALUES ('1024', 'scavenge_recast', '5', '10', '1024', '6', '15');
INSERT INTO `merits` VALUES ('1026', 'camouflage_recast', '5', '10', '1024', '6', '15');
INSERT INTO `merits` VALUES ('1028', 'sharpshot_recast', '5', '10', '1024', '6', '15');
INSERT INTO `merits` VALUES ('1030', 'unlimited_shot_recast', '5', '6', '1024', '6', '15');
INSERT INTO `merits` VALUES ('1032', 'rapid_shot_rate', '5', '1', '1024', '6', '15');
INSERT INTO `merits` VALUES ('1088', 'third_eye_recast', '5', '2', '2048', '6', '16');
INSERT INTO `merits` VALUES ('1090', 'warding_circle_recast', '5', '10', '2048', '6', '16');
INSERT INTO `merits` VALUES ('1092', 'store_tp_effect', '5', '2', '2048', '6', '16');
INSERT INTO `merits` VALUES ('1094', 'meditate_recast', '5', '6', '2048', '6', '16');
INSERT INTO `merits` VALUES ('1096', 'zashin_attack_rate', '5', '1', '2048', '6', '16');
INSERT INTO `merits` VALUES ('1152', 'subtle_blow_effect', '5', '1', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1154', 'katon_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1156', 'hyoton_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1158', 'huton_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1160', 'doton_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1162', 'raiton_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1164', 'suiton_effect', '5', '2', '4096', '6', '17');
INSERT INTO `merits` VALUES ('1216', 'ancient_circle_recast', '5', '10', '8192', '6', '18');
INSERT INTO `merits` VALUES ('1218', 'jump_recast', '5', '2', '8192', '6', '18');
INSERT INTO `merits` VALUES ('1220', 'high_jump_recast', '5', '4', '8192', '6', '18');
INSERT INTO `merits` VALUES ('1222', 'super_jump_recast', '5', '6', '8192', '6', '18');
INSERT INTO `merits` VALUES ('1224', 'spirit_link_recast', '5', '3', '8192', '6', '18');
INSERT INTO `merits` VALUES ('1280', 'avatar_physical_accuracy', '5', '3', '16384', '6', '19');
INSERT INTO `merits` VALUES ('1282', 'avatar_physical_attack', '5', '2', '16384', '6', '19');
INSERT INTO `merits` VALUES ('1284', 'avatar_magical_accuracy', '5', '3', '16384', '6', '19');
INSERT INTO `merits` VALUES ('1286', 'avatar_magical_attack', '5', '2', '16384', '6', '19');
INSERT INTO `merits` VALUES ('1288', 'summoning_magic_cast_time', '5', '5', '16384', '6', '19');
INSERT INTO `merits` VALUES ('1344', 'chain_affinity_recast', '5', '4', '32768', '6', '20');
INSERT INTO `merits` VALUES ('1346', 'burst_affinity_recast', '5', '4', '32768', '6', '20');
INSERT INTO `merits` VALUES ('1348', 'monster_correlation', '5', '4', '32768', '6', '20');
INSERT INTO `merits` VALUES ('1350', 'physical_potency', '5', '2', '32768', '6', '20');
INSERT INTO `merits` VALUES ('1352', 'magical_accuracy', '5', '2', '32768', '6', '20');
INSERT INTO `merits` VALUES ('1408', 'phantom_roll_recast', '5', '2', '65536', '6', '21');
INSERT INTO `merits` VALUES ('1410', 'quick_draw_recast', '5', '2', '65536', '6', '21');
INSERT INTO `merits` VALUES ('1412', 'quick_draw_accuracy', '5', '2', '65536', '6', '21');
INSERT INTO `merits` VALUES ('1414', 'random_deal_recast', '5', '40', '65536', '6', '21');
INSERT INTO `merits` VALUES ('1416', 'bust_duration', '5', '10', '65536', '6', '21');
INSERT INTO `merits` VALUES ('1472', 'automation_melee_skill', '5', '2', '131072', '6', '22');
INSERT INTO `merits` VALUES ('1474', 'automation_ranged_skill', '5', '2', '131072', '6', '22');
INSERT INTO `merits` VALUES ('1476', 'automation_magic_skill', '5', '2', '131072', '6', '22');
INSERT INTO `merits` VALUES ('1478', 'activate_recast', '5', '40', '131072', '6', '22');
INSERT INTO `merits` VALUES ('1480', 'repair_recast', '5', '6', '131072', '6', '22');
INSERT INTO `merits` VALUES ('1536', 'step_accuracy', '5', '3', '262144', '6', '23');
INSERT INTO `merits` VALUES ('1538', 'haste_samba_effect', '5', '1', '262144', '6', '23');
INSERT INTO `merits` VALUES ('1540', 'reverse_flourish_effect', '5', '3', '262144', '6', '23');
INSERT INTO `merits` VALUES ('1542', 'building_flourish_effect', '5', '2', '262144', '6', '23');
INSERT INTO `merits` VALUES ('1600', 'grimoire_recast', '5', '2', '524288', '6', '24');
INSERT INTO `merits` VALUES ('1602', 'modus_veritas_duration', '5', '1', '524288', '6', '24');
INSERT INTO `merits` VALUES ('1604', 'helix_magic_acc_att', '5', '1', '524288', '6', '24');
INSERT INTO `merits` VALUES ('1606', 'max_sublimation', '5', '10', '524288', '6', '24');
INSERT INTO `merits` VALUES ('1664', 'shijin_spiral', '1', '1', '131074', '0', '25');
INSERT INTO `merits` VALUES ('1666', 'exenterator', '1', '1', '333617', '0', '25');
INSERT INTO `merits` VALUES ('1668', 'requiescat', '1', '1', '113361', '0', '25');
INSERT INTO `merits` VALUES ('1670', 'resolution', '1', '1', '193', '0', '25');
INSERT INTO `merits` VALUES ('1672', 'ruinator', '1', '1', '1409', '0', '25');
INSERT INTO `merits` VALUES ('1674', 'upheaval', '1', '1', '129', '0', '25');
INSERT INTO `merits` VALUES ('1676', 'entropy', '1', '1', '385', '0', '25');
INSERT INTO `merits` VALUES ('1678', 'stardiver', '1', '1', '10241', '0', '25');
INSERT INTO `merits` VALUES ('1680', 'blade_shun', '1', '1', '4096', '0', '25');
INSERT INTO `merits` VALUES ('1682', 'tachi_shoha', '1', '1', '2048', '0', '25');
INSERT INTO `merits` VALUES ('1684', 'realmrazor', '1', '1', '573519', '0', '25');
INSERT INTO `merits` VALUES ('1686', 'shattersoul', '1', '1', '549455', '0', '25');
INSERT INTO `merits` VALUES ('1688', 'apex_arrow', '1', '1', '3072', '0', '25');
INSERT INTO `merits` VALUES ('1690', 'last_stand', '1', '1', '66592', '0', '25');
INSERT INTO `merits` VALUES ('2048', 'warriors_charge', '5', '5', '1', '7', '31');
INSERT INTO `merits` VALUES ('2050', 'tomahawk', '5', '15', '1', '7', '31');
INSERT INTO `merits` VALUES ('2052', 'savagery', '5', '10', '1', '7', '31');
INSERT INTO `merits` VALUES ('2054', 'aggressive_aim', '5', '4', '1', '7', '31');
INSERT INTO `merits` VALUES ('2112', 'mantra', '5', '4', '2', '7', '32');
INSERT INTO `merits` VALUES ('2114', 'formless_strikes', '5', '5', '2', '7', '32');
INSERT INTO `merits` VALUES ('2116', 'invigorate', '5', '24', '2', '7', '32');
INSERT INTO `merits` VALUES ('2118', 'penance', '5', '20', '2', '7', '32');
INSERT INTO `merits` VALUES ('2176', 'martyr', '5', '5', '4', '7', '33');
INSERT INTO `merits` VALUES ('2178', 'devotion', '5', '5', '4', '7', '33');
INSERT INTO `merits` VALUES ('2180', 'protectra_v', '5', '5', '4', '7', '33');
INSERT INTO `merits` VALUES ('2182', 'shellra_v', '5', '2', '4', '7', '33');
INSERT INTO `merits` VALUES ('2240', 'flare_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2242', 'freeze_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2244', 'tornado_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2246', 'quake_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2248', 'burst_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2250', 'flood_ii', '5', '5', '8', '7', '34');
INSERT INTO `merits` VALUES ('2304', 'dia_iii', '5', '30', '16', '7', '35');
INSERT INTO `merits` VALUES ('2306', 'slow_ii', '5', '1', '16', '7', '35');
INSERT INTO `merits` VALUES ('2308', 'paralyze_ii', '5', '5', '16', '7', '35');
INSERT INTO `merits` VALUES ('2310', 'phalanx_ii', '5', '3', '16', '7', '35');
INSERT INTO `merits` VALUES ('2312', 'bio_iii', '5', '30', '16', '7', '35');
INSERT INTO `merits` VALUES ('2314', 'blind_ii', '5', '5', '16', '7', '35');
INSERT INTO `merits` VALUES ('2368', 'assassins_charge', '5', '5', '32', '7', '36');
INSERT INTO `merits` VALUES ('2370', 'feint', '5', '25', '32', '7', '36');
INSERT INTO `merits` VALUES ('2372', 'aura_steal', '5', '20', '32', '7', '36');
INSERT INTO `merits` VALUES ('2374', 'ambush', '5', '3', '32', '7', '36');
INSERT INTO `merits` VALUES ('2432', 'fealty', '5', '5', '64', '7', '37');
INSERT INTO `merits` VALUES ('2434', 'chivalry', '5', '25', '64', '7', '37');
INSERT INTO `merits` VALUES ('2436', 'iron_will', '5', '20', '64', '7', '37');
INSERT INTO `merits` VALUES ('2438', 'guardian', '5', '1', '64', '7', '37');
INSERT INTO `merits` VALUES ('2496', 'dark_seal', '5', '1', '128', '7', '38');
INSERT INTO `merits` VALUES ('2498', 'diabolic_eye', '5', '5', '128', '7', '38');
INSERT INTO `merits` VALUES ('2500', 'muted_soul', '5', '10', '128', '7', '38');
INSERT INTO `merits` VALUES ('2502', 'desperate_blows', '5', '50', '128', '7', '38');
INSERT INTO `merits` VALUES ('2560', 'feral_howl', '5', '5', '256', '7', '39');
INSERT INTO `merits` VALUES ('2562', 'killer_instinct', '5', '10', '256', '7', '39');
INSERT INTO `merits` VALUES ('2564', 'beast_affinity', '5', '2', '256', '7', '39');
INSERT INTO `merits` VALUES ('2566', 'beast_healer', '5', '1', '256', '7', '39');
INSERT INTO `merits` VALUES ('2624', 'nightingale', '5', '25', '512', '7', '40');
INSERT INTO `merits` VALUES ('2626', 'troubadour', '5', '25', '512', '7', '40');
INSERT INTO `merits` VALUES ('2628', 'foe_sirvente', '5', '5', '512', '7', '40');
INSERT INTO `merits` VALUES ('2630', 'adventurers_dirge', '5', '10', '512', '7', '40');
INSERT INTO `merits` VALUES ('2688', 'stealth_shot', '5', '10', '1024', '7', '41');
INSERT INTO `merits` VALUES ('2690', 'flashy_shot', '5', '1', '1024', '7', '41');
INSERT INTO `merits` VALUES ('2692', 'snapshot', '5', '2', '1024', '7', '41');
INSERT INTO `merits` VALUES ('2694', 'recycle', '5', '5', '1024', '7', '41');
INSERT INTO `merits` VALUES ('2752', 'shikikoyo', '5', '12', '2048', '7', '42');
INSERT INTO `merits` VALUES ('2754', 'blade_bash', '5', '5', '2048', '7', '42');
INSERT INTO `merits` VALUES ('2756', 'ikishoten', '5', '3', '2048', '7', '42');
INSERT INTO `merits` VALUES ('2758', 'overwhelm', '5', '5', '2048', '7', '42');
INSERT INTO `merits` VALUES ('2816', 'sange', '5', '25', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2818', 'ninja_tool_expertise', '5', '5', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2820', 'katon_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2822', 'hyoton_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2824', 'huton_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2826', 'doton_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2828', 'raiton_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2830', 'suiton_san', '5', '1', '4096', '7', '43');
INSERT INTO `merits` VALUES ('2880', 'deep_breathing', '5', '1', '8192', '7', '44');
INSERT INTO `merits` VALUES ('2882', 'angon', '5', '1', '8192', '7', '44');
INSERT INTO `merits` VALUES ('2884', 'empathy', '5', '5', '8192', '7', '44');
INSERT INTO `merits` VALUES ('2886', 'strafe', '5', '5', '8192', '7', '44');
INSERT INTO `merits` VALUES ('2944', 'meteor_strike', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('2946', 'heavenly_strike', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('2948', 'wind_blade', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('2950', 'geocrush', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('2952', 'thunderstorm', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('2954', 'grandfall', '5', '40', '16384', '7', '45');
INSERT INTO `merits` VALUES ('3008', 'convergence', '5', '5', '32768', '7', '46');
INSERT INTO `merits` VALUES ('3010', 'diffusion', '5', '5', '32768', '7', '46');
INSERT INTO `merits` VALUES ('3012', 'enchainment', '5', '10', '32768', '7', '46');
INSERT INTO `merits` VALUES ('3014', 'assimilation', '5', '1', '32768', '7', '46');
INSERT INTO `merits` VALUES ('3072', 'snake_eye', '5', '1', '65536', '7', '47');
INSERT INTO `merits` VALUES ('3074', 'fold', '5', '1', '65536', '7', '47');
INSERT INTO `merits` VALUES ('3076', 'winning_streak', '5', '20', '65536', '7', '47');
INSERT INTO `merits` VALUES ('3078', 'loaded_deck', '5', '10', '65536', '7', '47');
INSERT INTO `merits` VALUES ('3136', 'role_reversal', '5', '1', '131072', '7', '48');
INSERT INTO `merits` VALUES ('3138', 'ventriloquy', '5', '15', '131072', '7', '48');
INSERT INTO `merits` VALUES ('3140', 'fine_tuning', '5', '5', '131072', '7', '48');
INSERT INTO `merits` VALUES ('3142', 'optimization', '5', '5', '131072', '7', '48');
INSERT INTO `merits` VALUES ('3200', 'saber_dance', '5', '5', '262144', '7', '49');
INSERT INTO `merits` VALUES ('3202', 'fan_dance', '5', '5', '262144', '7', '49');
INSERT INTO `merits` VALUES ('3204', 'no_foot_rise', '5', '1', '262144', '7', '49');
INSERT INTO `merits` VALUES ('3206', 'closed_position', '5', '3', '262144', '7', '49');
INSERT INTO `merits` VALUES ('3264', 'altruism', '5', '5', '524288', '7', '50');
INSERT INTO `merits` VALUES ('3266', 'focalization', '5', '5', '524288', '7', '50');
INSERT INTO `merits` VALUES ('3268', 'tranquility', '5', '10', '524288', '7', '50');
INSERT INTO `merits` VALUES ('3270', 'enquanimity', '5', '10', '524288', '7', '50');
INSERT INTO `merits` VALUES ('3272', 'enlightenment', '5', '5', '524288', '7', '50');
INSERT INTO `merits` VALUES ('3274', 'stormsurge', '5', '1', '524288', '7', '50');
