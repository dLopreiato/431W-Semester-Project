<?php
/*
Input (1 GET parameters): rental_id
Process: Username taken from active user, sets on_shelf to 1, adds balance due if item is late
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
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

$rental_id = (isset($_GET['rental_id'])) ? ($_GET['rental_id']) : (false);

// Check for Data
if($username === false) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if ($rental_id === false){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	$query = "SELECT * FROM rentables R, rental_transaction T WHERE T.rental_id = '$rental_id' AND R.seller_username = '$username' AND T.was_returned = 0 AND T.item_id = R.item_id AND T.serial_number = R.serial_number";	
	$data = $databaseConnection->query($query);
    if ($data->num_rows > 0) {
		
		$row = $data->fetch_assoc();
		$item_id = $row["item_id"];
		$serial_number = $row["serial_number"];

		// If it's late, add a fee
		if (date("Y-m-d H:i:s") > $row["due_date"]){
			$balance_due = $row["rental_price"];
			$query = "UPDATE sellers SET balance_due = balance_due + '$balance_due' WHERE username = '$username' ";
			if(!($databaseConnection->query($query))) { 
				SendSingleError(HTTP_INTERNAL_ERROR, 'failed to update amount seller\'s balance due', ERRTXT_FAILED_QUERY);
			}
		}
		
		$query = "UPDATE rentables SET on_shelf = 1 WHERE item_id = '$item_id' AND serial_number = '$serial_number' ";	
		$query2 = "UPDATE rental_transaction SET was_returned = 1 WHERE rental_id = '$rental_id' AND was_returned = 0 ";
		if($databaseConnection->query($query) && $databaseConnection->query($query2)) { // If query was successful
					header(HTTP_OK);
					header(API_RESPONSE_CONTENT);
					echo json_encode(TRUE);
					exit;
		}else{
			SendSingleError(HTTP_INTERNAL_ERROR, 'failed to update rental status in database', ERRTXT_FAILED_QUERY);
		}
	}else{
		SendSingleError(HTTP_UNAUTHORIZED, 'user is not the seller of this item or item does not exist/is currently not rented out', ERRTXT_UNAUTHORIZED);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>