<?php
/*
Input (2 GET parameters): item_id, serial_number
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

// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);
$serial_number = (isset($_GET['serial_number'])) ? ($_GET['serial_number']) : (false);

// Check for Data
if(!($username)) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else if (!($item_id &&  $serial_number)){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	$query = "SELECT * FROM rentables WHERE item_id = '$item_id' AND serial_number = '$serial_number' AND seller_username = '$username'";	
	$data = $databaseConnection->query($query);
	$query2 = "SELECT * FROM rental_transaction WHERE item_id = '$item_id' AND serial_number = '$serial_number' AND was_returned = 0";	
	$data2 = $databaseConnection->query($query2);
    if ($data->num_rows > 0 && $data2->num_rows > 0) {

		// If it's late, add a fee
		$row = $data->fetch_assoc();
		$row2 = $data2->fetch_assoc();
		if (getdate() > $row2["due_date"]){
			$balance_due = $row["rental_price"];
			$query = "UPDATE sellers SET balance_due = balance_due + '$balance_due' WHERE username = '$username' ";
			if(!($databaseConnection->query($query))) { 
				SendSingleError(HTTP_INTERNAL_ERROR, 'failed to update amount seller\'s balance due', ERRTXT_FAILED_QUERY);
			}
		}
		
		$query = "UPDATE rentables SET on_shelf = 1 WHERE item_id = '$item_id' AND serial_number = '$serial_number' ";	
		$query2 = "UPDATE rental_transaction SET was_returned = 1 WHERE item_id = '$item_id' AND serial_number = '$serial_number' AND was_returned = 0 ";
		if($databaseConnection->query($query) && $databaseConnection->query($query2)) { // If query was successful
					header(HTTP_OK);
					header(API_RESPONSE_CONTENT);
					echo json_encode(TRUE);
					exit;
		}else{
			SendSingleError(HTTP_INTERNAL_ERROR, 'failed to update rental status in database', ERRTXT_FAILED_QUERY);
		}
	}else{
		SendSingleError(HTTP_UNAUTHORIZED, 'user is not the seller of this item or item does not exist', ERRTXT_UNAUTHORIZED);
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>