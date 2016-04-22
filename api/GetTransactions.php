<?php
/*
Input: none
Process:  Gets all transactions for this user (bids that turned to sales, purchases, rentals)
Output: An array of all the transactions belonging to this user
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

if($username === false) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else {
	
	$salesResult = array();
	$rentalResult = array();
	
	// get data from database
	$query = "SELECT I.description, S.* FROM sales S, items I WHERE S.username = '$username' AND I.item_id = S.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$salesResult[] = $row;
		}
	}
	
	$query = "SELECT I.description, R.* FROM rental_transaction R, items I WHERE R.rented_out_to_username = '$username' AND I.item_id = R.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$rentalResult[] = $row;
		}
	}
	
	$result = array("purchases" => $salesResult, "rentals" => $rentalResult);
	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>