<?php
require_once('../../lib/config.php');
require_once('../../lib/http_headers.php');
require_once('../../lib/api_common_error_text.php');
require_once('../../lib/api_error_functions.php');

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}

// we're going to put all of the contents of test_table into the $testValues array
$testValues = array();
$testTableQuery = 'SELECT test_key, test_attribute FROM test_table';
$testTableResults = $databaseConnection->query($testTableQuery);
while ($testTableRow = $testTableResults->fetch_assoc()) {
    $testValues[] = $testTableRow;
}

// if at least one row is in the table
if (!empty($testValues)) {
    header(HTTP_OK);
    header(API_RESPONSE_CONTENT);
    echo json_encode($testValues);
    exit;
}

// if we got here, the table is empty and so we're going to return an error because this is an example
SendSingleError(HTTP_INTERNAL_ERROR, 'user not authorized', ERRTXT_UNSETVARIABLE);

?>