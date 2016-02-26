<link href='/lasser/css/console.css' rel="stylesheet" />
<pre>
<?php 
echo "Starting Update\n";
echo exec('/usr/local/bin/update > /var/www/logs/laaser.log 2>&1');
echo file_get_contents('/var/www/logs/laaser.log');
echo "Update Done :)\n";
?>
</pre>