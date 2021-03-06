<?php
/*
Input: no parameters
Process: Gets everything from the badges table
Output: Returns all the info from the badges table, error if no badges exist
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
$databaseConnection->set_charset(MYSQL_CHARSET);

// get data from database
$query = "SELECT * FROM badges";
$data = $databaseConnection->query($query);

if ($data->num_rows > 0) {
	
	$result = array();
	while ($row =$data->fetch_assoc()){
		$result[] = $row;
	}
	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
	
} else  {
	SendSingleError(HTTP_INTERNAL_ERROR, 'no badges exist', ERRTXT_FAILED);	
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>