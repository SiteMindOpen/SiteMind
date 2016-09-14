<?php

$password = $_REQUEST['pw1'];
$username = $_REQUEST['username'];
$autopwcheck = "auto";
$userdb = file('/var/www/html/admin/usernames.txt', FILE_IGNORE_NEW_LINES);

if (preg_match('/[\'^£$%&*!()}{@#~?><>,|=_+¬-]/', $username))
	die("Username can not have special characters");

if(strlen($username) < 5)
    die("Username must be at least 5 characters");

if(strlen($username) > 20)
    die("Username can not be over 20 chracters");

if (in_array($username, $userdb))
    die('This username is already in use');

if ($_POST["autopw"] == $autopwcheck){
    
  if(strlen($password) > 0)
      die("You can't use both password methods");
}

if ($_POST["autopw"] !== $autopwcheck){

  if(strlen($password) < 8)
      die("Password must be at least 8 characters");

  if(strlen($password) > 64)
      die("Password can not be over 64 chracters");

  if ($_POST["pw1"] != $_POST["pw2"])
      die("passwords do not match");
}
$command = escapeshellcmd('/var/www/html/admin/bin/a2conf.sh');
$output = shell_exec($command . ' ' . $username . ' ' . $password);
mkdir("/var/www/html/$username", 0755);
$options = array('cost' => 11);
echo password_hash("rasmuslerdorf", PASSWORD_BCRYPT, $options)."\n";
?>
