<?php
/*
Input (2 GET parameters): username, password
Process: Checks to see if a user with that password exists and starts their session
Output: A boolean variable that is true on success, false otherwise
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

session_start();

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
// Put data in variables
$username = (isset($_GET['username'])) ? ($_GET['username']) : (false);
$password = (isset($_GET['password'])) ? ($_GET['password']) : (false);

// Check for Data
if(!($password && $username)) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	// get data from database
	$query = "SELECT username, password FROM registered_users WHERE username = '$username' AND BINARY password = '$password'";
	$data = $databaseConnection->query($query);
    if ($data->num_rows > 0) {
		$_SESSION['username']  = $username;
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode(true);
		exit;	
	} else {
	    header(HTTP_OK); 
		header(API_RESPONSE_CONTENT);
    	echo json_encode(false); 
    	exit;
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>