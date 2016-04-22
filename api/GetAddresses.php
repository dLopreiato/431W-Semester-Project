<?php
/*
Input: no parameters
Process: Gets the active user and then finds all addresses associated with that user
Output: Returns an array of current active user's addresses, unauthorized if nobody is logged in, empty array if no addresses
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

// Put data in variables
$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);

// Check for Data
if($username === false) {
	SendSingleError(HTTP_UNAUTHORIZED, 'no user is logged in', ERRTXT_UNAUTHORIZED);
} else {
	$query = "SELECT address_id, shipping_name, street, city, state, zip_code FROM addresses WHERE username = '$username'";
	$data = $databaseConnection->query($query);
	 if ($data->num_rows > 0) {
		$result = array();
		while ($row =$data->fetch_assoc()){
			$result[] = $row;
		}
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode($result);
		exit;
	} else  {
		$emptyArray = array();
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode($emptyArray);
		exit;	
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>