<?php
header('Content-Type: text/plain; charset="utf-8"');
$app = realpath(__DIR__.'/..');
if (!$app) {
    header('Status: 500');
    echo "#!/bin/bash".PHP_EOL;
    echo "".PHP_EOL;
    echo "# ----------------------------- #".PHP_EOL;
    echo "# --- Internal server error --- #".PHP_EOL;
    echo "# ----------------------------- #".PHP_EOL;
    echo "".PHP_EOL;
    echo 'echo "Internal server error"'.PHP_EOL;
    exit(1);
}
readfile($app.'/install');
