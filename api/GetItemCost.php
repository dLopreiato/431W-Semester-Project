<?php
/*
Input: 1 GET Parameter  - item_id
Process: Looks through the sold_by, auctioned_by tables to see if it's currently for sale 
Output: Returns a string representing either a price (if being sold), info that you can bid (if auctioned), rental price (if rentable), or not for sale (if none)
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}

// Put data in variables
$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);

if($item_id === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	// get data from database
	$query = "SELECT listed_price FROM sold_by WHERE item_id = '$item_id' AND number_in_stock > 0";
	$data = $databaseConnection->query($query);

	if ($data->num_rows > 0) {
		$row = $data->fetch_assoc();
		$result = "$" . $row["listed_price"];
		
	} else  {
		
		$query = "SELECT item_id FROM auctioned_by WHERE item_id = '$item_id' AND number_in_stock > 0";
		$data = $databaseConnection->query($query);

		if ($data->num_rows > 0) {
			$result = "Bid Now!";
		
		} else  {
			 $query = "SELECT rental_price FROM rentables WHERE item_id = '$item_id' AND on_shelf = 1";
			$data = $databaseConnection->query($query);

			if ($data->num_rows > 0) {
				$row = $data->fetch_assoc();
				$result = "Rent for $" . $row["rental_price"];
			} 
			else{
				$result = "Not available";
			}
		}	
	}
	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>