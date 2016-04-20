<?php
/*
Input: address_id to delete
Process: Deletes this address from the active user's address list
Output: True on success, error otherwise
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

$address_id = (isset($_GET['address_id'])) ? ($_GET['address_id']) : (false);

// Check for Data
if($username === false) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if ($address_id === false){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	$query = "SELECT * FROM addresses WHERE address_id = '$address_id' AND username = '$username'";
	$data = $databaseConnection->query($query);

	if ($data->num_rows > 0) {
		$query = "DELETE FROM addresses WHERE address_id = '$address_id' AND username = '$username' ";	
		if($databaseConnection->query($query)) { // If query was successful
				header(HTTP_OK);
				header(API_RESPONSE_CONTENT);
				echo json_encode(TRUE);
				exit;
			}
		else{
			SendSingleError(HTTP_INTERNAL_ERROR, 'failed to delete address from database', ERRTXT_FAILED_QUERY);
		}
	}
	else{
		SendSingleError(HTTP_BAD_REQUEST, 'address with this ID does not exist or it does not belong to this user', ERRTXT_FAILED_QUERY);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>