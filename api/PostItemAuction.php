<?php
/*
Input (3 POST parameters): item_id, star_rating, description
Process: Inserts input into the ratings table
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
// Put data in variables
$item_id = (isset($_POST['item_id'])) ? ($_POST['item_id']) : (false);
$username = $_SESSION['username'];
$reserve_price = (isset($_POST['reserve_price'])) ? ($_POST['reserve_price']) : (false);
$number_in_stock = (isset($_POST['number_in_stock'])) ? ($_POST['number_in_stock']) : (false);

// Check for Data
if(!($item_id && $reserve_price && $number_in_stock)) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Check ownership
	// Write data to database
	$query = "INSERT INTO auctioned_by (item_id, username, reserve_price, number_in_stock) VALUES($item_id, '". $username . "', '" . $reserve_price . "', $number_in_stock)";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to post item for auction: ' . $query, ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>