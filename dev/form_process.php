<html>
<head>
</head>

<?php
	$domain = $_REQUEST['domain'];
	$command = escapeshellcmd('/var/www/html/sitemind/hello.sh');
	$output = shell_exec($command . ' ' . $domain);
?>

<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript">
window.location.replace("scorecard.html");
</script>
