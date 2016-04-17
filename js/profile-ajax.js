$(document).ready(function() {
    var sendData = {username:$.urlParam('username');};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetUserBadges.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',

        success: function(data) {
            // data is array of username, badge_id, units_earned, last updated
            if (!data) {
                displayGeneralUserError('You currently have earned no badges.');
            }
            else {
                $.each(data, function (i, item) {
                    addBAdgeToTable(item.badge_id, item.units_earned, item.last_updated);
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}
});

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    return results[1] || 0;
}

function addBadgeToTable(badgeID, unitsEarned, lastUpdated) {
    var appendString = '<tr id="' + badgeID + '"><td>' + unitsEarned + '</td><td>' + lastUpdated + '</td></tr>';
    $('#earned-badges tbody').append(appendString);
}