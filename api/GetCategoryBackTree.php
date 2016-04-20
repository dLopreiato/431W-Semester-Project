<?php
/*
Input (1 GET parameter): category_id
Process:  Finds the parent of each category until it reaches the top of the tree
Output: An array of all the category_ids and corresponding names, from most general to most specific
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

function getParentInfo($databaseConnection, $category_id) {
    if (!is_numeric($category_id))
    {
        $emptyArray = array();
        return $emptyArray;
    }
    else
    {
        $query = "SELECT category_id, name, parent FROM categories WHERE category_id = '$category_id' ";
        $data = $databaseConnection->query($query);
      
		if ($data->num_rows > 0) {
				$result = $data->fetch_assoc();
		}
		else{
			$result = array();
		}
		return $result;	
    }    
}

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
// Put data in variables
$category_id = (isset($_GET['category_id'])) ? ($_GET['category_id']) : (false);

if($category_id === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	$result = array();
	$parentID = $category_id;
	
	while ($parentID != NULL){
		$categoryInfo = getParentInfo($databaseConnection, $parentID);
		$justIDAndName = array ("category_id" => $categoryInfo["category_id"], "name" => $categoryInfo["name"]);
		array_unshift($result, $justIDAndName);
        $parentID = $categoryInfo["parent"];
    }
		
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>