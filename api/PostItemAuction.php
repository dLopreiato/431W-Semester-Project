<?php
/*
Input (3 POST parameters): item_id, reserve_price, number_in_stock
Process: Inserts input into the auctioned_by table
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
// check user loggin
if (!isset($_SESSION['username'])) {
    SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
}

// Put data in variables
$username = $_SESSION['username'];
$item_id = (isset($_POST['item_id'])) ? ($_POST['item_id']) : (false);
$reserve_price = (isset($_POST['reserve_price'])) ? ($_POST['reserve_price']) : (false);
$number_in_stock = (isset($_POST['number_in_stock'])) ? ($_POST['number_in_stock']) : (false);

// Check for Data
if($item_id === false ||  $reserve_price === false ||  $number_in_stock === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Check ownership
    $ownershipCheck = "SELECT seller FROM items WHERE item_id='$item_id' AND seller='$username'";
    $result = $databaseConnection->query($ownershipCheck);
	if ($result->num_rows == 0) {
        SendSingleError(HTTP_UNAUTHORIZED, 'this item does not belong to this seller', ERRTXT_UNAUTHORIZED);
    }

	// Write data to database
    $changeValuesQuery = "INSERT INTO auctioned_by (item_id, reserve_price, number_in_stock) VALUES ($item_id, $reserve_price, $number_in_stock) "
        . "ON DUPLICATE KEY UPDATE reserve_price=$reserve_price, number_in_stock=$number_in_stock";
	if($databaseConnection->query($changeValuesQuery)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to post item for auction: ' . $changeValuesQuery, ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>