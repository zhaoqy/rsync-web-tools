<?php
 set_time_limit(0);

 /*
 *Qequest Test
 **/

$envpath = isset($_POST['envpath']) ? $_POST['envpath'] : 'test';

$srcpath = $_POST['srcpath'];
$destpath = $_POST['destpath'];

$execCommand = "./rsync.sh -env {$envpath} -srcpath {$srcpath} -destpath {$destpath}";

echo $execCommand;
echo "\n";
echo shell_exec($execCommand);

?>