<?php
/*
Input: shipping_name, zip_code, state, city, street
Process: Adds this address to the list of the current active user's addresses
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
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

$shipping_name = (isset($_GET['shipping_name'])) ? ($_GET['shipping_name']) : (false);
$zip_code = (isset($_GET['zip_code'])) ? ($_GET['zip_code']) : (false);
$state = (isset($_GET['state'])) ? ($_GET['state']) : (false);
$city = (isset($_GET['city'])) ? ($_GET['city']) : (false);
$street = (isset($_GET['street'])) ? ($_GET['street']) : (false);

// Check for Data
if($username === false) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if ($shipping_name === false || $zip_code === false || $state === false || $city === false || $street === false){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	$query = "INSERT INTO addresses (username, shipping_name, street, city, state, zip_code) VALUES('$username', '$shipping_name', '$street', '$city', '$state', '$zip_code')";	
	if($databaseConnection->query($query)) { // If query was successful
			header(HTTP_OK);
			header(API_RESPONSE_CONTENT);
			echo json_encode(TRUE);
			exit;
		}
	else{
		SendSingleError(HTTP_INTERNAL_ERROR, 'failed to insert new address into database', ERRTXT_FAILED_QUERY);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>