<?php

// error for when there is an issue with connecting to the MySQL database
define('ERRTXT_DBCONN_FAILED', 'A connection error has occurred. Contact the administrator.');

// error for unauthorized user
define('ERRTXT_UNATHORIZED', 'You are unauthorized to perform this action. Request permission from the administrator to continue.');

// error for when a variable is not set that needs to be set
define('ERRTXT_UNSETVARIABLE', 'A fatal error has occurred on this page. Contact the administrator.');

// error for when a query fails
define('ERRTXT_FAILED_QUERY', 'Something went wrong with your request. Go back and try again. If you keep getting this error, contact the administrator.');

// error for when the id of something does not exist
define('ERRTXT_ID_NOT_FOUND', 'This resource does not exist. Please go back and try again. If you keep getting this error, contact the administrator.');

?>
