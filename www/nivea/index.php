<?
// The Meneame source code is Free Software, Copyright (C) 2005-2009 by
// Ricardo Galli <gallir at gmail dot com> and Menéame Comunicacions S.L.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.

// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// It's licensed under the AFFERO GENERAL PUBLIC LICENSE unless stated otherwise.
// You can get copies of the licenses here:
// 		http://www.affero.org/oagpl.html
// AFFERO GENERAL PUBLIC LICENSE is also included in the file called "COPYING".

include('../config.php');
include(mnminclude.'html1.php');

$league = new League(1);
$league->read();

if (!empty($globals['nivea_host']) && $_SERVER["HTTP_HOST"] !== $globals['nivea_host']) {
	header('HTTP/1.1 301 Moved Permanently');
	header("Location: http://{$globals['nivea_host']}{$_SERVER['REQUEST_URI']}");
	exit;
}

$globals['league_url']  = $globals['base_url'] . 'nivea/';

/* terms {{{ */
$accepted_terms = NULL;
if ($current_user->user_id > 0) {
	if (!empty($_POST['terms'])) {
		if ($_POST['terms'] == _('Acepto')) {
			$db->query("INSERT INTO league_terms VALUES({$current_user->user_id}, 'nivea')");
		} else {
			header("location: /");
			exit;
		}
	}
	$accepted_terms = $db->get_row("SELECT count(*) as t FROM league_terms WHERE user_id={$current_user->user_id} AND vendor='nivea'")->t == 1;
}
/* }}} */

$sites = $db->get_results("select * from subs where visible order by id asc");
$args  = compact('league', 'accepted_terms', 'sites');

Haanga::Load('league/layout-header.tpl', $args);

if (isset($_GET['match'])) {
	$match = new Match(intval($_GET['match']));
	if ($match->read() && $match->league_id == $league->id) {
		$match->print_summary();
	}
} else {
	foreach ($league->get_pages($league->per_page) as $m) {
		$match = new Match($m->id);
		$match->read();
		$match->print_summary();
	}

	echo '<div class="pages-ad">';
	do_pages_reverse($league->total, $league->per_page);
	echo '</div>';
}

echo '</body></html>';
/* vim:set noet ci pi sts=0 sw=4 ts=4: */
