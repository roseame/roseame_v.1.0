<?
// The source code packaged with this file is Free Software, Copyright (C) 2010 by
// Ricardo Galli <gallir at gmail dot com>.
// It's licensed under the AFFERO GENERAL PUBLIC LICENSE unless stated otherwise.
// You can get copies of the licenses here:
// 		http://www.affero.org/oagpl.html
// AFFERO GENERAL PUBLIC LICENSE is also included in the file called "COPYING".

include('config.php');
include(mnminclude.'html1.php');

$page_size = 50;
$comment = new Comment;

if (!isset($_REQUEST['id']) && $globals['base_comment_url'] && $_SERVER['PATH_INFO']) {
	$url_args = preg_split('/\/+/', $_SERVER['PATH_INFO']);
	array_shift($url_args); // The first element is always a "/"
	$comment->id = intval($url_args[0]);
} else {
	$url_args = preg_split('/\/+/', $_REQUEST['id']);
	$comment->id=intval($url_args[0]);
	if($comment->id > 0 && $globals['base_comment_url']) {
		// Redirect to the right URL if the link has a "semantic" uri
		header ('HTTP/1.1 301 Moved Permanently');
		header('Location: ' . $comment->get_relative_individual_permalink());
		die;
	}
}

if (!$comment->read()) {
	do_error(_('comentario no encontrado'), 404);
}

$link = new Link;
$link->id=$comment->link;
$link->read();
$globals['link'] = $link;

// Change to a min_value is times is changed for the current link_status
if ($globals['time_enabled_comments_status'][$link->status]) {
	$globals['time_enabled_comments'] = min($globals['time_enabled_comments_status'][$link->status],
											$globals['time_enabled_comments']);
}

// Check for comment post
if ($_POST['process']=='newcomment') {
	$new = new Comment;
	$new_comment_error = $new->save_from_post($link);
}


$username = $comment->type == 'admin'?'admin':$comment->username;
$globals['search_options'] = array('w' => 'comments', 'u' => $comment->username);

$comment->check_visibility();
if (! $comment->hide_comment) {
	$globals['description'] = _('Autor') . ": $username, " . _('Resumen') . ': '. text_to_summary($comment->content, 250);
	$title = text_to_summary($comment->content, 120);
} else {
	$title = '';
}

if (isset($globals['canonical_server_name']) && !empty($globals['canonical_server_name'])) {
	$globals['extra_head'] = '<link rel="canonical" href="http://'.$globals['canonical_server_name'].$comment->get_relative_individual_permalink().'" />';
}
do_header($title. ' | ' . $globals['site_name']);
//do_subheader(_('comentario de') . ' ' . $username);
/*** SIDEBAR ****/
echo '<div id="sidebar">';
do_banner_right();
//do_best_stories();
do_best_comments();
do_banner_promotions();
echo '</div>' . "\n";
/*** END SIDEBAR ***/

echo '<div id="newswrap">'."\n";

echo '<h3 style="text-shadow: 0 1px #ccc"><a href="'.$link->get_permalink().'">'. $link->title. '</a></h3>';

echo '<ol class="comments-list">';
echo '<li>';
$comment->print_summary($link, 0, true);

echo '<div style="text-align:right">';
$vars = array('link' => 'http://'.get_server_name().$comment->get_relative_individual_permalink(),
			'title' => $title);
Haanga::Load('share.html', $vars);
echo '</div>';
echo "</li>\n";
echo "</ol>\n";

// Print answers to the comment
$sql = "SELECT conversation_from as comment_id FROM conversations, comments WHERE conversation_type='comment' and conversation_to = $comment->id and comment_id = conversation_from ORDER BY conversation_from asc LIMIT $page_size";
$answers = $db->get_results($sql);
if ($answers) {
	$type = 'comment';
	$ids = array();
	echo '<div style="padding-left: 40px; padding-top: 10px">'."\n";
	echo '<ol class="comments-list">';
	foreach ($answers as $dbanswer) {
		$answer = Comment::from_db($dbanswer->comment_id);
		echo '<li>';
		$answer->print_summary($link);
		echo '</li>';
		$ids[] = $answer->id;
	}
	echo "</ol>\n";
	echo '</div>'."\n";
	$ids = implode(',', $ids);
	Haanga::Load('get_total_answers_by_ids.html', compact('type', 'ids'));
}

Comment::print_form($link, 8);
echo '</div>';
// Show the error if the comment couldn't be inserted
if (!empty($new_comment_error)) {
	echo '<script type="text/javascript">';
	echo '$(function(){mDialog.notify(\''._('Aviso'). ": $new_comment_error".'\')}, 5);';
	echo '</script>';
}
do_footer();
exit(0);
?>
