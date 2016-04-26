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

// we're doing this for badges
session_start();

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables

$term = (isset($_GET['term'])) ? ($_GET['term']) : (false);


// Check for Data
if($term === false) {
	SendSingleError(HTTP_BAD_REQUEST, "bad term.", ERRTXT_ID_NOT_FOUND);
} else {
    $term = strtolower($term);
    $rentalFlag = false;
    $bidFlag = false;
    $saleFlag = false;
    if (!(strpos($term, '-rental') === false)) {
        $rentalFlag = true;
        $term = str_replace('-rental', '', $term);
    }
    if (!(strpos($term, '-sale') === false)) {
        $saleFlag = true;
        $term = str_replace('-sale', '', $term);
    }
    if (!(strpos($term, '-bid') === false)) {
        $bidFlag = true;
        $term = str_replace('-bid', '', $term);
    }
    $term = trim($term);

	$query = "SELECT I.item_id, I.description, I.image, I.category_id, C.name FROM items I, categories C"
        . (($rentalFlag) ? (', rentables R') : (''))
        . (($bidFlag) ? (', auctioned_by A') : (''))
        . (($saleFlag) ? (', sold_by S') : (''))

        . " WHERE C.category_id = I.category_id AND I.description LIKE '%$term%'"
        . (($rentalFlag) ? (' AND I.item_id=R.item_id AND R.on_shelf=1') : (''))
        . (($bidFlag) ? (' AND I.item_id=A.item_id AND A.number_in_stock>0') : (''))
        . (($saleFlag) ? (' AND I.item_id=S.item_id AND S.number_in_stock>0') : (''));

	if($result = $databaseConnection->query( $query)) { // If query was successful
        if (isset($_SESSION['username'])) {
            // badge 4 (inspector gadget)
            $username = $_SESSION['username'];
            $badgeQuery = "INSERT INTO badge_progresses (username, badge_id, units_earned, last_updated) VALUES ('$username', 4, 1, NOW())";
            $databaseConnection->query($badgeQuery);
        }

        $content = array();
        while ($row = $result->fetch_assoc()) {
            $content[] = $row;
        }
		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
    	echo json_encode($content);
    	exit;
    } else {
        SendSingleError(HTTP_INTERNAL_ERROR, /*'failed to complete purchase transaction.'*/$databaseConnection->error, ERRTXT_FAILED_QUERY);
    }

}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>