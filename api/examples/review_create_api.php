<?php
/*
Input (3 POST parameters): item_id, star_rating, description
Process: Inserts inpuy into the ratings table
Output: A boolean variable that is true on success (on failure returns the error)
*/
require_once('../../lib/config.php');
require_once('../../lib/http_headers.php');
require_once('../../lib/api_common_error_text.php');
require_once('../../lib/api_error_functions.php');

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}

// Check for Data
if(!($_POST["item_id"] && $_POST["star_rating"])) {
	die ("One or more fields was incomplete, please go back and try again.");
} else {
	// Write data to database
	$query = "INSERT INTO _table_
		VALUES('0', $_POST['item_id'] && $_POST['star_rating'] && $_POST['description'], (SELECT GETDATE()))";
	$result = mysqli_query($databaseConnection, $query, MYSQLI_STORE_RESULT);
	if($result)
		echo("Review successfully posted!");
		return $result;
	else
		echo("Error writing to database, please try again. If issue persists, contact the administrator.");
		return $result;
}
?>