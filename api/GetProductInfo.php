<?php
/*
Input (1 GET parameter): item_id
Process: Gets ratings from the table
Output: Returns the rating information on success (on failure returns the error)
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

// Check for Data
if($item_id === false) {
	SendSingleError(HTTP_INTERNAL_ERROR, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// get data from database
    $infoQuery = "SELECT I.description, I.location, I.image, I.category_id FROM items I WHERE I.item_id=$item_id";
    $infoResult = $databaseConnection->query($infoQuery);
    if ($infoResult === false || $infoResult->num_rows <= 0) {
        SendSingleError(HTTP_INTERNAL_ERROR, "info query broke or item doesn't exist", ERRTXT_FAILED_QUERY);
    }
    $data = $infoResult->fetch_assoc();

    $auctionInfo = "SELECT reserve_price FROM auctioned_by WHERE item_id=$item_id AND number_in_stock > 0";
    $auctionResult = $databaseConnection->query($auctionInfo);
    if ($auctionResult !== false && $auctionResult->num_rows > 0) {
        $data = array_merge($data, $auctionResult->fetch_assoc());
    }

    $salesInfo = "SELECT listed_price FROM sold_by WHERE item_id=$item_id AND number_in_stock > 0";
    $salesResult = $databaseConnection->query($salesInfo);
    if ($salesResult !== false && $salesResult->num_rows > 0) {
        $data = array_merge($data, $salesResult->fetch_assoc());
    }
	
    $rentalInfo = "SELECT serial_number, rental_in_days, rental_price FROM rentables WHERE item_id=$item_id AND on_shelf=1";
    $rentalResult = $databaseConnection->query($rentalInfo);
    if ($rentalResult !== false) {
        while ($row = $rentalResult->fetch_assoc()) {
            $data['rentables'][] = $row;
        }
    }


	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($data);
    exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>