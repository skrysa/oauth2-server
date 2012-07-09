-- Create syntax for TABLE 'clients'
CREATE TABLE `clients` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `secret` varchar(40) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `auto_approve` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'client_endpoints'
CREATE TABLE `client_endpoints` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(40) NOT NULL DEFAULT '',
  `redirect_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_endpoints_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'oauth_sessions'
CREATE TABLE `oauth_sessions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `redirect_uri` varchar(250) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `owner_type` enum('user','client') CHARACTER SET latin1 NOT NULL DEFAULT 'user',
  `owner_id` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `auth_code` varchar(40) CHARACTER SET latin1 DEFAULT '',
  `access_token` varchar(40) CHARACTER SET latin1 DEFAULT '',
  `stage` enum('requested','granted') CHARACTER SET latin1 NOT NULL DEFAULT 'requested',
  `first_requested` int(10) unsigned NOT NULL,
  `last_updated` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'scopes'
CREATE TABLE `scopes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `scope` (`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'oauth_session_scopes'
CREATE TABLE `oauth_session_scopes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(11) unsigned NOT NULL,
  `access_token` varchar(40) NOT NULL DEFAULT '',
  `scope` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  KEY `access_token` (`access_token`),
  KEY `scope` (`scope`),
  CONSTRAINT `oauth_session_scopes_ibfk_2` FOREIGN KEY (`scope`) REFERENCES `scopes` (`scope`) ON DELETE CASCADE,
  CONSTRAINT `oauth_session_scopes_ibfk_3` FOREIGN KEY (`scope`) REFERENCES `scopes` (`scope`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;