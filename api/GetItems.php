<?php
/*
Input (1 optional GET parameter): category_id
Process: If category_id is not specified, select all items.  if it is, select only items in that category
Output: If category_id is not specified, returns al items, otherwise, returns only items in that category or its subcategories
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

function getChildCategoryItems($databaseConnection, $category_id) {
    if (!is_numeric($category_id))
    {
        $emptyArray = array();
        return $emptyArray;
    }
    else
    {
        $query = "SELECT * FROM categories WHERE parent = '$category_id' ";
        $data = $databaseConnection->query($query);
       	$result = array();

		if ($data->num_rows > 0) {
				while ($row =$data->fetch_assoc()){
					$result = array_merge($result, getItemsInCategory($databaseConnection, $row["category_id"]));
					$result = array_merge($result, getChildCategoryItems($databaseConnection, $row["category_id"]));
				}
		}
		return $result;
    }
        
}

function getItemsInCategory($databaseConnection, $category_id) {
    if (!is_numeric($category_id))
    {
		$emptyArray = array();
        return $emptyArray;
    }
    else
    {
		$result = array();
        $query = "SELECT I.*, C.name FROM items I, categories C WHERE I.category_id = '$category_id' AND I.category_id = C.category_id";
		$data = $databaseConnection->query($query);
	
		if ($data->num_rows > 0 ) {
	
			$result = array();
			while ($row =$data->fetch_assoc()){
				$result[] = $row;
			}	
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

//If no category_id specified, return all items
if($category_id === false) {
	$query = "SELECT I.*, C.name FROM items I, categories C WHERE C.category_id = I.category_id ";
	$data = $databaseConnection->query($query);

	if ($data->num_rows > 0) {

		$result = array();
		while ($row =$data->fetch_assoc()){
			$result[] = array_map('utf8_encode', $row);
		}
		
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode($result);
		exit;
		
	} else  {
		SendSingleError(HTTP_BAD_REQUEST, 'no items exist', ERRTXT_FAILED);	
	}
	
// Category_id is specified, only return items from that category and subcategories
} else {
	
	$result = array();

	$result = array_merge($result, getItemsInCategory($databaseConnection, $category_id));	
	$result = array_merge($result, getChildCategoryItems($databaseConnection, $category_id));
		
	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>