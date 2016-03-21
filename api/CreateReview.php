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

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
// Put data in variables
$item_id = (isset($_POST['item_id'])) ? ($_POST['item_id']) : (false);
$star_rating = (isset($_POST['star_rating'])) ? ($_POST['star_rating']) : (false);
$description = (isset($_POST['description'])) ? ($_POST['description']) : (false);

// Check for Data
if(!($item_id && $star_rating)) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Write data to database
	$query = "INSERT INTO ratings (item_id, star_ranking, description, review_date) VALUES($item_id, $star_rating, '". $description ."', CURRENT_DATE())";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    }
    else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to insert new rating into database', ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>