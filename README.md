# 431W Semester Project

Just download and point your local server to the proper directory.

# Configuration

Create a file called "config.php" in the _api_ directory and paste the following into it, with the correct fields.

```php
<?php

// the place where the homepage can be accessed on this server
define("HOME_DIRECTORY", 'localhost');

// use top level exception handler (puts the exceptions in a format that is consistent with the api)
// to truly work, the api_error_functions page must be included
define("OVERRIDE_EXCEPTION_HANDLING", TRUE);

// database connection credentials
define("MYSQL_HOST", '');
define("MYSQL_USER", '');
define("MYSQL_PASS", '');
define("MYSQL_DBNAME", '');
define("MYSQL_CHARSET", 'utf8mb4_general_ci');
define("MYSQL_DATE_FORMAT", 'Y-m-d H:i:s');
?>

```

Create a file called "config.js" in the _js_ directory and paste the following into it, with the correct fields.

```js
var ROOT_DIRECTORY = "";
```
