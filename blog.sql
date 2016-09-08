/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.10 : Database - nblog
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nblog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `nblog`;

/*Table structure for table `Test` */

DROP TABLE IF EXISTS `Test`;

CREATE TABLE `Test` (
  `a` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_article` */

DROP TABLE IF EXISTS `blog_article`;

CREATE TABLE `blog_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pubDate` datetime DEFAULT NULL,
  `lastModifyDate` datetime DEFAULT NULL,
  `title` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isPrivate` tinyint(1) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0',
  `comments` int(11) NOT NULL DEFAULT '0',
  `summary` varchar(3000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowComment` tinyint(1) NOT NULL DEFAULT '1',
  `art_level` int(11) DEFAULT NULL,
  `art_status` int(11) NOT NULL DEFAULT '0',
  `art_from` int(11) NOT NULL DEFAULT '0',
  `editor` int(11) NOT NULL DEFAULT '0',
  `space_id` int(11) NOT NULL,
  `art_lock` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment_mode` int(11) NOT NULL DEFAULT '0',
  `comment_asc` tinyint(1) NOT NULL DEFAULT '1',
  `comment_allowHtml` tinyint(1) NOT NULL DEFAULT '0',
  `comment_limitCount` int(11) NOT NULL,
  `comment_limitSec` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `space_id` (`space_id`),
  KEY `pubDate_idx` (`pubDate`,`art_level`),
  KEY `pubDate_idx2` (`pubDate`),
  CONSTRAINT `blog_article_ibfk_1` FOREIGN KEY (`space_id`) REFERENCES `blog_space` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_article_tag` */

DROP TABLE IF EXISTS `blog_article_tag`;

CREATE TABLE `blog_article_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `blog_article_tag_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `blog_article_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_comment` */

DROP TABLE IF EXISTS `blog_comment`;

CREATE TABLE `blog_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `parent_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `comment_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`),
  KEY `idx_1` (`parent_path`,`id`),
  KEY `comment_date_idx` (`comment_date`),
  KEY `parent_id_idx` (`parent_id`),
  CONSTRAINT `blog_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `blog_oauth_user` (`id`),
  CONSTRAINT `blog_comment_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_common_file` */

DROP TABLE IF EXISTS `blog_common_file`;

CREATE TABLE `blog_common_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_key` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_extension` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_store` int(11) NOT NULL,
  `file_server` int(11) NOT NULL,
  `file_originalname` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_width` int(11) DEFAULT NULL,
  `file_height` int(11) DEFAULT NULL,
  `file_status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_file` */

DROP TABLE IF EXISTS `blog_file`;

CREATE TABLE `blog_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_parent` int(11) DEFAULT NULL,
  `file_type` int(11) NOT NULL DEFAULT '0',
  `file_createDate` datetime NOT NULL,
  `common_file` int(11) DEFAULT NULL,
  `file_lft` int(11) NOT NULL,
  `file_rgt` int(11) NOT NULL,
  `file_lastmodifydate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `common_file` (`common_file`),
  KEY `file_createDate_idx` (`file_createDate`),
  CONSTRAINT `blog_file_ibfk_1` FOREIGN KEY (`common_file`) REFERENCES `blog_common_file` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_lock` */

DROP TABLE IF EXISTS `blog_lock`;

CREATE TABLE `blog_lock` (
  `id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lock_type` int(11) NOT NULL DEFAULT '0',
  `lock_password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lock_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createDate` datetime NOT NULL,
  `lock_question` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lock_answers` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createDate_idx` (`createDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_oauth_bind` */

DROP TABLE IF EXISTS `blog_oauth_bind`;

CREATE TABLE `blog_oauth_bind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `bind_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `blog_oauth_bind_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `blog_oauth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_oauth_user` */

DROP TABLE IF EXISTS `blog_oauth_user`;

CREATE TABLE `blog_oauth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `server_id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nick_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `oauth_status` int(11) NOT NULL DEFAULT '0',
  `register_date` datetime NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_1` (`oauth_id`,`server_id`),
  KEY `register_date_idx` (`register_date`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_page_error` */

DROP TABLE IF EXISTS `blog_page_error`;

CREATE TABLE `blog_page_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `space_id` int(11) DEFAULT NULL,
  `error_code` int(11) NOT NULL,
  `page_tpl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `space_id` (`space_id`),
  CONSTRAINT `blog_page_error_ibfk_1` FOREIGN KEY (`space_id`) REFERENCES `blog_space` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_page_expanded` */

DROP TABLE IF EXISTS `blog_page_expanded`;

CREATE TABLE `blog_page_expanded` (
  `id` int(11) NOT NULL,
  `page_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_tpl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_page_sys` */

DROP TABLE IF EXISTS `blog_page_sys`;

CREATE TABLE `blog_page_sys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `space_id` int(11) DEFAULT NULL,
  `page_tpl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_target` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `space_id` (`space_id`),
  CONSTRAINT `blog_page_sys_ibfk_1` FOREIGN KEY (`space_id`) REFERENCES `blog_space` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_page_user` */

DROP TABLE IF EXISTS `blog_page_user`;

CREATE TABLE `blog_page_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_tpl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `space_id` int(11) DEFAULT NULL,
  `page_create_date` datetime NOT NULL,
  `page_alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_alias` (`page_alias`),
  KEY `space_id` (`space_id`),
  KEY `page_create_date_idx` (`page_create_date`),
  CONSTRAINT `blog_page_user_ibfk_1` FOREIGN KEY (`space_id`) REFERENCES `blog_space` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_space` */

DROP TABLE IF EXISTS `blog_space`;

CREATE TABLE `blog_space` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `space_alias` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `space_status` int(11) NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `createDate` datetime NOT NULL,
  `space_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `space_lock` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `space_alias` (`space_alias`),
  KEY `blog_space_ibfk_2` (`space_lock`),
  KEY `createDate_idx` (`createDate`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_tag` */

DROP TABLE IF EXISTS `blog_tag`;

CREATE TABLE `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_name` (`tag_name`),
  KEY `create_date_idx` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_user` */

DROP TABLE IF EXISTS `blog_user`;

CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

insert  into `blog_user`(`id`,`user_name`,`user_password`,`user_email`) values (2,'admin','$2a$10$ulTl80OWAFb8F.Mj3M12ueChA8Q0MykQhSQmwixgvyhekoLLnyvBO','youremail@email.com');

/*Table structure for table `blog_widget_tpl` */

DROP TABLE IF EXISTS `blog_widget_tpl`;

CREATE TABLE `blog_widget_tpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpl` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget_id` int(11) NOT NULL,
  `widget_type` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `page_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blog_widget_user` */

DROP TABLE IF EXISTS `blog_widget_user`;

CREATE TABLE `blog_widget_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `widget_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget_description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget_tpl` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget_create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `widget_name` (`widget_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Trigger structure for table `blog_lock` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `blog_lock_delete_trigger` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `blog_lock_delete_trigger` AFTER DELETE ON `blog_lock` FOR EACH ROW BEGIN
	UPDATE blog_space SET space_lock = NULL WHERE space_lock = old.id;
	UPDATE blog_article SET art_lock = NULL WHERE art_lock = old.id;
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;