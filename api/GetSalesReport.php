<?php
/*
Input: 
Process: Finds all reviews with each number of stars 
Output: Returns an array of number_of_ratings, average rating, and how many of each star ranking (five_star, four_star...)
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

$query = "SELECT category_id, name, parent FROM categories";
$data = $databaseConnection->query($query);

if ($data->num_rows > 0) {
	
	$categories = array();
	while ($row =$data->fetch_assoc()){
		$categories[] = $row;
	}

	foreach ($categories as $result) {
	    $c = $result['category_id'];
	    $n = $result['name'];
	    $p = $result['parent'];

	    $query = "SELECT COUNT(*) FROM sales WHERE item_id = (SELECT item_id FROM items WHERE category_id = $c)";
	    $n = $databaseConnection->query($query);
	}

	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($categories);
	exit;

}
SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>