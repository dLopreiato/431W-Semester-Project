<?php
/*
Input: no parameters
Process: Gets the current active user's name and email from the session data
Output: Returns current active user's username, name and email,  (returns false if no user is currently logged in)
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
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

// Check for Data
if($username === false) {
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
    echo json_encode(FALSE);
	exit;
} else {
	// get data from database
	$query = "SELECT username, name, email FROM registered_users WHERE username = '$username'";
	$data = $databaseConnection->query($query);
	 if ($data->num_rows > 0) {
    	header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode($data->fetch_assoc());
	    exit;
	} else  {
		SendSingleError(HTTP_BAD_REQUEST, 'unknown user', ERRTXT_FAILED);	
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>