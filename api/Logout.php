<?php
require_once('../lib/config.php');
require_once('../lib/http_headers.php');

session_start();
session_destroy();

header(HTTP_OK);
header(API_RESPONSE_CONTENT);
echo json_encode(true);
exit;

?>
