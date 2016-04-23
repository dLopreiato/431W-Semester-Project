$(document).ready(function() {
    populateTable();
});

function populateTable() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetSellerItems.php',
        dataType: 'json',
        success: function(data) {
			$.each(data, function (i, item) {
				addItemToTable(item.item_id, item.description, item.location, item.name);
			});
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

function addItemToTable(itemID, description, location, category){
	
	var appendString = '<tr id="' + itemID + '"><td><a href="product.html?id=' + itemID +  '">' + description + '</a></td><td>' + location +  '</td><td>' + category + '</td>';
	appendString +=  '<td><a href="post_listing.html?id=' + itemID  + '" class="btn btn-default" role="button"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a></td>';
	appendString += '</tr>';
	
	$('#user-items tbody').append(appendString);
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}