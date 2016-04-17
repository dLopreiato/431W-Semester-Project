<?php
/*
Input (3 POST parameters): item_id, listed_price, number_in_stock
Process: Inserts input into the sold_by table
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
$listed_price = (isset($_POST['listed_price'])) ? ($_POST['listed_price']) : (false);
$number_in_stock = (isset($_POST['number_in_stock'])) ? ($_POST['number_in_stock']) : (false);

// Check for User Login
if (!(isset($_SESSION['login']) && $_SESSION['login'] != '')) {
	SendSingleError(HTTP_INTERNAL_ERROR, 'no user logged in', ERRTXT_UNAUTHORIZED);
}

// Check for Data
if(!($item_id && $listed_price && $number_in_stock)) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Check ownership
	// Write data to database
	$query = "INSERT INTO sold_by (item_id, username, listed_price, number_in_stock) VALUES($item_id, '". $username . "', '" . $listed_price . "', $number_in_stock)";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to post item for sale: ' . $query, ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>