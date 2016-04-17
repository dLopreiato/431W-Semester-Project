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
// Put data in variables  item_id, amount, address_id, card_number
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);
$bid_id = 0;
$item_id = (isset($_POST['item_id'])) ? ($_POST['item_id']) : (false);
$amount = (isset($_POST['amount'])) ? ($_POST['amount']) : (false);
$bid_won = "FALSE";

// Check for Data
if(!($item_id && $star_rating)) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Write data to database
	$query = "INSERT INTO bids (amount, bid_id, time, username, item_id, bid_won) VALUES('". $amount ."', $bid_id, NOW() , '". $username ."', item_id, '". $bid_won ."'";
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