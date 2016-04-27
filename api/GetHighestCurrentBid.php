<?php
/*
Input (1 GET parameter): item_id
Process: Gets the max current bid on an item
Output: Returns the highest bid
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
$databaseConnection->set_charset(MYSQL_CHARSET);
// Put data in variables
$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);

// Check for Data
if($item_id === false) {
	SendSingleError(HTTP_INTERNAL_ERROR, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	
		$row = array("amount"=>"0");
        $query = "SELECT B.*, A.reserve_price FROM bids B, auctioned_by A WHERE B.item_id = '$item_id' AND A.item_id = B.item_id AND B.amount >= ALL (SELECT B2.amount FROM bids B2 WHERE B2.item_id = B.item_id) ORDER BY B.item_id";
		$data = $databaseConnection->query($query);
	
		if ($data->num_rows > 0){
			$row =$data->fetch_assoc();
		}
		

	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($row);
    exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>