#!/usr/bin/php -q

<?php

//check if run with root/sudo
if(posix_geteuid() !== 0){
    echo "Script requires root/sudo privileges.\n\n";
    exit(1);
}

while(empty($username)){
    $username = promptUser("New system user name");
}

while(true){
    $password = promptUser("User password");
    $passwordConfirm = promptUser("Confirm user password");

    if(empty($password)){
        echo "\nInvalid password detected. Please try again.\n";
    }elseif($password === $passwordConfirm){
        break;
    }else{
        echo "\nPasswords do not match. Please try again.\n";
    }
}

//TODO - check if user is already created with `id -u name`
echo "\nAdding user - ";
processCommand("useradd -m -p pass -s /bin/bash {$username}");

echo "\nSetting user's password - ";
processCommand("echo \"{$username}:{$password}\" | chpasswd");

//TODO - check if directory exists
$sftpDir = "/var/sftp-{$username}";
$sftpDirWeb = "{$sftpDir}/public_html";
echo "\nCreating SFTP directory - ";
processCommand("mkdir {$sftpDir} && mkdir {$sftpDirWeb}");

//TODO - check if permissions already correct
echo "\nUpdating ownership of SFTP directory - ";
processCommand("chown -R {$username}:{$username} {$sftpDirWeb}");

while(empty($vhost)){
    $vhost = promptUser("Apache VirtualHost directory name");
}

echo "\nLinking web-root - ";
processCommand("ln -s {$sftpDirWeb} /var/www/{$vhost}");

echo "\nAdding SSHD SFTP user config\n";
$sftpSshdConfig = "
Match User {$username}
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory {$sftpDir}
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
";

file_put_contents('/etc/ssh/sshd_config', $sftpSshdConfig, FILE_APPEND);

$serverName = promptUser("Apache VirtualHost ServerName", $vhost);
$serverAdmin = promptUser("Apache VirtualHost ServerAdmin", 'info@saywebsolutions.com');

echo "\nAdding Apache VirtualHost\n";
$vhostConfig = "
<VirtualHost *:80>
    ServerName {$serverName}
    ServerAdmin {$serverAdmin}
    DocumentRoot /var/www/{$vhost}
    <Directory /var/www/{$vhost}>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
   </Directory>
   ErrorLog \${APACHE_LOG_DIR}/error.log
   CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
";

file_put_contents("/etc/apache2/sites-available/{$vhost}.conf", $vhostConfig);

echo "\nRestarting SSH - ";
processCommand("service sshd restart");

echo "\nEnable VirtualHost - ";
processCommand("a2ensite {$vhost}");

echo "\nRestart Apache - ";
processCommand("service apache2 restart");

echo "\n\nScript excuted successfully.";
exit(0);


function promptUser($promptStr, $defaultVal=false){

    echo $defaultVal ? "{$promptStr} [{$defaultVal}]: " : "{$promptStr}: ";

    $name = chop(fgets(STDIN));

    if(empty($name)) {
        return $defaultVal;
    } else {
        return $name;
    }

}

function processCommand($command)
{

    echo "Command: {$command}";
    exec("{$command} 2>&1", $output, $returnCode);
    echo "\nResults (Code: {$returnCode}):\n\t".implode("\n\t", $output)."\n";
    shallWeContinue($returnCode);

    return null;

}

function shallWeContinue($returnCode, $question=false)
{

    $question = $question ? $question : "Previous command failed.";

    if($returnCode !== 0){
        $continue = promptUser("\n{$question} Continue? [y/n]", 'n');
    	if($continue !== 'y'){
	        echo "\nExiting.\n\n";
	        exit(1);
	    }
    }

    return null;

}
