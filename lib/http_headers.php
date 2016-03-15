<?php

/* Content Headers */
// header for api responses
define('API_RESPONSE_CONTENT', 'Content-Type: text/plain; charset=utf-8');
// header for downloadable responses: FILENAME MUST BE CONCATENATED TO THE END OF THIS
define('FILE_RESPONSE_CONTENT', 'Content-Disposition: attachment; filename=');
// header for csv responses
define('CSV_RESPONSE_CONTENT', 'Content-Type: text/csv; charset=utf-8');


/* Status codes */
// response for good input
define('HTTP_OK', 'HTTP/1.1 200 OK');

// error for bad input
define('HTTP_BAD_REQUEST', 'HTTP/1.1 400 Bad Request');

// error for unauthorized
define('HTTP_UNAUTHORIZED', 'HTTP/1.1 401 Unauthorized');

// error for object with this id does not exist
define('HTTP_NOT_FOUND', 'HTTP/1.1 404 Not Found');

// error for something went wrong on the inside
define('HTTP_INTERNAL_ERROR', 'HTTP/1.1 500 Internal Server Error');

?>
