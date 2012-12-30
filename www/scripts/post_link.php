#! /usr/bin/env php
<?php
// This file post the indicated link to ever twitter o facebook account
// Argument required: hostname, link_id


if (count($argv) != 3) {
	syslog(LOG_INFO, "Usage: ".basename(__FILE__)." site_id hostname link_id");
	echo "Usage: ".basename(__FILE__)." site_id hostname link_id\n";
	die;
}

$hostname = $argv[1];
$link_id = (int) $argv[2];

$_SERVER['SERVER_NAME'] = $hostname;

include(dirname(__FILE__).'/../config.php');
include(mnminclude.'external_post.php');

$my_id = SitesMgr::my_id();

if (! $my_id) {
	syslog(LOG_INFO, "Meneame, post_link.php, site not found $hostname");
	echo "No site id found\n";
	die;
}

$link = Link::from_db($link_id);
if (! $link) {
	syslog(LOG_INFO, "Meneame, post_link.php, link not found $link_id");
	echo "Link $link_id not found\n";
	die;
}

do_posts($link);


function do_posts($link) {
	global $globals;

	syslog(LOG_INFO, "Meneame, posting $link->uri");

	// echo "Posting $link->uri: ".$globals['server_name']. "--".$globals["site_shortname"]."---". $globals['twitter_consumer_key'] ."\n"; die;
	if ($globals['url_shortener']) {
		$short_url = $link->get_short_permalink();
	} else {
		$short_url = fon_gs($link->get_permalink());
	}

	if ($globals['twitter_token'] && $globals['twitter_token_secret']) {
		twitter_post($link->title, $short_url);
	}

	if ($globals['facebook_token']) {
		facebook_post($link);
	}

	if ($globals['jaiku_user'] && $globals['jaiku_key']) {
		jaiku_post($link->title, $short_url);
	}
	if ($globals['pubsub']) {
		pubsub_post();
	}
}
