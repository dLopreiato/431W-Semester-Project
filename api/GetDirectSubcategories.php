<?php
/*
Input: 1 GET Parameter 
Process: Gets all the categories 
Output: Returns all the info from the categories table, error if no categories exist
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
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables
$category_id = (isset($_GET['category_id'])) ? ($_GET['category_id']) : (false);

if($category_id === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	// get data from database
	$query = "SELECT * FROM categories WHERE parent = '$category_id' ";
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
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode(0);
		exit;	
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>