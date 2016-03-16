<?php
/*
Input (3 POST parameters): item_id, star_rating, description
Process: Inserts inpuy into the ratings table
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
$item_id = $_POST['item_id'];
$star_rating = $_POST['star_rating'];
$description = $_POST['description'];

// Check for Data
if(!($item_id && $star_rating)) {
	SendSingleError(HTTP_INTERNAL_ERROR, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
	// Write data to database

	$query = "INSERT INTO ratings VALUES(0, $item_id, $star_rating, '". $description ."', CURRENT_DATE())";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
    	echo json_encode(TRUE);
    	exit;
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, /*'query failed'*/$query, ERRTXT_FAILED);

?>