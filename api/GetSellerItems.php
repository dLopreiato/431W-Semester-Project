<?php
/*
Input: 1 GET parameter - username of the seller
Process:  Gets all the items the user sells, auctions, or rents
Output: An array of all the items that belong to this user
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
$username = (isset($_GET['username'])) ? ($_GET['username']) : (false);

if($username === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	$sellingResult = array();
	$auctioningResult = array();
	$rentingResult = array();
	
	// get data from database
	$query = "SELECT I.*, S.listed_price, S.number_in_stock  FROM items I, sold_by S WHERE S.username='$username' AND S.item_id = I.item_id";	
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$sellingResult[] = $row;
		}
	}
	
	$query = "SELECT I.*, A.reserve_price, A.number_in_stock  FROM items I, auctioned_by A WHERE A.username='$username' AND A.item_id = I.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$auctioningResult[] = $row;
		}
	}
	
	$query = "SELECT R.*, I.* FROM rentables R, items I WHERE R.seller_username='$username' AND R.item_id = I.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$rentingResult[] = $row;
		}
	}
	
	$result = array("selling" => $sellingResult,  "auctioning" => $auctioningResult, "renting" => $rentingResult);
	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>