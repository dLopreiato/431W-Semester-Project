$(document).ready(function() {
	displayInfo();
});

function displayInfo(){
	
    var sendData = {};
	
	var urlUsername = $.urlParam('username');
	
	if (urlUsername != ""){
		sendData = {username: urlUsername};
	}
		
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetSeller.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
			console.log(data);
				addInfo(data.name, data.point_of_contact, data.address, data.phone);
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

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	if (results == null){
		return "";
	}
	else{
		return results[1];
	}
}

function addInfo(name, pointOfContact, address, phoneNumber) {

	var appendString = '<div class="jumbotron">';
    appendString += '<h2>Seller Name: ' + name + '</h2><br><p>Point of contact: ' + pointOfContact + '</p>';
	appendString += '<p>Address: ' + address +  '</p><p>Phone Number: ' + phoneNumber + '</p></div>';
  
   $('#info').append(appendString);
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}