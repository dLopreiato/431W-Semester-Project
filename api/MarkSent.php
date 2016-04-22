<?php
/*
Input (1 POST parameters): username
Process: Inserts input into the sales table
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
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

$sale_id = (isset($_GET['sale_id'])) ? ($_GET['sale_id']) : (false);
$rental_id = (isset($_GET['rental_id'])) ? ($_GET['rental_id']) : (false);

// Check for Data
if($username === false) {
	SendSingleError(HTTP_BAD_REQUEST, "username not found", ERRTXT_ID_NOT_FOUND);
} else {

	if($sale_id != FALSE){
		// find the item_id from the sale_id
		$query1 = "SELECT S.item_id FROM sales S, items I WHERE S.sale_id = $sale_id AND S.item_id=I.item_id AND I.seller = '$username'";

		if($databaseConnection->query($query1)->num_rows == 0) {
			SendSingleError(HTTP_UNAUTHORIZED, "this item is not sold by the logged in user", ERRTXT_UNAUTHORIZED);
		}

		// update sales set received to NOW() where sale_id
		
		$query = "UPDATE sales S SET sent = NOW() WHERE S.sale_id = $sale_id";
		if(!($databaseConnection->query( $query))) {
			SendSingleError(HTTP_INTERNAL_ERROR, "Update query failed.", ERRTXT_FAILED_QUERY);
		}
	}

	if($rental_id != FALSE){
		// find the item_id from the sale_id
		//$query1 = "SELECT R.item_id FROM rental_transaction R, rentables E WHERE R.rental_id = $rental_id AND R.rented_out_to_username = '$username' AND E.seller_username = '$username'";
		$query1 = "SELECT R.item_id FROM rental_transaction R, items I WHERE R.rental_id=$rental_id AND R.item_id=I.item_id AND I.seller='$username'";
	
		if($databaseConnection->query($query1)->num_rows == 0) {
			SendSingleError(HTTP_UNAUTHORIZED, "this item is not sold by the logged in user", ERRTXT_UNAUTHORIZED);
		}

		// update sales set received to NOW() where sale_id
		
		$query = "UPDATE rental_transaction R SET sent = 1 WHERE R.rental_id = $rental_id";
		if(!($databaseConnection->query( $query))) {
			SendSingleError(HTTP_INTERNAL_ERROR, "Update query failed.", ERRTXT_FAILED_QUERY);
		}
	}

	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
    echo json_encode(TRUE);
    exit;
 
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>