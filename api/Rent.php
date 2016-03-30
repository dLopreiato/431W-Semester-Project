<?php
/*
Input (4 GET parameter): item_id, serial_number, address_id, card_number
Process: Username taken from active user, sets on_shelf set to 0, new rent transaction created in rental_transactions table
Output: True on success, error on failure
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

$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);
$serial_number = (isset($_GET['serial_number'])) ? ($_GET['serial_number']) : (false);
$address_id = (isset($_GET['address_id'])) ? ($_GET['address_id']) : (false);
$card_number = (isset($_GET['card_number'])) ? ($_GET['card_number']) : (false);

// Check for Data
if(!($username)) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if (!($item_id && $address_id && $serial_number  && $card_number)){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	// Should we do error checking her to make sure it's not already rented? aka make sure on_shelf is one?
	$query = "UPDATE rentables SET on_shelf = 0 WHERE item_id = '$item_id' AND serial_number = '$serial_number' ";	
	if($databaseConnection->query($query)) { // If query was successful
		$query = "INSERT INTO rental_transaction (item_id, serial_number, username, rental_date, address_id) VALUES('$item_id', '$serial_number', '$username', now(), '$address_id')";	
		if($databaseConnection->query($query)) { // If query was successful
				header(HTTP_OK);
				header(API_RESPONSE_CONTENT);
				echo json_encode(TRUE);
				exit;
		}
		else{
			SendSingleError(HTTP_INTERNAL_ERROR, 'failed to enter the rental transaction into the database', ERRTXT_FAILED_QUERY);
		}
	}
	else{
		SendSingleError(HTTP_INTERNAL_ERROR, 'failed to update rental status in database', ERRTXT_FAILED_QUERY);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>