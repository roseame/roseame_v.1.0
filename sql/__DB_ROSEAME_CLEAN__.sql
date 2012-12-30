-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 30, 2012 at 12:46 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.18

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `roseame`
--

-- --------------------------------------------------------

--
-- Table structure for table `annotations`
--

CREATE TABLE IF NOT EXISTS `annotations` (
  `annotation_key` char(64) NOT NULL,
  `annotation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `annotation_expire` timestamp NULL DEFAULT NULL,
  `annotation_text` text,
  PRIMARY KEY (`annotation_key`),
  KEY `annotation_expire` (`annotation_expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `annotations`
--

INSERT INTO `annotations` (`annotation_key`, `annotation_time`, `annotation_expire`, `annotation_text`) VALUES
('user_stats-1', '2012-12-28 14:37:30', '2013-03-28 14:37:30', 'O:8:"stdClass":7:{s:11:"total_votes";i:1;s:11:"total_links";i:1;s:15:"published_links";i:0;s:14:"total_comments";i:2;s:11:"total_posts";i:0;s:13:"total_friends";i:0;s:12:"total_images";i:0;}'),
('user_stats-2', '2012-12-30 11:30:06', '2013-03-30 11:30:06', 'O:8:"stdClass":7:{s:11:"total_votes";i:0;s:11:"total_links";i:0;s:15:"published_links";i:0;s:14:"total_comments";i:0;s:11:"total_posts";i:0;s:13:"total_friends";i:0;s:12:"total_images";i:0;}');

-- --------------------------------------------------------

--
-- Table structure for table `auths`
--

CREATE TABLE IF NOT EXISTS `auths` (
  `user_id` int(10) unsigned NOT NULL,
  `service` char(32) NOT NULL,
  `uid` decimal(24,0) unsigned NOT NULL,
  `username` char(32) NOT NULL DEFAULT '''''',
  `token` char(64) NOT NULL DEFAULT '''''',
  `secret` char(64) NOT NULL DEFAULT '''''',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `service` (`service`,`uid`),
  KEY `user_id` (`user_id`),
  KEY `service_2` (`service`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auths`
--


-- --------------------------------------------------------

--
-- Table structure for table `avatars`
--

CREATE TABLE IF NOT EXISTS `avatars` (
  `avatar_id` int(11) NOT NULL,
  `avatar_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `avatar_image` blob NOT NULL,
  PRIMARY KEY (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avatars`
--


-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `ban_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ban_type` enum('email','hostname','punished_hostname','ip','words','proxy','noaccess') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ban_text` char(64) NOT NULL,
  `ban_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ban_expire` timestamp NULL DEFAULT NULL,
  `ban_comment` char(100) DEFAULT NULL,
  PRIMARY KEY (`ban_id`),
  UNIQUE KEY `ban_type` (`ban_type`,`ban_text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bans`
--


-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE IF NOT EXISTS `blogs` (
  `blog_id` int(20) NOT NULL AUTO_INCREMENT,
  `blog_key` char(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `blog_type` enum('normal','blog','noiframe','redirector','aggregator') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'normal',
  `blog_rss` varchar(64) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `blog_rss2` varchar(64) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `blog_atom` varchar(64) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `blog_url` varchar(64) COLLATE utf8_spanish_ci DEFAULT NULL,
  `blog_feed` char(128) COLLATE utf8_spanish_ci DEFAULT NULL,
  `blog_feed_checked` timestamp NULL DEFAULT NULL,
  `blog_feed_read` timestamp NULL DEFAULT NULL,
  `blog_title` char(128) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`blog_id`),
  UNIQUE KEY `key` (`blog_key`),
  KEY `blog_url` (`blog_url`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `blogs`
--


-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category__auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_lang` char(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'es',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `category_parent` int(11) NOT NULL DEFAULT '0',
  `category_name` char(32) COLLATE utf8_spanish_ci NOT NULL,
  `category_uri` char(32) COLLATE utf8_spanish_ci DEFAULT NULL,
  `category_calculated_coef` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`category__auto_id`),
  UNIQUE KEY `category_lang` (`category_lang`,`category_id`),
  UNIQUE KEY `id` (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=72 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category__auto_id`, `category_lang`, `category_id`, `category_parent`, `category_name`, `category_uri`, `category_calculated_coef`) VALUES
(1, 'es', 1, 100, 'nacionales', 'nacionales', 1),
(4, 'es', 4, 100, 'internacionales', 'internacionales', 1),
(6, 'es', 6, 100, 'bodas', 'bodas-fam', 1),
(38, 'es', 38, 102, 'sociedad', NULL, 1),
(14, 'es', 8, 100, 'tv', 'tv', 1),
(16, 'es', 22, 101, 'belleza', 'belleza', 1),
(19, 'es', 13, 100, 'diseño', NULL, 1),
(22, 'es', 11, 100, 'software', NULL, 1),
(70, 'es', 49, 103, 'reino unido', 'reino-unido', 1),
(29, 'es', 23, 101, 'salud', 'salud', 1),
(33, 'es', 32, 102, 'noticias', 'noticias', 1),
(57, 'es', 28, 101, 'podcast', NULL, 1),
(35, 'es', 35, 102, 'recetas', 'recetas', 1),
(36, 'es', 36, 102, 'dietas', 'dietas', 1),
(37, 'es', 37, 102, 'seguridad', NULL, 1),
(39, 'es', 5, 100, 'entrevistas', 'entrevistas', 1),
(40, 'es', 100, 0, 'famosos', 'famosos', 1),
(41, 'es', 101, 0, 'tendencias', 'tendencias', 1),
(42, 'es', 102, 0, 'nutrición', 'nutrición', 1),
(71, 'es', 50, 103, 'suecia', 'suecia', 1),
(44, 'es', 9, 100, 'realities', 'realities', 1),
(45, 'es', 10, 100, 'deportistas', 'deportistas', 1),
(46, 'es', 12, 100, 'espectáculos', NULL, 1),
(47, 'es', 15, 100, 'historia', NULL, 1),
(48, 'es', 16, 100, 'literatura', NULL, 1),
(49, 'es', 17, 100, 'américas', NULL, 1),
(50, 'es', 18, 100, 'europa', 'europa', 1),
(51, 'es', 20, 101, 'moda', 'moda', 1),
(53, 'es', 24, 101, 'hogar', 'hogar', 1),
(54, 'es', 25, 101, 'maquillaje', 'maquillaje', 1),
(56, 'es', 27, 101, 'peinados', 'peinados', 1),
(58, 'es', 29, 101, 'educación', 'educación', 1),
(59, 'es', 39, 102, 'medicina', NULL, 1),
(60, 'es', 40, 103, 'españa', 'españa', 1),
(61, 'es', 41, 103, 'bodas reales', 'bodas-re', 1),
(62, 'es', 42, 103, 'belgica', 'belgica', 1),
(63, 'es', 43, 103, 'dinamarca', 'dinamarca', 1),
(64, 'es', 44, 103, 'holanda', 'holanda', 1),
(65, 'es', 45, 103, 'liechtenstein', 'liechtenstein', 1),
(66, 'es', 103, 0, 'realeza', 'realeza', 1),
(67, 'es', 46, 103, 'luxemburgo', 'luxemburgo', 1),
(68, 'es', 47, 103, 'mónaco', 'mónaco', 1),
(69, 'es', 48, 103, 'noruega', 'noruega', 1);

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE IF NOT EXISTS `chats` (
  `chat_time` decimal(12,2) unsigned NOT NULL DEFAULT '0.00',
  `chat_uid` int(10) unsigned NOT NULL DEFAULT '0',
  `chat_room` enum('all','friends','admin') NOT NULL DEFAULT 'all',
  `chat_user` char(32) NOT NULL,
  `chat_text` char(255) NOT NULL,
  KEY `chat_time` (`chat_time`) USING BTREE
) ENGINE=MEMORY DEFAULT CHARSET=utf8 MAX_ROWS=1000;

--
-- Dumping data for table `chats`
--


-- --------------------------------------------------------

--
-- Table structure for table `clones`
--

CREATE TABLE IF NOT EXISTS `clones` (
  `clon_from` int(10) unsigned NOT NULL,
  `clon_to` int(10) unsigned NOT NULL,
  `clon_ip` char(48) NOT NULL DEFAULT '',
  `clon_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`clon_from`,`clon_to`,`clon_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clones`
--


-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int(20) NOT NULL AUTO_INCREMENT,
  `comment_type` enum('normal','admin','private') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'normal',
  `comment_randkey` int(11) NOT NULL DEFAULT '0',
  `comment_parent` int(20) DEFAULT '0',
  `comment_link_id` int(20) NOT NULL DEFAULT '0',
  `comment_user_id` int(20) NOT NULL DEFAULT '0',
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_ip_int` decimal(39,0) NOT NULL,
  `comment_ip` varbinary(42) DEFAULT NULL,
  `comment_order` smallint(6) NOT NULL DEFAULT '0',
  `comment_votes` smallint(4) NOT NULL DEFAULT '0',
  `comment_karma` smallint(6) NOT NULL DEFAULT '0',
  `comment_content` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_link_id_2` (`comment_link_id`,`comment_date`),
  KEY `comment_date` (`comment_date`),
  KEY `comment_user_id` (`comment_user_id`,`comment_date`),
  KEY `comment_link_id` (`comment_link_id`,`comment_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE IF NOT EXISTS `conversations` (
  `conversation_user_to` int(10) unsigned NOT NULL,
  `conversation_type` enum('comment','post','link') NOT NULL,
  `conversation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `conversation_from` int(10) unsigned NOT NULL,
  `conversation_to` int(10) unsigned NOT NULL,
  KEY `conversation_type` (`conversation_type`,`conversation_from`),
  KEY `conversation_time` (`conversation_time`),
  KEY `conversation_type_2` (`conversation_type`,`conversation_to`),
  KEY `conversation_user_to` (`conversation_user_to`,`conversation_type`,`conversation_time`),
  KEY `conversation_type_3` (`conversation_type`,`conversation_user_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `conversations`
--


-- --------------------------------------------------------

--
-- Table structure for table `counts`
--

CREATE TABLE IF NOT EXISTS `counts` (
  `key` char(64) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `counts`
--

INSERT INTO `counts` (`key`, `count`, `date`) VALUES
('1.published.', 0, '2012-12-25 21:02:26'),
('1.queued.', 0, '2012-12-25 21:39:18'),
('2.published.', 0, '2012-12-30 11:56:57'),
('2.queued.', 0, '2012-12-30 09:32:48'),
('posts', 0, '2012-12-28 14:37:38');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE IF NOT EXISTS `favorites` (
  `favorite_user_id` int(10) unsigned NOT NULL,
  `favorite_type` enum('link','post','comment') NOT NULL DEFAULT 'link',
  `favorite_link_id` int(10) unsigned NOT NULL,
  `favorite_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `favorite_user_id_2` (`favorite_user_id`,`favorite_type`,`favorite_link_id`),
  KEY `favorite_type` (`favorite_type`,`favorite_link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `favorites`
--


-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `friend_type` enum('affiliate','manual','hide','affinity') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'affiliate',
  `friend_from` int(10) NOT NULL DEFAULT '0',
  `friend_to` int(10) NOT NULL DEFAULT '0',
  `friend_value` smallint(3) NOT NULL DEFAULT '0',
  `friend_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `friend_type` (`friend_type`,`friend_from`,`friend_to`),
  KEY `friend_type_3` (`friend_type`,`friend_to`,`friend_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `friends`
--


-- --------------------------------------------------------

--
-- Table structure for table `geo_links`
--

CREATE TABLE IF NOT EXISTS `geo_links` (
  `geo_id` int(11) NOT NULL,
  `geo_text` char(80) DEFAULT NULL,
  `geo_pt` point NOT NULL,
  UNIQUE KEY `geo_id` (`geo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `geo_links`
--


-- --------------------------------------------------------

--
-- Table structure for table `geo_users`
--

CREATE TABLE IF NOT EXISTS `geo_users` (
  `geo_id` int(11) NOT NULL,
  `geo_text` char(80) DEFAULT NULL,
  `geo_pt` point NOT NULL,
  UNIQUE KEY `geo_id` (`geo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `geo_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_name` varchar(64) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `language_name` (`language_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `languages`
--


-- --------------------------------------------------------

--
-- Table structure for table `league`
--

CREATE TABLE IF NOT EXISTS `league` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `league`
--


-- --------------------------------------------------------

--
-- Table structure for table `league_matches`
--

CREATE TABLE IF NOT EXISTS `league_matches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `league_id` int(10) unsigned NOT NULL,
  `local` int(10) unsigned NOT NULL,
  `visitor` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_starts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `votes_local` int(20) DEFAULT '0',
  `votes_visitor` int(20) DEFAULT '0',
  `votes_tied` int(20) DEFAULT '0',
  `score_local` int(2) DEFAULT NULL,
  `score_visitor` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `league_id` (`league_id`),
  KEY `league_id_2` (`league_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `league_matches`
--


-- --------------------------------------------------------

--
-- Table structure for table `league_teams`
--

CREATE TABLE IF NOT EXISTS `league_teams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` char(5) DEFAULT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `league_teams`
--


-- --------------------------------------------------------

--
-- Table structure for table `league_terms`
--

CREATE TABLE IF NOT EXISTS `league_terms` (
  `user_id` int(20) NOT NULL,
  `vendor` enum('nivea') NOT NULL DEFAULT 'nivea',
  PRIMARY KEY (`user_id`,`vendor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `league_terms`
--


-- --------------------------------------------------------

--
-- Table structure for table `league_votes`
--

CREATE TABLE IF NOT EXISTS `league_votes` (
  `match_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `value` int(10) unsigned NOT NULL,
  `ip` decimal(39,0) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `match_id` (`match_id`,`user_id`),
  KEY `sort_index` (`match_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `league_votes`
--


-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `link_id` int(20) NOT NULL AUTO_INCREMENT,
  `link_author` int(20) NOT NULL DEFAULT '0',
  `link_blog` int(20) DEFAULT '0',
  `link_status` enum('discard','queued','published','abuse','duplicated','autodiscard','metapublished') CHARACTER SET utf8 NOT NULL DEFAULT 'discard',
  `link_randkey` int(20) NOT NULL DEFAULT '0',
  `link_votes` int(20) NOT NULL DEFAULT '0',
  `link_negatives` int(11) NOT NULL DEFAULT '0',
  `link_anonymous` int(10) unsigned NOT NULL DEFAULT '0',
  `link_votes_avg` float NOT NULL DEFAULT '0',
  `link_comments` int(11) unsigned NOT NULL DEFAULT '0',
  `link_karma` decimal(10,2) NOT NULL DEFAULT '0.00',
  `link_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `link_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_sent_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_published_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_category` int(11) NOT NULL DEFAULT '0',
  `link_lang` char(2) CHARACTER SET utf8 NOT NULL DEFAULT 'es',
  `link_ip_int` decimal(39,0) NOT NULL,
  `link_ip` varbinary(42) DEFAULT NULL,
  `link_content_type` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `link_uri` char(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `link_url` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `link_thumb_status` enum('unknown','checked','error','local','remote','deleted') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'unknown',
  `link_thumb_x` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `link_thumb_y` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `link_thumb` tinytext COLLATE utf8_spanish_ci,
  `link_url_title` text COLLATE utf8_spanish_ci,
  `link_title` text COLLATE utf8_spanish_ci NOT NULL,
  `link_content` text COLLATE utf8_spanish_ci NOT NULL,
  `link_tags` text COLLATE utf8_spanish_ci,
  PRIMARY KEY (`link_id`),
  KEY `link_url` (`link_url`),
  KEY `link_uri` (`link_uri`),
  KEY `link_blog` (`link_blog`),
  KEY `link_author` (`link_author`,`link_date`),
  KEY `link_date` (`link_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `links`
--


-- --------------------------------------------------------

--
-- Table structure for table `link_clicks`
--

CREATE TABLE IF NOT EXISTS `link_clicks` (
  `id` int(10) unsigned NOT NULL,
  `counter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `link_clicks`
--


-- --------------------------------------------------------

--
-- Table structure for table `link_commons`
--

CREATE TABLE IF NOT EXISTS `link_commons` (
  `link` int(10) unsigned NOT NULL,
  `value` float NOT NULL,
  `n` int(11) NOT NULL DEFAULT '0',
  `date` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `link` (`link`),
  KEY `created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `link_commons`
--


-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_sub` smallint(5) unsigned NOT NULL DEFAULT '1',
  `log_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `log_type` enum('link_new','comment_new','link_publish','link_discard','comment_edit','link_edit','post_new','post_edit','login_failed','spam_warn','link_geo_edit','user_new','user_delete','link_depublished') NOT NULL,
  `log_ref_id` int(11) unsigned NOT NULL,
  `log_user_id` int(11) NOT NULL,
  `log_ip_int` decimal(39,0) NOT NULL,
  `log_ip` char(42) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_date` (`log_date`),
  KEY `log_type` (`log_type`,`log_ref_id`),
  KEY `log_type_2` (`log_type`,`log_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `log_pos`
--

CREATE TABLE IF NOT EXISTS `log_pos` (
  `host` varchar(60) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `log_file` varchar(32) DEFAULT NULL,
  `log_pos` int(11) DEFAULT NULL,
  `master_host` varchar(60) DEFAULT NULL,
  `master_log_file` varchar(32) DEFAULT NULL,
  `master_log_pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log_pos`
--


-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `type` enum('comment','link','post','avatar','thumb','private','other') NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `version` tinyint(3) unsigned NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL DEFAULT '0',
  `access` enum('restricted','public','friends','private') NOT NULL DEFAULT 'restricted',
  `mime` char(32) NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dim1` smallint(5) unsigned NOT NULL,
  `dim2` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`type`,`id`,`version`),
  KEY `user` (`user`,`type`,`date`),
  KEY `type` (`type`,`version`,`date`),
  KEY `user_2` (`user`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media`
--


-- --------------------------------------------------------

--
-- Table structure for table `pageloads`
--

CREATE TABLE IF NOT EXISTS `pageloads` (
  `date` date NOT NULL,
  `type` enum('html','ajax','other','rss','image','api','sneaker','bot','geo') NOT NULL DEFAULT 'html',
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`date`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pageloads`
--


-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_randkey` int(11) NOT NULL DEFAULT '0',
  `post_src` enum('web','api','im','mobile','phone') CHARACTER SET utf8 NOT NULL DEFAULT 'web',
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_user_id` int(11) unsigned NOT NULL,
  `post_visible` enum('all','friends') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'all',
  `post_ip_int` decimal(39,0) DEFAULT NULL,
  `post_votes` smallint(4) NOT NULL DEFAULT '0',
  `post_karma` smallint(6) NOT NULL DEFAULT '0',
  `post_content` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_date` (`post_date`),
  KEY `post_user_id` (`post_user_id`,`post_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `posts`
--


-- --------------------------------------------------------

--
-- Table structure for table `prefs`
--

CREATE TABLE IF NOT EXISTS `prefs` (
  `pref_user_id` int(11) NOT NULL,
  `pref_key` char(16) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `pref_value` int(8) unsigned NOT NULL DEFAULT '0',
  KEY `pref_user_id` (`pref_user_id`,`pref_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `prefs`
--

INSERT INTO `prefs` (`pref_user_id`, `pref_key`, `pref_value`) VALUES
(1, 'last_friend', 1356546699),
(1, 'c_last_read', 1356710594);

-- --------------------------------------------------------

--
-- Table structure for table `privates`
--

CREATE TABLE IF NOT EXISTS `privates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `randkey` int(11) NOT NULL DEFAULT '0',
  `user` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`,`date`),
  KEY `to_2` (`to`,`read`),
  KEY `to` (`to`,`date`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `privates`
--


-- --------------------------------------------------------

--
-- Table structure for table `rss`
--

CREATE TABLE IF NOT EXISTS `rss` (
  `blog_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `link_id` int(10) unsigned DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_parsed` timestamp NULL DEFAULT NULL,
  `url` char(250) NOT NULL,
  `title` char(250) NOT NULL,
  UNIQUE KEY `url` (`url`),
  KEY `date` (`date`),
  KEY `blog_id` (`blog_id`,`date`),
  KEY `user_id` (`user_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rss`
--


-- --------------------------------------------------------

--
-- Table structure for table `sneakers`
--

CREATE TABLE IF NOT EXISTS `sneakers` (
  `sneaker_id` char(24) NOT NULL,
  `sneaker_time` int(10) unsigned NOT NULL DEFAULT '0',
  `sneaker_user` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `sneaker_id` (`sneaker_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 MAX_ROWS=1000;

--
-- Dumping data for table `sneakers`
--


-- --------------------------------------------------------

--
-- Table structure for table `sph_counter`
--

CREATE TABLE IF NOT EXISTS `sph_counter` (
  `counter_id` int(11) NOT NULL,
  `max_doc_id` int(11) NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sph_counter`
--


-- --------------------------------------------------------

--
-- Table structure for table `subs`
--

CREATE TABLE IF NOT EXISTS `subs` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` char(12) NOT NULL,
  `name_long` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `parent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `server_name` varchar(32) DEFAULT NULL,
  `base_url` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Basic data for every sub site' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `subs`
--

INSERT INTO `subs` (`id`, `name`, `name_long`, `enabled`, `parent`, `server_name`, `base_url`) VALUES
(2, 'rsm', 'general', 1, 0, 'www.roseame.net', '/');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE IF NOT EXISTS `sub_categories` (
  `id` smallint(5) unsigned NOT NULL,
  `category` smallint(5) unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `import` tinyint(1) NOT NULL DEFAULT '1',
  `export` tinyint(1) NOT NULL DEFAULT '0',
  `calculated_coef` float NOT NULL DEFAULT '0',
  UNIQUE KEY `category_id` (`category`,`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store categories available for each sub site';

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category`, `enabled`, `import`, `export`, `calculated_coef`) VALUES
(2, 1, 1, 1, 0, 0),
(2, 4, 1, 1, 0, 0),
(2, 5, 1, 1, 0, 0),
(2, 6, 1, 1, 0, 0),
(2, 8, 1, 1, 0, 0),
(2, 9, 1, 1, 0, 0),
(2, 10, 1, 1, 0, 0),
(2, 20, 1, 1, 0, 0),
(2, 22, 1, 1, 0, 0),
(2, 23, 1, 1, 0, 0),
(2, 24, 1, 1, 0, 0),
(2, 25, 1, 1, 0, 0),
(2, 27, 1, 1, 0, 0),
(2, 32, 1, 1, 0, 0),
(2, 35, 1, 1, 0, 0),
(2, 36, 1, 1, 0, 0),
(2, 40, 1, 1, 0, 0),
(2, 42, 1, 1, 0, 0),
(2, 43, 1, 1, 0, 0),
(2, 44, 1, 1, 0, 0),
(2, 45, 1, 1, 0, 0),
(2, 46, 1, 1, 0, 0),
(2, 47, 1, 1, 0, 0),
(2, 48, 1, 1, 0, 0),
(2, 49, 1, 1, 0, 0),
(2, 50, 1, 1, 0, 0),
(2, 100, 1, 1, 0, 0),
(2, 101, 1, 1, 0, 0),
(2, 102, 1, 1, 0, 0),
(2, 103, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sub_statuses`
--

CREATE TABLE IF NOT EXISTS `sub_statuses` (
  `id` smallint(5) unsigned NOT NULL,
  `status` enum('discard','queued','published','abuse','duplicated','autodiscard','metapublished') NOT NULL DEFAULT 'discard',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category` smallint(5) unsigned NOT NULL,
  `link` int(10) NOT NULL,
  `origen` smallint(5) unsigned NOT NULL,
  `karma` decimal(10,2) NOT NULL DEFAULT '0.00',
  UNIQUE KEY `link_id` (`link`,`id`),
  KEY `id_status_category_date` (`id`,`status`,`category`,`date`),
  KEY `id_status_date_category` (`id`,`status`,`date`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store the status for each link in every sub site';

--
-- Dumping data for table `sub_statuses`
--


-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `tag_link_id` int(11) NOT NULL DEFAULT '0',
  `tag_lang` char(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'es',
  `tag_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tag_words` char(40) COLLATE utf8_spanish_ci NOT NULL,
  UNIQUE KEY `tag_link_id` (`tag_link_id`,`tag_lang`,`tag_words`),
  KEY `tag_lang` (`tag_lang`,`tag_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `tags`
--


-- --------------------------------------------------------

--
-- Table structure for table `texts`
--

CREATE TABLE IF NOT EXISTS `texts` (
  `key` char(32) NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`key`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `texts`
--


-- --------------------------------------------------------

--
-- Table structure for table `trackbacks`
--

CREATE TABLE IF NOT EXISTS `trackbacks` (
  `trackback_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trackback_link_id` int(11) NOT NULL DEFAULT '0',
  `trackback_user_id` int(11) NOT NULL DEFAULT '0',
  `trackback_type` enum('in','out') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'in',
  `trackback_status` enum('ok','pendent','error') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'pendent',
  `trackback_date` timestamp NULL DEFAULT NULL,
  `trackback_ip_int` int(10) unsigned NOT NULL DEFAULT '0',
  `trackback_link` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `trackback_url` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `trackback_title` text COLLATE utf8_spanish_ci,
  `trackback_content` text COLLATE utf8_spanish_ci,
  PRIMARY KEY (`trackback_id`),
  UNIQUE KEY `trackback_link_id_2` (`trackback_link_id`,`trackback_type`,`trackback_link`),
  KEY `trackback_link_id` (`trackback_link_id`),
  KEY `trackback_url` (`trackback_url`),
  KEY `trackback_date` (`trackback_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `trackbacks`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(20) NOT NULL AUTO_INCREMENT,
  `user_login` char(32) COLLATE utf8_spanish_ci NOT NULL,
  `user_level` enum('autodisabled','disabled','normal','special','blogger','admin','god') CHARACTER SET utf8 NOT NULL DEFAULT 'normal',
  `user_avatar` int(10) unsigned NOT NULL DEFAULT '0',
  `user_modification` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_validated_date` timestamp NULL DEFAULT NULL,
  `user_ip` char(42) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_pass` char(64) COLLATE utf8_spanish_ci NOT NULL,
  `user_email` char(64) COLLATE utf8_spanish_ci NOT NULL,
  `user_names` char(60) COLLATE utf8_spanish_ci NOT NULL,
  `user_login_register` char(32) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_email_register` char(64) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_lang` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `user_comment_pref` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `user_karma` decimal(10,2) DEFAULT '6.00',
  `user_public_info` char(64) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_url` char(128) COLLATE utf8_spanish_ci NOT NULL,
  `user_adcode` char(24) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_adchannel` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_phone` char(16) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_login` (`user_login`),
  KEY `user_email` (`user_email`),
  KEY `user_karma` (`user_karma`),
  KEY `user_public_info` (`user_public_info`),
  KEY `user_phone` (`user_phone`),
  KEY `user_date` (`user_date`),
  KEY `user_modification` (`user_modification`),
  KEY `user_email_register` (`user_email_register`),
  KEY `user_url` (`user_url`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_login`, `user_level`, `user_avatar`, `user_modification`, `user_date`, `user_validated_date`, `user_ip`, `user_pass`, `user_email`, `user_names`, `user_login_register`, `user_email_register`, `user_lang`, `user_comment_pref`, `user_karma`, `user_public_info`, `user_url`, `user_adcode`, `user_adchannel`, `user_phone`) VALUES
(2, 'roseame', 'god', 0, '2012-12-29 07:05:35', '2012-12-29 07:05:35', '2012-12-29 07:12:48', '77.56.243.59', '61908aebb127099136b024078ed73081', 'admin@roseame.net', '', 'roseame', 'admin@roseame.net', 1, 0, '6.00', NULL, '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_similarities`
--

CREATE TABLE IF NOT EXISTS `users_similarities` (
  `minor` int(10) unsigned NOT NULL,
  `major` int(10) unsigned NOT NULL,
  `value` float NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `minor` (`minor`,`major`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_similarities`
--


-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE IF NOT EXISTS `votes` (
  `vote_id` int(20) NOT NULL AUTO_INCREMENT,
  `vote_type` enum('links','comments','posts','polls','users','sites','ads') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'links',
  `vote_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vote_link_id` int(20) NOT NULL DEFAULT '0',
  `vote_user_id` int(20) NOT NULL DEFAULT '0',
  `vote_value` smallint(11) NOT NULL DEFAULT '1',
  `vote_ip_int` decimal(39,0) NOT NULL,
  PRIMARY KEY (`vote_id`),
  UNIQUE KEY `vote_type` (`vote_type`,`vote_link_id`,`vote_user_id`,`vote_ip_int`),
  KEY `vote_type_4` (`vote_type`,`vote_date`,`vote_user_id`),
  KEY `vote_ip_int` (`vote_ip_int`),
  KEY `vote_type_2` (`vote_type`,`vote_user_id`,`vote_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci PACK_KEYS=0 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `votes`
--


-- --------------------------------------------------------

--
-- Table structure for table `votes_summary`
--

CREATE TABLE IF NOT EXISTS `votes_summary` (
  `votes_year` smallint(4) NOT NULL,
  `votes_month` tinyint(2) NOT NULL,
  `votes_type` char(10) NOT NULL,
  `votes_maxid` int(11) NOT NULL,
  `votes_count` int(11) NOT NULL,
  UNIQUE KEY `votes_year` (`votes_year`,`votes_month`,`votes_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `votes_summary`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `sub_statuses`
--
ALTER TABLE `sub_statuses`
  ADD CONSTRAINT `sub_statuses_ibfk_1` FOREIGN KEY (`link`) REFERENCES `links` (`link_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
