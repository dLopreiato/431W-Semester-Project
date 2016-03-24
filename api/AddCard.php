<?php
/*
Input: exp_date, card_type,card_number
Process: Adds this credit card to the active user's credit card list
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

$card_number = (isset($_GET['card_number'])) ? ($_GET['card_number']) : (false);
$card_type = (isset($_GET['card_type'])) ? ($_GET['card_type']) : (false);
$exp_date = (isset($_GET['exp_date'])) ? ($_GET['exp_date']) : (false);

// Check for Data
if(!($username)) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if (!($card_number && $card_type && $exp_date)){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	$query = "INSERT INTO credit_cards (username, card_number, card_type, exp_date) VALUES('$username', '$card_number', '$card_type', '$exp_date')";	
	if($databaseConnection->query($query)) { // If query was successful
			header(HTTP_OK);
			header(API_RESPONSE_CONTENT);
			echo json_encode(TRUE);
			exit;
		}
	else{
		SendSingleError(HTTP_INTERNAL_ERROR, 'failed to insert new card into database', ERRTXT_FAILED_QUERY);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>