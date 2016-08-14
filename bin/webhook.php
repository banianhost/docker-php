<?php 
echo "<pre>";

$secret = trim(file_get_contents('/WEBHOOK_SECRET'));
if(!$secret) die('WEBHOOK_SECRET is not defined');
if(!isset($_REQUEST['secret']) || $_REQUEST['secret']!==$secret) die('Invalid Secret');
$secret=null;

echo "Starting Update\n";

echo exec('/bin/update > /var/www/logs/webhook.log 2>&1');
echo file_get_contents('/var/www/logs/webhook.log');

echo "Update Done!\n";

echo "</pre>";