<?php
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
// Put data in variables
if (!isset($_SESSION['username'])) {
    SendSingleError(HTTP_UNAUTHORIZED, 'user not logged in', ERRTXT_UNAUTHORIZED);
}
$username = $_SESSION['username'];
$description = (isset($_POST['description'])) ? ($_POST['description']) : (false);
$location = (isset($_POST['location'])) ? ($_POST['location']) : (false);
$category_id = (isset($_POST['category_id'])) ? ($_POST['category_id']) : (false);
$image = (isset($_POST['image'])) ? ($_POST['image']) : (false);

// Check for Data
if($description === false || $location === false || $category_id === false || $image === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_ID_NOT_FOUND);
} else {
    $checkSellerResults = $databaseConnection->query("SELECT username FROM sellers WHERE username='" . $username . "'");
    if ($checkSellerResults === false) {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to select the user from the sellers table', ERRTXT_FAILED_QUERY);
    }
    if ($checkSellerResults->num_rows <= 0) {
        SendSingleError(HTTP_UNAUTHORIZED, 'user not an authorized seller', ERRTXT_UNAUTHORIZED);
    }

	// Write data to database
	$query = "INSERT INTO items (seller, description, location, category_id, image) VALUES('" . $username . "', '". $description ."', '". $location ."', '" .$category_id . "', '". $image ."')";
	if($databaseConnection->query($query)) { // If query was successful
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode(TRUE);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, 'failed to insert new item into database', ERRTXT_FAILED_QUERY);
    }
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>