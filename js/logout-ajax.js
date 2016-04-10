$(document).ready(function() {
    logoutCurrentUser();
});

function logoutCurrentUser() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/Logout.php'
    });
}