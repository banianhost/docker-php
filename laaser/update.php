<link href='/laaser/css/console.css' rel="stylesheet" />
<pre>
<?php 

echo "Starting Update\n";
ob_flush();
flush();

echo exec('/update > /var/www/logs/laaser.log 2>&1');
echo file_get_contents('/var/www/logs/laaser.log');

echo "Update Done :)\n";

?>
</pre>