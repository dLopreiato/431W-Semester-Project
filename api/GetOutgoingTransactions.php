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
// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

if(!($username)) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else {
	
	$salesResult = array();
	$rentalResult = array();
	
	// get data from database
	$query = "SELECT A.sale_id, A.amount, A.time, A.sent, A.received, I.description FROM sold_by S, sales A, items I WHERE S.username='$username' AND A.item_id = S.item_id AND I.item_id = A.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$salesResult[] = $row;
		}
	}
	
	$query = "SELECT R.rental_id, R.serial_number, R.rental_date, R.sent, R.received, I.description, R.was_returned FROM rentables E, rental_transaction R, items I WHERE E.seller_username='$username' AND R.item_id = E.item_id AND I.item_id = R.item_id";
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