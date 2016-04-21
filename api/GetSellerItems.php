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
	
	/* This is ultimately changing the behavior of this api call, to do something completely different. The reason I am
	changing it is because the purpose of this call was to be so that the user who is posting an item to sell can see
	all of the items they are allowed to sell. The behavior of what this WAS was showing all the postings already made.
	Which worked perfectly when a posting correlated to the seller owning the object, but no longer applies.

	// get data from database
	$query = "SELECT I.*, S.listed_price, S.number_in_stock  FROM items I, sold_by S WHERE I.seller='$username' AND S.item_id = I.item_id";	
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$sellingResult[] = $row;
		}
	}
	
	$query = "SELECT I.*, A.reserve_price, A.number_in_stock  FROM items I, auctioned_by A WHERE I.seller='$username' AND A.item_id = I.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$auctioningResult[] = $row;
		}
	}
	
	$query = "SELECT R.*, I.* FROM rentables R, items I WHERE I.seller='$username' AND R.item_id = I.item_id";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0) {
		while ($row =$data->fetch_assoc()){
			$rentingResult[] = $row;
		}
	}
	
	$result = array("selling" => $sellingResult,  "auctioning" => $auctioningResult, "renting" => $rentingResult);*/

	$sellerItemsQuery = "SELECT I.item_id, I.description, I.location, I.image, C.name FROM items I, categories C WHERE seller='$username' AND I.category_id=C.category_id";
	$sellerItemsResults = $databaseConnection->query($sellerItemsQuery);
	$result = array();
	while ($row = $sellerItemsResults->fetch_assoc()) {
		$result[] = $row;
	}
	
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>