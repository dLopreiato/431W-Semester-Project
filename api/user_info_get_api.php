<?php
/*
Input (1 GET parameter): username
Process: Gets the user's info from the registered_users table
Output: Returns an associative array of the user's info (sends single error on failure)
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
// Put data in variables
$username = (isset($_GET['username'])) ? ($_GET['username']) : (false);

// Check for Data
if(!($username)) {
	SendSingleError(HTTP_INTERNAL_ERROR, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// get data from database
	$query = "SELECT * FROM registered_users WHERE username = '$username'";
	$data = $databaseConnection->query($query);
	if ($row = $data->fetch_assoc()){
    	header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode($row);
	    exit;
	} else  {
	   SendSingleError(HTTP_INTERNAL_ERROR, 'user not found', ERRTXT_FAILED_QUERY);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>