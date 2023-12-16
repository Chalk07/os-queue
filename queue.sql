CREATE TABLE IF NOT EXISTS `priority` (
      `id` INT(11) NOT NULL AUTO_INCREMENT,
      `license` VARCHAR(50) NOT NULL,
      `priority_level` INT(10) NOT NULL DEFAULT '0',
      PRIMARY KEY (`id`)
) ENGINE=InnoDB;
