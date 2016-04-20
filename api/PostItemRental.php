<?php
/*
Input (4 POST parameters): item_id, serial_number, rental_time_unit, price_listing
Process: Inserts input into the rentables table
Output: A boolean variable that is true on success (on failure returns the error)
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
$item_id = (isset($_POST['item_id'])) ? ($_POST['item_id']) : (false);
$username = $_SESSION['username'];
$serial_number = (isset($_POST['serial_number'])) ? ($_POST['serial_number']) : (false);
$rental_time_unit = (isset($_POST['rental_time_unit'])) ? ($_POST['rental_time_unit']) : (false);
$price_listing = (isset($_POST['price_listing'])) ? ($_POST['price_listing']) : (false);

// Check for User Login
if (!(isset($_SESSION['login']) && $_SESSION['login'] != '')) {
	SendSingleError(HTTP_INTERNAL_ERROR, 'no user logged in', ERRTXT_UNAUTHORIZED);
}

// Check for Data
if($item_id === false ||  $serial_number === false ||  $rental_time_unit === false ||  $price_listing === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Check ownership
	// Write data to database
	$query = "INSERT INTO rentables (item_id, serial_number, rental_in_days, rental_price, on_shelf, seller_username) VALUES($item_id, '" . $serial_number . "', '" . $rental_time_unit . "', '" . $price_listing . "', 1, '". $username . "',)";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to post item for rental: ' . $query, ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>