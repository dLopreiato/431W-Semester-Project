$(document).ready(function() {
    setActiveUserInfo();
});

function setActiveUserInfo() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetActiveUserInfo.php',
        dataType: 'json',
        success: function(data) {
            if (data != false) {
                $('#navbar-links').append('<li><a href="logout.html">Logout</a></li>');
                $('#navbar-links').append('<li><a href="#">' + data['name'] + '</a></li>');
            }
            else {
                $('#navbar-links').append('<li><a href="login.html">Login</a></li>');
                $('#navbar-links').append('<li><a href="register.html">Register</a></li>');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}

function submitSearch() {
    var searchTerm = $('input:text[name=searchBar]').val();
    window.location.href = PROTOCOL + ROOT_DIRECTORY + '/search_results.html?term=' + searchTerm;
}