<?php
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
// Put data in variables  item_id, amount, address_id, card_number
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);
$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);
$amount = (isset($_GET['amount'])) ? ($_GET['amount']) : (false);
$card_number = (isset($_GET['card_number'])) ? ($_GET['card_number']) : (false);
$address_id = (isset($_GET['address_id'])) ? ($_GET['address_id']) : (false);

// Check for User Login
if (!(isset($_SESSION['username']))) {
	SendSingleError(HTTP_INTERNAL_ERROR, 'no user logged in', ERRTXT_UNAUTHORIZED);
}

// Check for Data
if($item_id === false || $amount === false || $card_number === false || $address_id === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Write data to database
	$query = "INSERT INTO bids (amount, time, username, item_id, card_number, address_id) VALUES('$amount', NOW() , '$username', $item_id, $card_number, $address_id)";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to post new bid into database', ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>