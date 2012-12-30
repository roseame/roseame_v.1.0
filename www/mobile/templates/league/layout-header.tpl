<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta content="text/html; charset=UTF8" http-equiv="content-type">
  <link rel="stylesheet" href="{{globals.base_static}}css/es/nivea_2012.css" type="text/css" media="screen" />
  <link href='http://fonts.googleapis.com/css?family=Open+Sans|Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js" type="text/javascript"></script> 
  <script src="{{globals.base_url}}js/{{globals.js_main}}" type="text/javascript"></script>
  <link rel="stylesheet" href="{{globals.base_static}}css/jquery.simplemodal.css" type="text/css" media="screen" />
  <script src="{{globals.base_url}}js/jquery.simplemodal.js"></script>
  <title>menéame / NIVEA FOR MEN</title>

</head>
{% if accepted_terms === FALSE %}
<script>
$(document).ready(function() {
	$("#terms").modal({close: false});
});
</script>
{% endif %}


{%spacefull%}
<script src="/js/league.js"></script>
<script type="text/javascript">
if(top.location != self.location)top.location = self.location;
base_key="{{ globals.security_key }}";
user_id = {{ current_user.user_id }};
user_login = '{{ current_user.user_login }}';
mobile_client = {{ globals.mobile }};
$(function() {
	var vstatus = ["{% trans _("¡votado!") %}", "{% trans _("gana") %}", "{% trans _("empate") %}"],
		url	 = "{{globals.base_url}}backend/league_vote.php?";
    league_init(vstatus, url);
    $('a#bases').click(function() {
	    $("#terms").modal();
        return false;
    });
});
(function() {
var useSSL = 'https:' == document.location.protocol;
var src = (useSSL ? 'https:' : 'http:') +
'//www.googletagservices.com/tag/js/gpt.js';
document.write('<scr' + 'ipt src="' + src + '"></scr' + 'ipt>');
})();
</script>
<script>
googletag.defineSlot('/10377667/MNA-CEN-RECT', [500, 250],
'div-gpt-ad-1345640121649-0').addService(googletag.pubads());
googletag.pubads().enableSyncRendering();
googletag.pubads().enableSingleRequest();
googletag.enableServices();
googletag.pubads().setTargeting("site","pmnm");
if (navigator.userAgent.match(/iPad/i) != null) { googletag.pubads().setTargeting("ua", "ipad"); }
	else if (navigator.userAgent.match(/iPhone/i) != null) { googletag.pubads().setTargeting("ua", "iphone"); } 
</script>
{% endspacefull %}

<body>

<div id="terms" style="display:none">
Ya sabemos lo que te gusta votar y que sabes quién va a ganar cada partido de liga, así que <b>bienvenido a la porra de liga de menéame deportes</b>, que hemos programado con el patrocinio de NIVEA FOR MEN como puedes ver.<br /><br />Menea el equipo ganador o la casilla de empate, y veremos si la comunidad menéame acierta más con la liga que los locutores deportivos.<br /><br />Sólo puedes votar una vez por partido, tienes 5 minutos para cambiar tu voto, y <b>necesitas un usuario en menéame</b>. Si aún no lo tienes puedes crearlo <b><a href="http://{{globals.server_name}}/register.php">aquí</a></b>; cuando lo tengas, si no puedes votar asegúrate que has hecho <b><a href="http://{{globals.server_name}}/login.php?return=%2Fnivea%2F">login</a></b>.<br /><br />Podrás votar cada partido desde que abramos las votaciones hasta una hora antes del inicio del partido.<br /><br />
    {% if accepted_terms === FALSE %}
	<form method="POST">
		<input type="submit" name="terms" value="{% trans _("Acepto") %}" />
		<input type="submit" name="terms" value="{% trans _("Rechazo") %}" />
	</form>
    {% endif %}
</div>

<div id="header-top">
  <ul id="edlist">
	{% for s in sites %}
		<li>
			<a href="http://{{ s.server_name }}{{ s.base_url }}">{{ s.name_long|default:s.name}}</a>
		</li>
	{% endfor %}
  </ul>
  {% include "header_userinfo.html" %}
</div>
  <div class="mnm-logo">
	 <a href="http://{{globals.server_name}}">
		<img src="{{globals.base_static}}img/nivea_2012/mnmd_01.png" widht="150" height="45" alt="menéame deportes" title="ir a menéame deportes" />
	 </a>
  </div>

<div class="banners-container">
  <div class="banner-lateral-l"><img src="{{globals.base_static}}img/nivea_2012/background_02.png" width="143" heigh="74" alt="NIVEA FOR MEN" title="NIVEA FOR MEN" /></div>
    <!-- MNA-CEN-RECT -->
    <div id='div-gpt-ad-1345640121649-0' class="banner-central">
    <script type='text/javascript'>
    googletag.display('div-gpt-ad-1345640121649-0');
    </script>
    </div>
  <div class="banner-lateral-r"><img src="{{globals.base_static}}img/nivea_2012/background_03.png" widht="101" height="318" alt="NIVEA FOR MEN" title="NIVEA FOR MEN" /></div>
</div>

<div class="bases">
	<p><a id="bases" href="#">consultar las instrucciones</a></p>
</div>
