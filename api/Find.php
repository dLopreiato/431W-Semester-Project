<?php
/*
Input (1 POST parameters): username
Process: Inserts input into the sales table
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

$term = (isset($_GET['term'])) ? ($_GET['term']) : (false);


// Check for Data
if(!($term)) {
	SendSingleError(HTTP_BAD_REQUEST, "bad term.", ERRTXT_ID_NOT_FOUND);
} else {
	$query = "SELECT I.item_id, I.description, I.image, I.category_id, C.name FROM items I, categories C WHERE C.category_id = I.category_id AND I.description LIKE '%$term%'";

	if($result = $databaseConnection->query( $query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode($result->fetch_all(MYSQLI_ASSOC));
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, /*'failed to complete purchase transaction.'*/$databaseConnection->error, ERRTXT_FAILED_QUERY);
    }

}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>