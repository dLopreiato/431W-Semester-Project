$(document).ready(function() {
	displayHeading();
	populateBadges();
});

function displayHeading(){
	
	var username = $.urlParam('username');
	var appendString = "";
	
	if (username == ""){
		appendString = '<h1 class="media-heading">My Badges</h1>'; 
	}
	else{
		appendString = '<h1 class="media-heading">' + $.urlParam('username') + '\'s Badges</h1>';
	}
	$('#name-heading').append(appendString);
}

function populateBadges(){
	
    var sendData = {};
	
	var urlUsername = $.urlParam('username');
	
	if (urlUsername != ""){
		sendData = {username: urlUsername};
	}
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetUserBadges.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            // data is array of username, badge_id, units_earned, last updated
            if (data.length == 0) {
				showNoBadges();
            }
            else {
                $.each(data, function (i, item) {
                   addBadgeToTable(item.badge_id, item.units_earned, item.total_units, item.last_updated, item.title, item.icon, item.description);
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

function showNoBadges(){
	var appendString = '<h4>Sorry, you haven\'t earned any badges yet.  Try making some more purchases and coming back later!</h4>';
    $('#earned-badges').append(appendString);
}


$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	if (results == null){
		return "";
	}
	else{
		return results[1];
	}
}

function addBadgeToTable(badgeID, unitsEarned, totalUnits, lastUpdated, badgeTitle, badgeImage, badgeDescription) {
	
	var percentage = (unitsEarned/totalUnits) * 100;
	
    var appendString = '<div class="media"><div class="media-left media-middle"><a href="#"><img class="media-object" src="' + badgeImage + '" alt="' + badgeTitle + '" width="200" height="200"></a></div><div class="media-body">';
	
	appendString += '<h3 class="media-heading">' + badgeTitle + '</h3><br><p>' + badgeDescription + '</p><p>' + unitsEarned + '/' + totalUnits + ' Complete </p><p>Last Updated: ' + lastUpdated;
	appendString += '</p><div class="progress"><div class="';
	
	if (percentage < 100){
		appendString += 'progress-bar progress-bar-info';
	}
	else{
		appendString += 'progress-bar progress-bar-success';
	}
	
	appendString +='" role="progressbar" aria-valuenow="' + percentage + '" aria-valuemin="0" aria-valuemax="100" style="width:' + percentage + '%">';
	appendString += '<span class="sr-only">' + percentage + '% Complete</span></div></div></div></div>';
	
    $('#earned-badges').append(appendString);
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}